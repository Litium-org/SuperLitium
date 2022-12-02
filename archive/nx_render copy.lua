Render = {}

local vrampallete = require 'src.core.virtualization.nx_vramPallete'
Render.wireframeMode = false
local wireframe = "fill"

function Render.drawCall(spritetbl, x, y, scale)
    local pallete = vrampallete.pallete

    local colors = pallete
    -- wireframe for debug --
    if Render.wireframeMode then
        wireframe = "line"
    else
        wireframe = "fill"
    end

    for yp = 1, #spritetbl do
        for xp = 1, #spritetbl[1] do
            color = colors[spritetbl[yp][xp]]
            r, g, b, a = love.math.colorFromBytes(color[1], color[2], color[3], color[4])
            if yp > 24 or xp > 24 then
                return
            else
                if scale > 20 then
                    return
                else
                    love.graphics.setColor(r, g, b, a)
                    love.graphics.rectangle(wireframe, x + (xp * scale), y + (yp * scale), scale, scale)
                    return x, y, scale
                end
            end
        end
    end
end

function Render.rectangle(type, x, y, w, h, colorid)
    pallete = vrampallete.pallete
    r,g,b,a = love.math.colorFromBytes(pallete[colorid][1], pallete[colorid][2], pallete[colorid][3], pallete[colorid][4])
    love.graphics.setColor(r, g, b, a)
    love.graphics.rectangle(type, x, y, w, h)
end

return Render