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
        slotfile = love.filesystem.read("data/slotdata.slf")
        raw1 = basexx.from_z85(slotfile)
        raw2 = basexx.from_base64(raw1)
        raw3 = basexx.from_base32(raw2)
        storage.diskdata = json.decode(raw3)
    end
end

local function doSave(id)
    -- write to file --
    if #storage.diskdata.partitions < storage.diskdata.meta.allowedAllocation then
        slotfile = io.open(love.filesystem.getSaveDirectory() .. "/data/slotdata.slf", "w+")
        jsonraw = json.encode(storage.diskdata)
        crypt1 = basexx.to_base32(jsonraw)
        crypt2 = basexx.to_base64(crypt1)
        crypt3 = basexx.to_z85(crypt2)
        slotfile:write(crypt3)
        slotfile:close()
    end
end

local function getSavename()
    for i = 1, #storage.diskdata.partitions, 1 do
        table.insert(storage.listItems, storage.diskdata.partitions[i].savename)
    end
end

function storage.init()
    data = {
        diskname = "superlitium memory disk",
        meta = {
            lastEngineVersion = getEngineVersion(),
            createdData = tostring(os.date()),
            partition = "SLP-stucture",
        },
        partitions = {}
    }
    slotFileInfo = love.filesystem.getInfo("data/slotdata.slf")
    if slotFileInfo == nil then
        slotfile = love.filesystem.newFile("data/slotdata.slf", "w")
        saveEncode = json.encode(data)
        crypt1 = basexx.to_base32(saveEncode)
        crypt2 = basexx.to_base64(crypt1)
        crypt3 = basexx.to_z85(crypt2)
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
    saveid = findSaveByTag(tag)
    if saveExist(tag) then
        table.remove(storage.diskdata.partitions, saveid)
    end
    table.insert(storage.diskdata.partitions, saveData)

    slotfile = io.open(love.filesystem.getSaveDirectory() .. "/data/slotdata.slf", "w+")
    jsonraw = json.encode(storage.diskdata)
    crypt1 = basexx.to_base32(jsonraw)
    crypt2 = basexx.to_base64(crypt1)
    crypt3 = basexx.to_z85(crypt2)
    slotfile:write(crypt3)
    slotfile:close()

    --print(debug.showTableContent(storage.diskdata))
end

function storage.loadData(tag)
    id = findSaveByTag(tag)
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
    txty = 60
    if #storage.diskdata.partitions ~= 0 then
        for i = PageOffset, 15 + PageOffset, 1 do
            if storage.diskdata.partitions[i] ~= nil then
                litiumapi.litgraphics.newText(storage.diskdata.partitions[i].savename, 60, txty, 3, 3, 1)
                txty = txty + 30
            end
        end
    else
        litiumapi.litgraphics.newText("no save data was found.", 60, 60, 3, 3, 1)
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
    slotfile = love.filesystem.read("data/slotdata.slf")
    raw1 = basexx.from_z85(slotfile)
    raw2 = basexx.from_base64(raw1)
    raw3 = basexx.from_base32(raw2)
    jsonData = json.decode(raw3)

    exportedFile = love.filesystem.newFile("data/exportedData.json", "w")
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
                slotfile = io.open(love.filesystem.getSaveDirectory() .. "/data/slotdata.slf", "w+")
                jsonraw = json.encode(storage.diskdata)
                crypt1 = basexx.to_base32(jsonraw)
                crypt2 = basexx.to_base64(crypt1)
                crypt3 = basexx.to_z85(crypt2)
                slotfile:write(crypt3)
                slotfile:close()
            end
        end
    end
end

return storage