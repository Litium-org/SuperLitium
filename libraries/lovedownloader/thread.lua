	downloadURL, filename, DOWNLOADER_PATH = ...
	
	require("love.filesystem")
	local http = require(DOWNLOADER_PATH..".http")
	local ltn12 = require("ltn12")	

	
	
	local download_channel = love.thread.getChannel("download "..downloadURL)
	local control_channel = love.thread.getChannel("downloadcont "..downloadURL)
	local count = 0
	local size = 0
	local err = nil
	local stopped = false
	local content = {}
	
	
	function customPump(source,sink)
	
		local value = control_channel:pop()  
		if value then
			if value.id == "stop" then   -- Stop download
				stopped = true
				return nil
			end
		end
		
		
		count = count + 1
		
		
		local per
		local downloaded
		if size > 0 then
			per = math.min((2048*count)/size, 1)
			downloaded = math.min(count*2048, size)
		else
			per = 0
			downloaded = count*2048
		end
		download_channel:push({id="update", per=per, count = downloaded, size = size})
		
		return ltn12.pump.step(source,sink)
	end
	
	function hCallback(header)
		size = tonumber(header['content-length'] or 0)
		download_channel:push({id="update", per=0, count = 0, size = size})
	end
	
	function downloadToFile(dllink, name)
	   local nfile = love.filesystem.newFile(name)
	   nfile:open('w')
	   local lsink = ltn12.sink.file(nfile)
	   local f, e, h = http.request{
		  url = dllink,
		  sink = lsink,
		  step = customPump,
		  headerCallback = hCallback
	   }
	   nfile:close()
	   return f, e, h
	end
	
	function downloadToString(dllink)
		local lsink = ltn12.sink.table(content)
		local f, e, h = http.request{
			url = dllink,
			sink = lsink,
			step = customPump,
			headerCallback = hCallback
		}
		return f, e, h
	end
	

	local f, e, h
	
	if filename then
		f, e, h = downloadToFile(downloadURL, filename);
	else
		f, e, h = downloadToString(downloadURL);
		download_channel:push({id="content", value=table.concat(content)})
	end
	
	
	if stopped then
		download_channel:supply({id = "stopped"})
	elseif e == 200 then
		if size == 0 then
			local downloaded
			if filename then
				local file = love.filesystem.newFile(filename)
				file:open("c")
				downloaded = file:getSize()
			else
				downloaded = (count-2)*2048 + content[#content]:len()
			end
			download_channel:push({id="update", per=1, count = downloaded, size = size})
		end
		download_channel:supply({id = "success"})
	elseif (f == nil and e) or e ~= 200 then
		download_channel:supply({id = "error", desc = e})
	else
		download_channel:supply({id = "error", desc = "unknown"})
	end

