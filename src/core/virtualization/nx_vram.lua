vram = {}

render = require 'src.core.render.nx_render'
text = require 'src.core.render.nx_text'

buffer = {
    sprites = {},
    background = {},
    text = {}
}

-- retrive window info --

vram.screen = {
    width = love.graphics.getWidth(),
    height = love.graphics.getHeight()
}


-----------------------------------------------------
    -- Object management functions
-----------------------------------------------------

function vram.addSprite(sprite, x, y, scale, tag, pallete)
    Sprite = {
        texture = sprite,
        x = x,
        y = y,
        scale = scale,
        pallete = pallete
    }
    if tag ~= nil then
        Sprite.tag = "$" .. string.sub(tag, 1, 4)
    end

    print(Sprite.tag)
    table.insert(buffer.sprites, Sprite)
end

function vram.addBgObject(x, y, w, h, sprite)
    
end

function vram.addText(text, x, y, scale, txtcolor, bgcolor)
    Text = {
        string = text,
        x = x,
        y = y,
        scale = scale,
        color1 = txtcolor,
        color2 = bgcolor
    }
    print(Text.string)
    table.insert(buffer.text, Text)
end

function vram.sceneColor(id)
    render.rectangle("fill", 0, 0, vram.screen.width, vram.screen.height)
end

-----------------------------------------------------
    --  Buffers callbacs --
-----------------------------------------------------

function vram.renderSpriteBuffer()
    for k, sprdata in pairs(buffer.sprites) do
        render.drawCall(buffer.sprites[k].texture, sprdata.x, sprdata.y, sprdata.scale, sprdata.activePallete)
    end
end

function vram.renderBackgroundBuffer()
    for k, bgElement in pairs(buffer.background) do
    
    end
end

function vram.renderTextBuffer()
    for k, txtdata in pairs(buffer.text) do
        print(txtdata.string)
        text.drawStr(txtdata.string, txtdata.x, txtdata.y, txtdata.scale, txtdata.color1, txtdata.color2)
    end
end

-----------------------------------------------------
-- other VRAM functions
-----------------------------------------------------

function vram.clear()
    for vdata = #buffer.sprites, 1, -1 do
        if #buffer.sprites > 10 then
            table.remove(buffer.sprites, vdata)
        end
    end
    for bgData = #buffer.background, 1, -1 do
        if #buffer.background > 30 then
            table.remove(buffer.background, bgData)
        end
    end
    for txtData = #buffer.text, 1, -1 do
        if #buffer.text > 14 then
            table.remove(buffer.text, txtData)
        end
    end
end

return vram