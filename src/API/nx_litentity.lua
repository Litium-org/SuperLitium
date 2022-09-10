litentity = {}

--- Change some object properties using a Tag (Address)
---@param tag string    @ Adress of object 
---@param x number      @ new X position
---@param y number      @ new Y position
---@param scale number  @ new Scale for pixels
function litentity.transform(tag, x, y, scale)
    nxhardapi.vram.transformObject(tag, x, y, scale)
end

--- Transform text object properties baes on tag (Address)
---@param tag string
---@param string string
---@param x number
---@param y number
---@param scale number
---@param colortxt number
---@param bgcolor number
function litentity.transformText(tag, string, x, y, scale, colortxt, bgcolor)
    nxhardapi.vram.transformTextObject(tag, string, x, y, scale, colortxt, bgcolor)
end

--- Kill sprite using it tag
---@param tag string
function litentity.killSprite(tag)
    nxhardapi.vram.killSpr(tag)
end

--- Destroy text object based on tag
---@param tag string
function litentity.destroyText(tag)
    nxhardapi.vram.removeText(tag)
end

--- Check if entity exist based on it tag (only for sprites)
---@param tag string
function litentity.entityExist(tag)
    nxhardapi.vram.entityExist(tag)    
end

return litentity