fileinstaller = {}

function fileinstaller.install()
    -- main disk locate from bios -- 
    love.filesystem.newFile(".boot")
    love.filesystem.write(".boot", "")
end

return fileinstaller