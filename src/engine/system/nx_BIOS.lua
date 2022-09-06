bios = {}

utils = require 'src.engine.resources.nx_utils'

function bios.init()
    -- look for boot file --
    print(utils.saveDirectory() .. "/.boot")
    bootfile = io.open(utils.saveDirectory() .. "/.boot", "r")
    cartname = bootfile:read()

    if cartname == nil then
        return cartloader.loadCart("system/boot.lua")
    else
        return cartloader.loadCart("carts/" .. cartname .. "/boot.lua")
    end
end

return bios