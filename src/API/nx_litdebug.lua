litdebug = {}

--- Set render mode to Wireframe
---@param bool boolean      @ Enable or disable wireframe mode using boolean values
function litdebug.viewWireframe(bool)
    render.wireframeMode = bool
    text.wireframeMode = bool
end

return litdebug