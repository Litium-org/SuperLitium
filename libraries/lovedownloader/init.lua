local DOWNLOADER_PATH = DOWNLOADER_PATH or ({...})[1]:gsub("[%.\\/]init$", "")
	--print("DOWNLOADER_PATH: "DOWNLOADER_PATH)

local DownFile = {}

function DownFile:new(downloadURL, filename, callbacks)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	
	--private
	o.thread = love.thread.newThread(DOWNLOADER_PATH.."/thread.lua")
	o.channel = love.thread.getChannel("download "..downloadURL)
	o.conchannel = love.thread.getChannel("downloadcont "..downloadURL)
	o.sctime = 0
	o.scbytes = 0
	
	o.callbacks = callbacks or {}
	
	
	--public
	o.downloadURL = downloadURL
	o.filename = filename
	
	o.progress = 0
	o.success = false
	o.error = nil
	o.stopped = false
	o.finished = false
	o.downloaded = 0
	o.size = 0
	o.speed = 0
	
	return o
end
function DownFile:start()
	self.thread:start(self.downloadURL, self.filename, DOWNLOADER_PATH)
end
function DownFile:update()
	if not self.error and self.thread:getError() then
		print(self.thread:getError())
		self.error = self.thread:getError()
	end
	local value = self.channel:pop()
	while value do
		if type(value) == "table" then
			if value.id == "update" then
				self.progress = value.per
				self.downloaded = value.count
				self.size = value.size
				
				if self.callbacks["update"] then self.callbacks["update"](self.progress, self.downloaded, self.size) end
				
			elseif value.id == "content" then
				self.content = value.value
				
				if self.callbacks["content"] then self.callbacks["content"](self.content) end
				
			elseif value.id == "success" then
				self.success = true
				
				if self.callbacks["success"] then self.callbacks["success"]() end
				
			elseif value.id == "error" then
				self.error = value.desc
				
				if self.callbacks["error"] then self.callbacks["error"](self.error) end
				
				print("Error: ".. self.error)
			elseif value.id == "stopped" then
				self.stopped = true
				
				if self.callbacks["stopped"] then self.callbacks["stopped"]() end
			end
		else
			print(value)
		end
		value = self.channel:pop()
	end
	
	if os.time() >= (self.sctime+1) then
		self.speed = self.downloaded - self.scbytes
	
		self.scbytes = self.downloaded
		self.sctime = os.time()
	end
	
	if not self.finished and (self.stopped or self.success or self.error) then
		self.finished = true
		
		if self.callbacks["finished"] then self.callbacks["finished"]() end
	end
end
function DownFile:stop()
	self.conchannel:push({id = "stop"})
end
	
local LOVEDownloader = {}

function LOVEDownloader.download(downloadURL, filename, callbacks)
	if type(filename) == "table" then
		callbacks = filename
		filename = nil
	end
	if not(type(downloadURL) == "string" and (type(filename) == "string" or filename == nil)) then
		error("invalid input")
	end
	return DownFile:new(downloadURL, filename, callbacks)
end


return LOVEDownloader