vram = {}

render = require 'src.core.render.nx_render'
text = require 'src.core.render.nx_text'

-- the video memory --
buffer = {
    sprites = {},
    background = {
        sprites = {},
        rectangles = {}
    },
    text = {}
}

-- retrive window info --

vram.screen = {
    width = love.graphics.getWidth(),
    height = love.graphics.getHeight(),
    BgColor = 1
}

-----------------------------------------------------
-- builtin function XD --
-----------------------------------------------------

function findByTag(tag)
    for k, addr in pairs(buffer.sprites) do
        if addr.tag == tag then
            return buffer.sprites[k]
        end
    end
    --return nil
end


-----------------------------------------------------
    -- Object management functions
-----------------------------------------------------

function vram.addSprite(sprite, x, y, scale, tag)
    Sprite = {
        texture = sprite,
        x = x,
        y = y,
        scale = scale
    }
    if tag ~= nil then
        Sprite.tag = "$" .. string.sub(tag, 1, 4)
    end
    table.insert(buffer.sprites, Sprite)
end

function vram.addBgRect(type, x, y, w, h, color)
    BgObject = {
        type = type,
        x = x,
        y = y,
        w = w,
        h = h,
        color = color
    }

    table.insert(buffer.background.rectangles, BgObject)
end

function vram.addBgSprite(sprite, x, y, scale)
    BgObject = {
        sprite = sprite,
        x = x,
        y = y,
        scale = scale
    }

    table.insert(buffer.background.sprites, BgObject)
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
    vram.screen.BgColor = id
end

-----------------------------------------------------
    --  Buffers callbacks --
-----------------------------------------------------

function vram.renderSpriteBuffer()
    for k, sprdata in pairs(buffer.sprites) do
        render.drawCall(buffer.sprites[k].texture, sprdata.x, sprdata.y, sprdata.scale)
    end
end

function vram.renderBackgroundRectsBuffer()
    for k, bgElement in pairs(buffer.background.rectangles) do
        render.rectangle(bgElement.type, bgElement.x, bgElement.y, bgElement.w, bgElement.h, bgElement.color)
    end
end

function vram.renderBackgroundSpritesBuffer()
    for k, bgElement in pairs(buffer.background.sprites) do
        render.drawCall(buffer.background.sprites[k].sprite, bgElement.x, bgElement.y, bgElement.scale)
    end
end

function vram.renderTextBuffer()
    for k, txtdata in pairs(buffer.text) do
        text.drawStr(txtdata.string, txtdata.x, txtdata.y, txtdata.scale, txtdata.color1, txtdata.color2)
    end
end

function vram.renderBackgroundColor()
    render.rectangle("fill", 0, 0, vram.screen.width, vram.screen.height, vram.screen.BgColor)
end

-----------------------------------------------------
-- other VRAM functions
-----------------------------------------------------

function vram.clear()
    love.graphics.clear()
    for vdata = #buffer.sprites, 1, -1 do
        if #buffer.sprites > 20 then
            table.remove(buffer.sprites, vdata)
        end
    end
    for bgSprites = #buffer.background.sprites, 1, -1 do
        if #buffer.background.sprites > 20 then
            table.remove(buffer.background.sprites, bgSprites)
        end
    end
    for bgRects = #buffer.background.rectangles, 1, -1 do
        if #buffer.background.rectangles > 30 then
            table.remove(buffer.background.rectangles, bgRects)
        end
    end
    for txtData = #buffer.text, 1, -1 do
        if #buffer.text > 14 then
            table.remove(buffer.text, txtData)
        end
    end
end

-----------------------------------------------------
-- entity control --
-----------------------------------------------------

function vram.transformObject(tag, x, y, scale)
    obj = findByTag("$" .. tag)
    if obj == nil then
        return false
    else
        obj.x = x
        obj.y = y
    end
end


return vram