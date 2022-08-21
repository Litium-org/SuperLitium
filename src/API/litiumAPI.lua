litiumapi = {}


-- litium graphics --
litiumapi.litgraphics = {}

function litiumapi.litgraphics.newSprite(sprite, x, y, scale, tag)
    vram.addSprite(sprite, x, y, scale, tag)
end

function litiumapi.litgraphics.rect(x, y, w, h, colorid)

end

function litiumapi.litgraphics.backgroundColor(id)
    vram.sceneColor(id)
end

function litiumapi.litgraphics.newText(string, x, y, scale, txtColor, BgColor)
    vram.addText(string, x, y, scale, txtColor, BgColor)
end

function litiumapi.litgraphics.windowWidth()
    return vram.screen.width
end

function litiumapi.litgraphics.windowHeight()
    return vram.screen.height
end


-- Litium Debug --
litiumapi.litdebug = {}

function litiumapi.litdebug.viewWireframe(bool)
    render.wireframeMode = bool
    text.wireframeMode = bool
end


-- Litium System --
litiumapi.system = {}

function litiumapi.system.setTitle(title)
    love.window.setTitle(title)
end


-- Litium Entity --

litiumapi.litentity = {}

function litiumapi.litentity.setEntityPos(tag, x, y)
    
end

return litiumapi