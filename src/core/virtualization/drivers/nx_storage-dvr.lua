storage = {}

local json = require 'libraries.json'
require 'libraries.json-beautify'
local basexx = require 'libraries.basexx'
local lualzw = require 'libraries.luazlw'
local debug = require 'src.debug.nx_debug'


storage.diskdata = {}       -- this where all file data will be stored, to be modified
storage.listItems = {}
storage.maxTxtY = 60
storage.text = "no save data was found."

local function findSaveByTag(tag)
    if tag == nil then
        return
    else
        if storage.diskdata.partitions == nil then
            return nil
        else
            for k, savename in pairs(storage.diskdata.partitions) do
                if savename.savename == tag then
                    return k
                end
            end
        end
    end
end

function storage.saveExist(tag)
    id = findSaveByTag(tag)
    if id ~= nil then
        return true
    else
        return false
    end
end

local function getEngineVersion()   
    return love.filesystem.read(".litversion")
end


local function doLoad()
    if storage.diskdata ~= nil then
        local slotfile = love.filesystem.read("data/slotdata.slf")
        local raw1 = lualzw.decompress(slotfile)
        local raw2 = basexx.from_z85(raw1)
        local raw3 = basexx.from_base64(raw2)
        local raw4 = basexx.from_base32(raw3)
        storage.diskdata = json.decode(raw4)
    end
end

local function doSave(id)
    -- write to file --
    local slotfile = io.open(love.filesystem.getSaveDirectory() .. "/data/slotdata.slf", "w+")
    local jsonraw = json.encode(storage.diskdata)
    local crypt1 = basexx.to_base32(jsonraw)
    local crypt2 = basexx.to_base64(crypt1)
    local crypt3 = basexx.to_z85(crypt2)
    local crypt4 = lualzw.compress(crypt3)
    slotfile:write(crypt4)
    slotfile:close()
end

local function getSavename()
    for i = 1, #storage.diskdata.partitions, 1 do
        table.insert(storage.listItems, storage.diskdata.partitions[i].savename)
    end
end

function storage.init()
    local data = {
        diskname = "superlitium memory disk",
        meta = {
            lastEngineVersion = getEngineVersion(),
            createdData = tostring(os.date()),
            partition = "SLP-stucture",
        },
        partitions = {}
    }
    slotFileInfo = love.filesystem.getInfo("data/slotdata.slf")
    print(slotFileInfo)
    if slotFileInfo == nil then
        local slotfile = love.filesystem.newFile("data/slotdata.slf", "w")
        local saveEncode = json.encode(data)
        local crypt1 = basexx.to_base32(saveEncode)
        local crypt2 = basexx.to_base64(crypt1)
        local crypt3 = basexx.to_z85(crypt2)
        local crypt4 = lualzw.compress(crypt3)
        slotfile:write(crypt4)
        slotfile:close()
    end
    doLoad()
    getSavename()
end

function storage.saveData(tag, tablecontent)
    slotFileInfo = love.filesystem.getInfo("data/slotdata.slf")
    -- do the data repalce --
    saveData = {
        savename = tag,
        savedate = os.date(),
        data = tablecontent
    }
    saveid = findSaveByTag(tag)
    if storage.saveExist(tag) then
        table.remove(storage.diskdata.partitions, saveid)
    end
    table.insert(storage.diskdata.partitions, saveData)

    local slotfile = io.open(love.filesystem.getSaveDirectory() .. "/data/slotdata.slf", "w+")
    local jsonraw = json.encode(storage.diskdata)
    local crypt1 = basexx.to_base32(jsonraw)
    local crypt2 = basexx.to_base64(crypt1)
    local crypt3 = basexx.to_z85(crypt2)
    local crypt4 = lualzw.compress(crypt3)
    slotfile:write(crypt4)
    slotfile:close()

    --print(debug.showTableContent(storage.diskdata))
end

function storage.loadData(tag)
    id = findSaveByTag(tag)
    if id ~= nil then
        return storage.diskdata.partitions[id].data
    else
        print("invalid name")
    end
end

function storage.saveExist(tag)
    local id = findSaveByTag(tag)
    if id ~= nil then
        return true
    else
        return false
    end
end

-- functions for internal use --
function storage.renderPage(PageOffset)
    local txty = 60
    if #storage.diskdata.partitions ~= 0 then
        for a = PageOffset, 20 + PageOffset, 1 do
            if storage.diskdata.partitions[a] ~= nil then
                litiumapi.litgraphics.newText(storage.diskdata.partitions[a].savename, 60, txty, 3, 3, 1)
                txty = txty + 30
            end
        end
        storage.maxTxtY = txty
    else
        litiumapi.litgraphics.newText(storage.text, 60, 60, 3, 3, 1)
    end
end

function storage.getSaveInfo(id)
    if #storage.diskdata.partitions > 0 then
        return {
            savename = storage.diskdata.partitions[id].savename,
            savedate = storage.diskdata.partitions[id].savedate
        }
    end
end

function storage.export()
    local slotfile = love.filesystem.read("data/slotdata.slf")
    local raw1 = lualzw.decompress(slotfile)
    local raw2 = basexx.from_z85(raw1)
    local raw3 = basexx.from_base64(raw2)
    local raw4 = basexx.from_base32(raw3)
    local jsonData = json.decode(raw4)

    local exportedFile = love.filesystem.newFile("data/exportedData.json", "w")
    exportedFile:write(json.beautify(jsonData, {
        newline = "\n",
        indent = "\t",
        depth = 0,
    }))
    exportedFile:close()
end

function storage.deleteSave(id)
    if storage.diskdata ~= nil then
        for svid = 1, #storage.diskdata.partitions, 1 do
            if svid == id then
                table.remove(storage.diskdata.partitions, svid)
                local slotfile = io.open(love.filesystem.getSaveDirectory() .. "/data/slotdata.slf", "w+")
                local jsonraw = json.encode(storage.diskdata)
                local crypt1 = basexx.to_base32(jsonraw)
                local crypt2 = basexx.to_base64(crypt1)
                local crypt3 = basexx.to_z85(crypt2)
                local crypt4 = lualzw.compress(crypt3)
                slotfile:write(crypt4)
                slotfile:close()
            end
        end
    end
end

return storage