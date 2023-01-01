litsave = {}

local storage = require 'src.core.virtualization.drivers.nx_storage-dvr'

--- Write to a save slot based on it tag
---@param savename string
---@param data table
---@return string @Sucess or error message
function litsave.saveData(savename, data)
    storage.saveData(savename, data)
end

--- Get content from saved slot
---@param savename string
---@return table
function litsave.loadSavedata(savename)
    return storage.loadData(savename)
end

--- Check if a save data exists
---@param savename string
function litsave.isSaveExist(savename)
    return storage.saveExist(savename)
end

return litsave