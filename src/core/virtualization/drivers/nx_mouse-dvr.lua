mousedvr = {}

function mousedvr.getMousePos()
    x = love.mouse.getX()
    y = love.mouse.getY()
    return x, y 
end

return mousedvr