litgraphics = {}

vramPallete = require 'src.core.virtualization.nx_vramPallete'

---Create a new Object and can be transformed in Memory
---@param sprite table      @ The table with sprite code
---@param x number          @ X position for place sprite
---@param y number          @ Y position for place sprite
---@param scale number      @ Scale of pixels
---@param tag string        @ This tag is used to locate object in memory and change parameters
function litgraphics.newSprite(sprite, x, y, scale, tag)
    nxhardapi.vram.addSprite(sprite, x, y, scale, tag)
end

--- Create new rectangle (Used for background elements)
---@param filltype string   @ Determine how the box will be filled ("Fill" or "Line")
---@param x number          @ set X postion for the rectangle
---@param y number          @ set Y postion for the rectangle
---@param w number          @ set the width of the rectangle
---@param h number          @ set the height of the rectangle
---@param colorid number    @ set the rectangle color (1-17)
function litgraphics.rect(filltype, x, y, w, h, colorid)
    nxhardapi.vram.addBgRect(filltype, x, y, w, h, colorid)
end

--- Create a new sprite but place as background
---@param sprite table      @ The table with sprite code
---@param x number          @ X position for place sprite
---@param y number          @ Y position for place sprite
---@param scale number      @ Sprite pixel scale
function litgraphics.newBackgroundSprite(sprite, x, y, scale)
    nxhardapi.vram.addBgSprite(sprite, x, y, scale)
end

--- Change the background color
---@param id number     @ Color id based on 1-17 available colors
function litgraphics.backgroundColor(id)
    nxhardapi.vram.sceneColor(id)
end

--- Create a new text
---@param string string     @ Text you want display
---@param x number          @ set the X position of text
---@param y number          @ set the Y position of text
---@param scale number      @ set the Pixel scale of text
---@param txtColor number   @ set the text color (1-17)
---@param BgColor number    @ set the background of the text color (1-17)
---@param Tag string        @ This tag is used to locate object in memory and change parameters
function litgraphics.newText(string, x, y, scale, txtColor, BgColor, tag)
    nxhardapi.vram.addText(string, x, y, scale, txtColor, BgColor, tag)
end

--- Change the default color pallete
---@param colorTable table  @ Table with colors in RGBA mode : {255,255,255,255}
function litgraphics.changePallete(colorTable)
    love.graphics.clear()
    if #colorTable > 17 then
        print("Pallete can't be higher than 17 colors at same time")
        love.event.quit()
    else
        print("color changed")
        vramPallete.pallete = colorTable
    end
end

--- Delete all objects on screen (Sprites, Text objects and background elements)
function litgraphics.removeAll()
    nxhardapi.vram.removeAll()
end

--- Return screen width
---@return number @ Window width
function litgraphics.windowWidth()
    return nxhardapi.vram.screen.width
end

--- Return screen height
---@return number @ Window height
function litgraphics.windowHeight()
    return nxhardapi.vram.screen.height
end

return litgraphics