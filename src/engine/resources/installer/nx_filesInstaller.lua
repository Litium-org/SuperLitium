fileinstaller = {}

utils = require 'src.engine.resources.nx_utils'

local filesToInstall = {
    ".boot",
}

function fileinstaller.install()
    -- main disk locate from bios -- 
    for f = 1, #filesToInstall, 1 do
        if not utils.exist("file", filesToInstall[f]) then
            local file = love.filesystem.newFile(filesToInstall[f], "w")
            file:close()
        end
    end
end

return fileinstaller