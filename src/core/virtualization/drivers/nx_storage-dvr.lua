storage = {}

json = require 'libraries.json'
base64 = require 'libraries.base64'
utils = require 'src.engine.resources.nx_utils'

storage.slots = {}

function storage.createSlot(slotTag)
    Slot = {
        tag = string.sub(slotTag, 1, 8),
        registeredSize = 65536,
    }

    if #storage.slots > 5 then
        return 'Maximum slot reached : 5'
    else
        if #storage.slots >= 0 then
            slotId = 1
        else
            slotId = #storage.slots
        end
        slotFile, errorstr = love.filesystem.newFile("data/slot_" .. slotId .. ".lds", "w")
        Slot.filepath = "data/slot_" .. slotId .. ".lds"
        slotFile:close()
        table.insert(storage.slots, Slot)
        return 'sucess'
    end
end

function storage.writeToSlot(slotTag, tableContent)
    -- get the slot tag id --
    for k, slot in pairs(storage.slots) do
        if slot.tag == slotTag then
            SlotFile = love.filesystem.getInfo(storage.slots[k].filepath, "file")
            if SlotFile.size > slot.registeredSize then
                return nil
            else
                jsonEncodeData = json.encode(tableContent)
                jsonCrypto = base64.encode(jsonEncodeData)
                jsonCrypt = base64.encode(jsonCrypto)
                love.filesystem.write(storage.slots[k].filepath, jsonCrypt)
            end
        else
            return "You can't write to save, create a save first"
        end
    end
end

function storage.getFromSlot(slotTag)
    for k, slot in pairs(storage.slots) do
        if slot.tag == slotTag then
            raw = love.filesystem.read(storage.slots[k].filepath)
            print(raw)
            cryptoRaw = base64.decode(raw)
            jsonRaw = base64.decode(cryptoRaw)
            data = json.decode(jsonRaw)
            return data
        end
    end
end

return storage