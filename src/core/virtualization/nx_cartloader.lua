cartloader = {}

function cartloader.loadCart(cartname)
    local cart, error = love.filesystem.load(cartname)
    return cart
end

return cartloader