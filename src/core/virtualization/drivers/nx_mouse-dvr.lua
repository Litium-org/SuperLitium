mousedvr = {}

function mousedvr.getMousePos()
    x = love.mouse.getX()
    y = love.mouse.getY()
    return x, y 
end

function mousedvr.isButtonDown(id)
    return love.mouse.isDown(id)
end

return mousedvr