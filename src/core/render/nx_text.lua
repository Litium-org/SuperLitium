text = {}

setColor                =               love.graphics.setColor
rect = love.graphics.rectangle

font = require 'src.engine.resources.nx_font'
vrampallete = require 'src.core.virtualization.nx_vramPallete'

-- rendercore callback to generate string

text.wireframeMode = false
wireframe = "fill"


function text.drawText(Textstr, x, y, FontSize, txtColor, bgColorId)
    --textStr = text.splitLetters(str)
    local strNum = tostring(Textstr)
    local textOutput = string.lower(strNum)
    --letters = tostring([[abcdefghijklmnopqrstuvwxyz0123456789 !=$(),.:;+-/|<>?[]]])
    local letterSize = font.FontLetterSize
    local textX = x
    local textY = y
    for i = 1, #Textstr do
        char = textOutput:sub(i, i)
        draw(font[char], textX, textY, FontSize, txtColor, bgColorId)

        textX = textX + (FontSize * letterSize)
    end
end

function draw(spritetbl, x, y, scale, TextColorID, BackgroundColorID)

    local colorsBG = vrampallete.pallete
    local colorsText = vrampallete.pallete

    -- wireframe for debug --
    if text.wireframeMode then
        wireframe = "line"
    else
        wireframe = "fill"
    end

    for yp = 1, #spritetbl do
		for xp = 1, #spritetbl[1] do
            if spritetbl[yp][xp] == 0 then
                if BackgroundColorID == nil then
                    setColor(0, 0, 0, 0)
                else
                    r, g, b, a = love.math.colorFromBytes(
                        colorsBG[BackgroundColorID][1], 
                        colorsBG[BackgroundColorID][2], 
                        colorsBG[BackgroundColorID][3], 
                        colorsBG[BackgroundColorID][4]
                    )
                    setColor(r, g, b, a)
                end
            else
                r, g, b = love.math.colorFromBytes(
                    colorsText[TextColorID][1],
                    colorsText[TextColorID][2],
                    colorsText[TextColorID][3]
                )
                setColor(r, g, b)
            end
            rect(wireframe, x + (xp * scale), y + (yp * scale), scale, scale)
		end
	end
end

return text