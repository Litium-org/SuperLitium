render = {}

vrampallete = require 'src.core.virtualization.nx_vramPallete'
render.wireframeMode = false
wireframe = "fill"

function render.drawCall(spritetbl, x, y, scale)
    pallete = vrampallete.pallete

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
                return
            else
                if scale > 20 then
                    return
                else
                    love.graphics.setColor(r, g, b, a)
                    love.graphics.rectangle(wireframe, x + (xp * scale), y + (yp * scale), scale, scale)
                end
            end
        end
    end
end

function render.rectangle(type, x, y, w, h, colorid)
    pallete = vrampallete.pallete
    r,g,b,a = love.math.colorFromBytes(pallete[colorid][1], pallete[colorid][2], pallete[colorid][3], pallete[colorid][4])
    love.graphics.setColor(r, g, b, a)
    love.graphics.rectangle(type, x, y, w, h)
end

return render