Storage = {}

json = require 'libraries.json'
basexx = require 'libraries.basexx'
luazlw = require 'libraries.luazlw'
utils = require 'src.engine.resources.nx_utils'
bios = require 'src.engine.system.nx_bios'

Storage.slots = {}

--------------------------------------------------------------------------------
-- Functions for saving and loading system
--------------------------------------------------------------------------------
function Storage.createSlot(slotTag)
    Slot = {
        tag = string.sub(slotTag, 1, 20),
        registeredSize = 262144,
    }

    if #Storage.slots > 5 then
        return 'Maximum slot reached : 5'
    else
        if #Storage.slots >= 0 then
            slotId = 1
        else
            slotId = #Storage.slots
        end
        slotFile, errorstr = love.filesystem.newFile("bin/data/slot_" .. slotId .. ".lds", "w")
        Slot.filepath = "bin/data/slot_" .. slotId .. ".lds"
        slotFile:close()
        table.insert(Storage.slots, Slot)
        return 'sucess'
    end
end

function Storage.slotExist(slotTag)
    for k, slot in pairs(Storage.slots) do
        if slot.tag == slotTag then
            SlotFile = love.filesystem.getInfo(Storage.slots[k].filepath, "file")
            if SlotFile == nil then
                return false
            else
                return true
            end
        end
    end
end

function Storage.writeToSlot(slotTag, tableContent)
    -- get the slot tag id --
    for k, slot in pairs(Storage.slots) do
        if slot.tag == slotTag then
            SlotFile = love.filesystem.getInfo(Storage.slots[k].filepath, "file")
            if SlotFile.size > slot.registeredSize then
                return nil
            else
                jsonEncodeData = json.encode(tableContent)
                --------------------------------------------------------------------------------
                -- [ Old Method ] --
                --jsonCrypto = base64.encode(jsonEncodeData)
                --jsonCrypt = base64.encode(jsonCrypto)
                --------------------------------------------------------------------------------
                --jsonbase32 = basexx.to_base32(jsonEncodeData)
                --jsonbase64 = basexx.to_base64(jsonbase32)
                --jsonCrypt = basexx.to_z85(jsonbase64)
                love.filesystem.write(Storage.slots[k].filepath, jsonEncodeData)
            end
        else
            return "You can't write to save, create a save first"
        end
    end
end

function Storage.getFromSlot(slotTag)
    for k, slot in pairs(Storage.slots) do
        if slot.tag == slotTag then
            raw = love.filesystem.read(Storage.slots[k].filepath)
            --------------------------------------------------------------------------------
            -- [ Old Method ] --
            --cryptoRaw = base64.decode(raw)
            --jsonRaw = base64.decode(cryptoRaw)
            --data = json.decode(jsonRaw)
            --------------------------------------------------------------------------------
            --rawPhase1 = basexx.from_z85(raw)
            --rawPhase2 = basexx.from_base64(rawPhase1)
            --jsonRaw = basexx.from_base32(rawPhase2)
            data = json.decode(raw)
            return data
        end
    end
end


return Storage