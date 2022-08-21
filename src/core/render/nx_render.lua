render = {}

vrampallete = require 'src.core.virtualization.nx_vramPallete'

pallete = vrampallete.pallete

render.wireframeMode = false
wireframe = "fill"

function render.drawCall(spritetbl, x, y, scale)
    colors = pallete
    -- wireframe for debug --
    if render.wireframeMode then
        wireframe = "line"
    else
        wireframe = "fill"
    end

    for yp = 1, #spritetbl do
        for xp = 1, #spritetbl[1] do
            color = colors[spritetbl[yp][xp]]
            r, g, b, a = love.math.colorFromBytes(color[1], color[2], color[3], color[4])
            if yp > 16 or xp > 16 then
                return nil
            else
                love.graphics.push()
                love.graphics.setColor(r, g, b, a)
                love.graphics.rectangle(wireframe, x + (xp * scale), y + (yp * scale), scale, scale)
                love.graphics.pop()
            end
        end
    end
end

function render.rectangle(type, x, y, w, h, colorid)
    r,g,b,a = love.math.colorFromBytes(defaultColors[1], defaultColors[2], defaultColors[3], defaultColors[4])
    love.graphics.push()
        love.graphics.setColor(r, g, b, a)
        love.graphics.rectangle(type, x, y, w, h)
    love.graphics.pop()
end

return render