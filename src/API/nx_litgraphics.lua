litgraphics = {}

vramPallete = require 'src.core.virtualization.nx_vramPallete'
Render = require 'src.core.render.nx_render'
text = require 'src.core.render.nx_text'

---Create a new Object and can be transformed in Memory
---@param sprite table      @ The table with sprite code
---@param x number          @ X position for place sprite
---@param y number          @ Y position for place sprite
---@param scale number      @ Scale of pixels
function litgraphics.newSprite(sprite, x, y, scale)
    Render.drawCall(sprite, x, y, scale)
end

--- Create new rectangle (Used for background elements)
---@param filltype string   @ Determine how the box will be filled ("Fill" or "Line")
---@param x number          @ set X postion for the rectangle
---@param y number          @ set Y postion for the rectangle
---@param w number          @ set the width of the rectangle
---@param h number          @ set the height of the rectangle
---@param colorid number    @ set the rectangle color (1-17)
function litgraphics.rect(filltype, x, y, w, h, colorid)
    Render.rectangle(filltype, x, y, w, h, colorid)
end

--- Change the background color
---@param id number     @ Color id based on 1-17 available colors
function litgraphics.backgroundColor(id)
    Render.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight(), id)
end

--- Create a new text
---@param string string     @ Text you want display
---@param x number          @ set the X position of text
---@param y number          @ set the Y position of text
---@param scale number      @ set the Pixel scale of text
---@param txtColor number   @ set the text color (1-17)
---@param BgColor number    @ set the background of the text color (1-17)
function litgraphics.newText(string, x, y, scale, txtColor, BgColor)
    text.drawStr(string, x, y, scale, txtColor, BgColor)
end

--- Change the default color pallete
---@param colorTable table  @ Table with colors in RGBA mode : {255,255,255,255}
function litgraphics.changePallete(colorTable)
    love.graphics.clear()
    if colorTable == nil then
        vramPallete.pallete = vramPallete.default
    else
        if #colorTable > 17 then
            print("Pallete can't be higher than 17 colors at same time")
            love.event.quit()
        else
            --print("color changed")
            vramPallete.pallete = colorTable
        end
    end
end

--- Return screen width
---@return number @ Window width
function litgraphics.windowWidth()
    return love.graphics.getWidth()
end

--- Return screen height
---@return number @ Window height
function litgraphics.windowHeight()
    return love.graphics.getHeight()
end

return litgraphics