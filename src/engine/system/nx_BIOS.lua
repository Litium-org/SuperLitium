bios = {}

utils = require 'src.engine.resources.nx_utils'

function bios.init()
    -- look for boot file --
    bootfile = io.open(utils.saveDirectory() .. "/.boot", "r")
    cartname = bootfile:read()
    tempFile = love.filesystem.getInfo(".boot.tmp")

    if cartname == nil and tempFile == nil then
        return cartloader.loadCart("tests/test.lua")
        --return cartloader.loadCart("system/boot.lua")
    elseif tempFile ~= nil then
        return cartloader.loadCart("system/command/boot.lua")
    else
        romSize = love.filesystem.getInfo("carts/" .. cartname .. "/boot.lua", "file")
        if romSize.size < 131072 then
            return cartloader.loadCart("carts/" .. cartname .. "/boot.lua")            
        end
    end
end

function bios.getFileName()
    bootfile = io.open(utils.saveDirectory() .. "/.boot", "r")
    cartname = bootfile:read()
    return cartname
end

return bios