installer = {}

utils = require 'src.engine.resources.nx_utils'
--Storage = require 'system.resources.nx_storage-dvr'
fileinstaller = require 'src.engine.resources.installer.nx_filesInstaller'

saveDir = love.filesystem.getSaveDirectory()
makeDir = love.filesystem.createDirectory

local folderToInstall = {
    "carts",
    "bin",
    "bin/temp",
    "bin/data",
    "bin/projects",
    "bin/server",
    --"bin/scripts",
    "data",
}

function verifyFolderExist()
    for folder = 1, #folderToInstall, 1 do
        if utils.exist("dir", folderToInstall[folder]) then
            print(folderToInstall[folder], "[Checked]")
        else
            print("file not exist")
            return false
        end
    end
    print("Files are installed")
end

function installFolders()
    for folder = 1, #folderToInstall, 1 do
        makeDir(folderToInstall[folder])
    end
end

function installer.install()
    v = verifyFolderExist()
    if v then
        print("no")
        return
    else
        installFolders()
        fileinstaller.install()
    end
end


return installer