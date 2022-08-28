bios = {}

cartloader = require 'src.core.virtualization.nx_cartloader'
bootup = false
loadingMode = false
ms = 0

savedir = love.filesystem.getSaveDirectory()

local gameData

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

function load()
    -- look for current active cartdrive --
    bootFile = io.open(saveDir .. "/.boot", "r")
    cartname = bootFile:read("*a")

    if cartname == "" then
        return nil
    else
        return cartname
    end
end

function bios.init()
    bootup = true
    gameData = load()
end

function bios.update(dt)
    if bootup then
        ms = ms + 1
    end
    if bootup then
        if ms == 70 then
            litiumapi.litgraphics.newText("litium-org project", 10, 20, 5, 3, 1)
            litiumapi.litgraphics.newSprite(litlogo, 1110, 20, 10, "logo")
        end
        if ms == 130 then
            litiumapi.litgraphics.newText("Checking for disks...", 10, 60, 5, 3, 1)
        end
        if ms == 270 then
            if gameData == nil then
                litiumapi.litgraphics.newText("booting to Lunis", 10, 110, 5, 3, 1)
            end
        end
        if ms == 370 then

            if gameData == nil then
                data = cartloader.loadCart("disks/A/lunis/boot.lua")
                pcall(data(), init())
            else
                cartloader.loadCart("carts/" .. cartname .. "boot.lua")
                loadingMode = true
                pcall(data(), init())
            end
        end
    end
end

return bios