bios = {}

cartloader = require 'src.core.virtualization.nx_cartloader'
bootup = false
ms = 0

savedir = love.filesystem.getSaveDirectory()

litlogo = {
    {1,1,3,3,3,3,3,1,1},
    {1,3,6,6,4,14,14,3,1},
    {3,6,6,3,5,14,14,14,3},
    {3,6,6,3,5,5,14,14,3},
    {3,4,5,3,5,5,5,4,3},
    {3,16,16,3,5,5,10,10,3},
    {3,16,16,3,3,3,10,10,3},
    {1,3,16,16,4,10,10,3,1},
    {1,1,3,3,3,3,3,1,1},
}

function bios.init()
    bootup = true
end

function bios.update(dt)
    if bootup then
        ms = ms + 1
    end
    if bootup then
        if ms == 70 then
            litiumapi.litgraphics.newText("litium-org project", 10, 20, 5, 3, 1)
            litiumapi.litgraphics.newSprite(litlogo, 980, 20, 10, "logo")
        end
        if ms == 130 then
            litiumapi.litgraphics.newText("Checking for disks...", 10, 60, 5, 3, 1)
        end
        if ms == math.random(250, 270) then
            print()
        end
    end
end

function load()
    -- look for current active cartdrive --
    bootFile = io.open(saveDir .. "/.boot", "*r")
    cartname = io.read("*a")
    if cartname == nil or cartname == "" then
        return nil
    else
        return cartname
    end
    
    --[[
    if cartname == "" or cartname == nil then
        cartloader.loadCart("carts/" .. cartname .. "/boot.lua")
    end
    ]]--
end

return bios