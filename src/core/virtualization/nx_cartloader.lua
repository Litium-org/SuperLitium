cartloader = {}

function cartloader.loadBIOS()
    bios, error = love.filesystem.load("src/engine/system/nx_BIOS.lua")

    return bios
end

function cartloader.loadCart(cartname)
    cart, error = love.filesystem.load(cartname)

    return cart
end

return cartloader