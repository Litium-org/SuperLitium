storage = {}

json = require 'libraries.json'
basexx = require 'libraries.basexx'
luazlw = require 'libraries.luazlw'
utils = require 'src.engine.resources.nx_utils'
bios = require 'src.engine.system.nx_bios'

storage.slots = {}

--------------------------------------------------------------------------------
-- Functions for saving and loading system
--------------------------------------------------------------------------------
function storage.createSlot(slotTag)
    Slot = {
        tag = string.sub(slotTag, 1, 20),
        registeredSize = 262144,
    }

    if #storage.slots > 5 then
        return 'Maximum slot reached : 5'
    else
        if #storage.slots >= 0 then
            slotId = 1
        else
            slotId = #storage.slots
        end
        slotFile, errorstr = love.filesystem.newFile("bin/data/slot_" .. slotId .. ".lds", "w")
        Slot.filepath = "bin/data/slot_" .. slotId .. ".lds"
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
                --------------------------------------------------------------------------------
                -- [ Old Method ] --
                --jsonCrypto = base64.encode(jsonEncodeData)
                --jsonCrypt = base64.encode(jsonCrypto)
                --------------------------------------------------------------------------------
                jsonbase32 = basexx.to_base32(jsonEncodeData)
                jsonbase64 = basexx.to_base64(jsonbase32)
                jsonCrypt = basexx.to_z85(jsonbase64)
                compr = luazlw.compress(jsonCrypt)
                love.filesystem.write(storage.slots[k].filepath, compr)
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
            --------------------------------------------------------------------------------
            -- [ Old Method ] --
            --cryptoRaw = base64.decode(raw)
            --jsonRaw = base64.decode(cryptoRaw)
            --data = json.decode(jsonRaw)
            --------------------------------------------------------------------------------
            uncompr = luazlw.decompress(raw)
            rawPhase1 = basexx.from_z85(uncompr)
            rawPhase2 = basexx.from_base64(rawPhase1)
            jsonRaw = basexx.from_base32(rawPhase2)
            data = json.decode(jsonRaw)
            return data
        end
    end
end


return storage