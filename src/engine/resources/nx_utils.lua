utils = {}

function utils.exist(type, filename)
    if type == "file" then
        if getInfo(filename) ~= nil then
            return true
        else
            return false
        end
    end

    if type == "directory" or type == "folder" or type == "dir" then
        if getInfo(filename) ~= nil then
            return true
        else
            return false
        end
    end
end


function utils.saveDirectory()
    return love.filesystem.getSaveDirectory()
end

return utils