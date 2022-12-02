resc = {}

resc.acceptedKeys = {
    "a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z",
    "0","1","2","3","4","5","6","7","8","9",
    "!","=","$","(",")",",",".",":",";","+","-","/","|","<",">","?","[","]",
    "space","backspace","return"
}

function resc.createProjects(projectName)
    -- init --
    local scriptText = [[
function _init()

end

function _render()
    
end

function _update(elapsed)
    
end

function _keydown(k, code)
    
end
    ]]

    -- create the folder structure --
    love.filesystem.createDirectory("bin/projects/" .. projectName)
    love.filesystem.createDirectory("bin/projects/" .. projectName .. "/sprites")
    love.filesystem.createDirectory("bin/projects/" .. projectName .. "/soundfiles")

    -- create the files --
    local script = love.filesystem.newFile("bin/projects/" .. projectName .. "/boot.lua", "w")
    script:write(scriptText)
    script:close()
end

function resc.deleteProjects(projectName)
    local spritefolder = love.filesystem.getDirectoryItems("bin/projects/" .. projectName .. "/sprites")
    local soundfolder = love.filesystem.getDirectoryItems("bin/projects/" .. projectName .. "/soundfiles")

    if #spritefolder > 0 then
        for sprfile = 1, #spritefolder, 1 do
            love.filesystem.remove("bin/projects/" .. projectName .. "/sprites/" .. spritefolder[spritefolder])
        end
    else
        love.filesystem.remove("bin/projects/" .. projectName .. "/sprites")
    end

    if #soundfolder > 0 then
        for sndfile = 1, #soundfolder, 1 do
            love.filesystem.remove("bin/projects/" .. projectName .. "/soundfiles/" .. soundfolder[sndfile])
        end
    else
        love.filesystem.remove("bin/projects/" .. projectName .. "/soundfiles")
    end

    local otherFiles = love.filesystem.getDirectoryItems("bin/projects/" .. projectName)

    if #otherFiles > 0 then
        for otherfiles = 1, #otherFiles, 1 do
            love.filesystem.remove("bin/projects/" .. projectName .. "/" .. otherFiles[otherfiles])
        end
    end

    if #spritefolder == 0 and #soundfolder == 0 then
        love.filesystem.remove("bin/projects/" .. projectName .. "/boot.lua")
        love.filesystem.remove("bin/projects/" .. projectName)
    end
end

return resc