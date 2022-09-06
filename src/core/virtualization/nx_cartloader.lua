cartloader = {}

function cartloader.loadCart(cartname)
    cart, error = love.filesystem.load(cartname)
    return cart
end

return cartloader