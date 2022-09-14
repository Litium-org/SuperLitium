installer = {}

utils = require 'src.engine.resources.nx_utils'
fileinstaller = require 'src.engine.resources.installer.nx_filesInstaller'

saveDir = love.filesystem.getSaveDirectory()
makeDir = love.filesystem.createDirectory

folderToInstall = {
    "carts",
    "bin",
    "disks",
    "data"
}

function verifyFolderExist()
    for folder = 1, #folderToInstall, 1 do
        if utils.exist("dir", saveDir .. folderToInstall[folder]) then
            return true
        else
            return false
        end
    end
end

function installFolders()
    for folder = 1, #folderToInstall, 1 do
        makeDir(folderToInstall[folder])
    end
end

function installer.install()
    if verifyFolderExist() then
        return
    else
        installFolders()
        fileinstaller.install()
    end
end


return installer