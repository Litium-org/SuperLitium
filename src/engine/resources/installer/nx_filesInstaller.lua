fileinstaller = {}

utils = require 'src.engine.resources.nx_utils'

function fileinstaller.install()
    -- main disk locate from bios -- 
    if not utils.exist("file", ".boot") then
        file = love.filesystem.newFile(".boot", "w")
        file:close()
    end
end

return fileinstaller