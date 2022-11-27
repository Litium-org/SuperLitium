storage = {}

json = require 'libraries.json'
require 'libraries.json-beautify'
basexx = require 'libraries.basexx'
debug = require 'src.debug.nx_debug'


storage.diskdata = {}       -- this where all file data will be stored, to be modified
storage.listItems = {}

local function findSaveByTag(tag)
    for k, savename in pairs(storage.diskdata.partitions) do
        if savename.savename == tag then
            return k
        end
    end
end

local function saveExist(tag)
    local id = findSaveByTag(tag)
    if id ~= nil then
        return true
    else
        return false
    end
end

local function getEngineVersion()
    local litfile = io.open(".litversion", "r")
    return litfile:read("*all")
end


local function doLoad()
    if storage.diskdata ~= nil then
        local slotfile = love.filesystem.read("data/slotdata.slf")
        local raw1 = basexx.from_z85(slotfile)
        local raw2 = basexx.from_base64(raw1)
        local raw3 = basexx.from_base32(raw2)
        storage.diskdata = json.decode(raw3)
        print(debug.showTableContent(storage.diskdata))
    end
end

local function doSave(id)
    -- write to file --
    if #storage.diskdata.partitions < storage.diskdata.meta.allowedAllocation then
        local slotfile = io.open(love.filesystem.getSaveDirectory() .. "/data/slotdata.slf", "w+")
        local jsonraw = json.encode(storage.diskdata)
        local crypt1 = basexx.to_base32(jsonraw)
        local crypt2 = basexx.to_base64(crypt1)
        local crypt3 = basexx.to_z85(crypt2)
        slotfile:write(crypt3)
        slotfile:close()
    end
end

local function getSavename()
    for k, saves in pairs(storage.diskdata.partitions) do
        table.insert(storage.listItems, storage.diskdata.partitions[k].savename)
    end
end

function storage.init()
    data = {
        diskname = "superlitium memory disk",
        meta = {
            lastEngineVersion = getEngineVersion(),
            createdData = tostring(os.date()),
            allowedAllocation = 60,
            partition = "SLP-stucture",
        },
        partitions = {}
    }
    slotFileInfo = love.filesystem.getInfo("data/slotdata.slf")
    if slotFileInfo == nil then
        local slotfile = love.filesystem.newFile("data/slotdata.slf", "w")
        local saveEncode = json.encode(data)
        local crypt1 = basexx.to_base32(saveEncode)
        local crypt2 = basexx.to_base64(crypt1)
        local crypt3 = basexx.to_z85(crypt2)
        slotfile:write(crypt3)
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
    if #storage.diskdata.partitions < storage.diskdata.meta.allowedAllocation then
        local saveid = findSaveByTag(tag)
        if saveExist(tag) then
            table.remove(storage.diskdata.partitions, saveid)
        end
        table.insert(storage.diskdata.partitions, saveData)

        local slotfile = io.open(love.filesystem.getSaveDirectory() .. "/data/slotdata.slf", "w+")
        local jsonraw = json.encode(storage.diskdata)
        local crypt1 = basexx.to_base32(jsonraw)
        local crypt2 = basexx.to_base64(crypt1)
        local crypt3 = basexx.to_z85(crypt2)
        slotfile:write(crypt3)
        slotfile:close()
    end
    --print(debug.showTableContent(storage.diskdata))
end

function storage.loadData(tag)
    local id = findSaveByTag(tag)
    if id ~= nil then
        return storage.diskdata.partitions[id].data
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
    if #storage.listItems ~= 0 then
        for i = PageOffset, #storage.listItems, 1 do
            litiumapi.litgraphics.newText(storage.listItems[i], 60, txty, 3, 3, 1)
            txty = txty + 30
        end
    else
        litiumapi.litgraphics.newText("no save data was found.", 60, 60, 3, 3, 1)
    end
end

function storage.export()
    local slotfile = love.filesystem.read("data/slotdata.slf")
    local raw1 = basexx.from_z85(slotfile)
    local raw2 = basexx.from_base64(raw1)
    local raw3 = basexx.from_base32(raw2)
    local jsonData = json.decode(raw3)

    exportedFile = love.filesystem.newFile("data/exportedData.json", "w")
    exportedFile:write(json.beautify(jsonData, {
        newline = "\n",
        indent = "\t",
        depth = 0,
    }))
    exportedFile:close()
end


function storage.update(elapsed)
    if #storage.listItems > 20 then
        table.remove(storage.listItems, #storage.listItems)
    end
end

function storage.deleteSave(id)
    if storage.diskdata ~= nil then
        for k, save in pairs(storage.diskdata.partitions) do
            table.remove(storage.diskdata.partitions, k)
        end
    end
end

return storage