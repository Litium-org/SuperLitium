-- Main API stack
litiumapi = {}

---The litium graphics module
litiumapi.litgraphics = {}

---Create a new Object and can be transformed in Memory
---@param sprite table      @ The table with sprite code
---@param x number          @ X position for place sprite
---@param y number          @ Y position for place sprite
---@param scale number      @ Scale of pixels
---@param tag string        @ This tag is used to locate object in memory and change parameters
function litiumapi.litgraphics.newSprite(sprite, x, y, scale, tag)
    vram.addSprite(sprite, x, y, scale, tag)
end

--- Create new rectangle (Used for background elements)
---@param filltype string   @ Determine how the box will be filled ("Fill" or "Line")
---@param x number          @ set X postion for the rectangle
---@param y number          @ set Y postion for the rectangle
---@param w number          @ set the width of the rectangle
---@param h number          @ set the height of the rectangle
---@param colorid number    @ set the rectangle color (1-17)
function litiumapi.litgraphics.rect(filltype, x, y, w, h, colorid)
    vram.addBgRect(filltype, x, y, w, h, colorid)
end

--- Create a new sprite but place as background
---@param sprite table      @ The table with sprite code
---@param x number          @ X position for place sprite
---@param y number          @ Y position for place sprite
---@param scale number      @ Sprite pixel scale
function litiumapi.litgraphics.newBackgroundSprite(sprite, x, y, scale)
    vram.addBgSprite(sprite, x, y, scale)
end

--- Change the background color
---@param id number     @ Color id based on 1-17 available colors
function litiumapi.litgraphics.backgroundColor(id)
    vram.sceneColor(id)
end

--- Create a new text
---@param string string     @ Text you want display
---@param x number          @ set the X position of text
---@param y number          @ set the Y position of text
---@param scale number      @ set the Pixel scale of text
---@param txtColor number   @ set the text color (1-17)
---@param BgColor number    @ set the background of the text color (1-17)
function litiumapi.litgraphics.newText(string, x, y, scale, txtColor, BgColor)
    vram.addText(string, x, y, scale, txtColor, BgColor)
end

--- Return screen width
---@return number @Window width
function litiumapi.litgraphics.windowWidth()
    return vram.screen.width
end

--- Return screen height
---@return number @Window height
function litiumapi.litgraphics.windowHeight()
    return vram.screen.height
end


---Litium Debug
litiumapi.litdebug = {}

--- Set render mode to Wireframe
---@param bool boolean
function litiumapi.litdebug.viewWireframe(bool)
    render.wireframeMode = bool
    text.wireframeMode = bool
end


---Litium System
litiumapi.system = {}

--- Change the window title
---@param title string      @ The new title
function litiumapi.system.setTitle(title)
    love.window.setTitle(title)
end


---Litium entity control module
litiumapi.litentity = {}

--- Change some object properties using a Tag (Adress)
---@param tag string    @ Adress of object 
---@param x number      @ new X position
---@param y number      @ new Y position
---@param scale number  @ new Scale for pixels
function litiumapi.litentity.transform(tag, x, y, scale)
    vram.transformObject(tag, x, y, scale)
end

return litiumapi