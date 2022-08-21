text = {}

setColor                =               love.graphics.setColor
rect = love.graphics.rectangle

font = require 'src.engine.resources.nx_font'

-- rendercore callback to generate string

text.wireframeMode = false
wireframe = "fill"


function text.drawStr(Textstr, x, y, FontSize, txtColor, bgColorId)
    --textStr = text.splitLetters(str)
    strNum = tostring(Textstr)
    textOutput = string.lower(strNum)

    --letters = tostring([[abcdefghijklmnopqrstuvwxyz0123456789 !=$(),.:;+-/|<>?[]]])
    letterSize = font.FontLetterSize

    textX = x
    textY = y

    for i = 1, #Textstr do

        char = textOutput:sub(i, i) -- this gets the current letter of whatever number we are in the loop

        --num = letters:find(char) -- this returns the position of char in our letters string.
        --print(char, num, #font[char])
        draw(font[char], textX, textY, FontSize, txtColor, bgColorId)

        textX = textX + (FontSize * letterSize)
    end
end

function draw(spritetbl, x, y, scale, TextColorID, BackgroundColorID)
    colorsBG = {
        {0,0,0,0},	-- transparent
        {0,0,0},
        {255,255,255},
        {192,192,192},
        {128,128,128},
        {255,0,0},
        {128,0,0},
        {255,0,255},
        {128,0,128},
        {0,0,255},
        {0,0,128},
        {0,255,255},
        {0,128,128},
        {0,255,0},
        {0,128,0},
        {255,255,0},
        {128,128,0}
    }
    
    colorsText = {
        {0,0,0},
        {255,255,255},
        {192,192,192},
        {128,128,128},
        {255,0,0},
        {128,0,0},
        {255,0,255},
        {128,0,128},
        {0,0,255},
        {0,0,128},
        {0,255,255},
        {0,128,128},
        {0,255,0},
        {0,128,0},
        {255,255,0},
        {128,128,0}
    }

    -- wireframe for debug --
    if render.wireframeMode then
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
                    r, g, b, a = love.math.colorFromBytes(colorsBG[BackgroundColorID][1], colorsBG[BackgroundColorID][2], colorsBG[BackgroundColorID][3], colorsBG[BackgroundColorID][4])
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