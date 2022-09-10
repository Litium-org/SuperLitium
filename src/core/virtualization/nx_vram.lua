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

function findSpriteByTag(tag)
    for k, addr in pairs(buffer.sprites) do
        if addr.tag == tag then
            return buffer.sprites[k], k
        end
    end
    --return nil
end

function findTextObjByTag(tag)
    for k, addr in pairs(buffer.text) do
        if addr.tag == tag then
            return buffer.text[k], k
        end
    end
end


-----------------------------------------------------
    -- Object management functions
-----------------------------------------------------

function vram.addSprite(sprite, x, y, scale, tag)
    Sprite = {
        texture = sprite,
        x = x,
        y = y,
        scale = scale,
        visible = true
    }
    if tag ~= nil then
        Sprite.tag = "$" .. string.sub(tag, 1, 8)
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

function vram.addText(text, x, y, scale, txtcolor, bgcolor, tag)
    Text = {
        string = text,
        x = x,
        y = y,
        scale = scale,
        color1 = txtcolor,
        color2 = bgcolor,
        visible = true
    }
    if tag ~= nil then
        Text.tag = "$" .. string.sub(tag, 1, 8)
    end
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
        if sprdata.visible == true then
            if sprdata.x < vram.screen.width or sprdata.y < vram.screen.height then
                render.drawCall(buffer.sprites[k].texture, sprdata.x, sprdata.y, sprdata.scale)
            end
        end
    end
end

function vram.renderBackgroundRectsBuffer()
    for k, bgElement in pairs(buffer.background.rectangles) do
        render.rectangle(bgElement.type, bgElement.x, bgElement.y, bgElement.w, bgElement.h, bgElement.color)
    end
end

function vram.renderBackgroundSpritesBuffer()
    for k, bgElement in pairs(buffer.background.sprites) do
        if bgElement.x < vram.screen.width or bgElement.y < vram.screen.height then
            render.drawCall(buffer.background.sprites[k].sprite, bgElement.x, bgElement.y, bgElement.scale)
        end
    end
end

function vram.renderTextBuffer()
    for k, txtdata in pairs(buffer.text) do
        if txtdata.visible == true then
            if txtdata.x < vram.screen.width or txtdata.y < vram.screen.height then
                text.drawStr(txtdata.string, txtdata.x, txtdata.y, txtdata.scale, txtdata.color1, txtdata.color2)
            end
        end
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
    obj = findSpriteByTag("$" .. tag)
    if obj == nil then
        return false
    else
        obj.x = x
        obj.y = y
        obj.scale = scale
    end
end

function vram.transformTextObject(tag, string, x, y, scale, colortxt, bgcolor)
    txt = findTextObjByTag("$" .. tag)
    if txt == nil then
        return false
    else
        txt.string = string
        txt.x = x
        txt.y = y
        txt.scale = scale
        txt.color1 = colortxt
        txt.color2 = bgcolor
    end
end

function vram.killSpr(tag)
    obj, k = findSpriteByTag("$" .. tag)
    table.remove(buffer.sprites, k)
end

function vram.removeAll()
    for vdata = #buffer.sprites, 1, -1 do
        table.remove(buffer.sprites, vdata)
    end
    for bgSprites = #buffer.background.sprites, 1, -1 do
        table.remove(buffer.background.sprites, bgSprites)
    end
    for bgRects = #buffer.background.rectangles, 1, -1 do
        table.remove(buffer.background.rectangles, bgRects)
    end
    for txtData = #buffer.text, 1, -1 do
        table.remove(buffer.text, txtData)
    end
end

function vram.setSpriteVisible(tag, visible)
    obj = findSpriteByTag("$" .. tag)
    obj.visible = visible
end

function vram.setTextVisible(tag, visible)
    txt = findTextObjByTag("$" .. tag)
    txt.visible = visible
end

function vram.removeText(tag)
    for k, v in pairs(buffer.text)  do
        if v.tag == tag then
            table.remove(buffer.text, buffer.text[k])
        end
    end
end

-----------------------------------------------------
-- conditional export --
-----------------------------------------------------

function vram.isSpriteVisible(tag)
    obj = findSpriteByTag("$" .. tag)

    if obj.visible == nil or obj.visible == false then
        return false
    else
        return true
    end
end

function vram.isTextVisible(tag)
    txt = findTextObjByTag("$" .. tag)

    if txt.visible == nil or txt.visible == false then
        return false
    else
        return true
    end
end

function vram.entityExist(tag)
    obj = findSpriteByTag("$" .. tag)

    if obj.x ~= nil then
        return false
    else
        return true
    end
end

-----------------------------------------------------
-- Private export --
-----------------------------------------------------

function vram.ListTags(type)
    if type == "sprite" or "spr" then
        tags = {}
        for k, spr in pairs(buffer.sprites) do
            if spr.tag ~= nil then
                table.insert(tags, spr.tag)
            end
        end
        return tags
    end
end

return vram