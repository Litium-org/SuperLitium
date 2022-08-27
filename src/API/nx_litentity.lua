litentity = {}

--- Change some object properties using a Tag (Adress)
---@param tag string    @ Adress of object 
---@param x number      @ new X position
---@param y number      @ new Y position
---@param scale number  @ new Scale for pixels
function litentity.transform(tag, x, y, scale)
    vram.transformObject(tag, x, y, scale)
end

return litentity