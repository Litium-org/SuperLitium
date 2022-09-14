litsave = {}

storage = require 'src.core.virtualization.drivers.nx_storage-dvr'

--- Create a save file (.lds file)
---@param savename string
---@return string @ sucess or error message
function litsave.newSaveSlot(savename)
    storage.createSlot(savename)
end

--- Write to a save slot based on it tag
---@param savename string
---@param data table
---@return string @Sucess or error message
function litsave.saveToSlot(savename, data)
    storage.writeToSlot(savename, data)
end

--- Get content from saved slot
---@param savename string
---@return table
function litsave.returnSaveData(savename)
    return storage.getFromSlot(savename)
end

return litsave