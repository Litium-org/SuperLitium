function love.load()
    litiumapi = require 'src.API.litiumAPI'
    render = require 'src.core.render.nx_render'
    nxhardapi = {
        vram = require 'src.core.virtualization.nx_vram',
        debug = require 'src.debug.debug'
    }


    heart = {
        {1,6,1,6,1},
        {6,6,6,6,6},
        {6,6,6,6,6},
        {1,6,6,6,1},
        {1,1,6,1,1},
    }


    litiumapi.litgraphics.newSprite(heart, 10, 90, 6, "hrt")
    litiumapi.litgraphics.newSprite(heart, 110, 90, 6)
    litiumapi.litgraphics.newSprite(heart, 210, 90, 6)
    litiumapi.litgraphics.newSprite(heart, 310, 90, 6)
    litiumapi.litgraphics.newSprite(heart, 410, 90, 6)
    litiumapi.litgraphics.newSprite(heart, 510, 90, 6)
    litiumapi.litgraphics.newSprite(heart, 610, 90, 6)
    litiumapi.litgraphics.newSprite(heart, 710, 90, 6)
    litiumapi.litgraphics.newSprite(heart, 810, 90, 6)
    litiumapi.litgraphics.newSprite(heart, 910, 90, 6)

    litiumapi.litgraphics.newText("this is a test", 90, 90, 9, 6, 1)
end

function love.draw()
    love.graphics.clear()
    love.graphics.push()
    love.graphics.setColor(0.5, 0.5, 0.5)
    love.graphics.rectangle("fill", 0, 0, 1280, 768)
    love.graphics.pop()
    --render.drawCall(heart, 90, 90, 3)
    nxhardapi.vram.renderBackgroundBuffer()
    nxhardapi.vram.renderTextBuffer()
    --text.drawStr("test string", 90, 90, 7, 4, 4)
    nxhardapi.vram.renderSpriteBuffer()
end

function love.update(dt)
    nxhardapi.vram.clear()
end
