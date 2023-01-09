bios = {}

utils = require 'src.engine.resources.nx_utils'

function bios.init()
    -- look for boot file --
    cartname = tostring(love.filesystem.read(".boot"))
    tempFile = love.filesystem.getInfo("bin/temp/.boot.tmp")


    if cartname == "" and tempFile == nil then
        --return cartloader.loadCart("tests/test.lua")
        return cartloader.loadCart("system/boot.lua")
    elseif tempFile ~= nil then
        return cartloader.loadCart("system/command/boot.lua")
    -- part for apps --
    elseif cartname == "__gamelib" then
        return cartloader.loadCart("system/resources/apps/app.gamelib/boot.lua")
    elseif cartname == "__savemngr" then
        return cartloader.loadCart("system/resources/apps/app.save/boot.lua")
    elseif cartname == "__lang" then
        return cartloader.loadCart("system/resources/apps/app.language/boot.lua")
    elseif cartname == "___outdated" then
        return cartloader.loadCart("system/resources/apps/sys.outdated/boot.lua")
    elseif cartname == "__config" then
        return cartloader.loadCart("system/resources/apps/app_settings/boot.lua")
    else
    -- load a real game --
        romSize = love.filesystem.getInfo("carts/" .. cartname .. "/boot.lua")
        if romSize.size < 131072 then
            return cartloader.loadCart("carts/" .. cartname .. "/boot.lua")            
        end
    end
end

function bios.getFileName()
    cartname = love.filesystem.read(".boot")
    return cartname
end

return bios