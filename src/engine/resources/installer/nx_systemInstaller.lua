systeminstaller = {}

folderToInstall = {
    "disks/A/lunis",
    "disks/A/lunis/system"
}

filesToInstall = {
    "disks/A/lunis/boot.lua",
    "disks/A/lunis/.version",
}

function installFolders()
    for folder = 1, #folderToInstall, 1 do
        love.filesystem.createDirectory(folderToInstall[folder])
    end
end

function installFiles()
    for file = 1, #filesToInstall, 1 do
        love.filesystem.newFile(filesToInstall[file])
    end
end

function systeminstaller.install()
    installFolders()
    fileinstaller()
end

return systeminstaller