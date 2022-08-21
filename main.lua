function love.load()
    litiumapi = require 'src.API.litiumAPI'
    render = require 'src.core.render.nx_render'
    nxhardapi = {
        vram = require 'src.core.virtualization.nx_vram',
        debug = require 'src.debug.debug',
        vramPallete = require 'src.core.virtualization.nx_vramPallete'
    }


    heart = {
        {1,6,1,6,1},
        {6,6,6,6,6},
        {6,6,6,6,6},
        {1,6,6,6,1},
        {1,1,6,1,1},
    }

    x = 100
    y = 200

    litiumapi.litgraphics.newSprite(heart, x, 190, 6, "hrt")
    --litiumapi.litgraphics.newSprite(heart, 110, 90, 6)
    --litiumapi.litgraphics.newSprite(heart, 210, 90, 6)
    --litiumapi.litgraphics.newSprite(heart, 310, 90, 6)
    --litiumapi.litgraphics.newSprite(heart, 410, 90, 6)
    --litiumapi.litgraphics.newSprite(heart, 510, 90, 6)
    --litiumapi.litgraphics.newSprite(heart, 610, 90, 6)
    --litiumapi.litgraphics.newSprite(heart, 710, 90, 6)
    --litiumapi.litgraphics.newSprite(heart, 810, 90, 6)
    --litiumapi.litgraphics.newSprite(heart, 910, 90, 6)

    litiumapi.litgraphics.newText("this is a test", 90, 90, 9, 6, 1)
end

function love.draw()
    love.graphics.clear()
    love.graphics.push()
        love.graphics.setColor(0.5, 0.5, 0.5)
        love.graphics.rectangle("fill", 0, 0, 1280, 768)
    love.graphics.pop()

    nxhardapi.vram.renderBackgroundBuffer()
    nxhardapi.vram.renderTextBuffer()
    nxhardapi.vram.renderSpriteBuffer()
end

function love.update(dt)
    nxhardapi.vram.clear()

    if love.keyboard.isDown("left") then
        x = x - 2
    end
    if love.keyboard.isDown("right") then
        x = x + 2
    end
    if love.keyboard.isDown("up") then
        y = y - 2
    end
    if love.keyboard.isDown("down") then
        y = y + 2
    end

    nxhardapi.vram.transformObject("hrt", x, y)
end

function love.keypressed( key, isrepeat )
    if key == "return" then
        test = {
            {255,0,0,255},	-- transparent
            {0,0,0},
            {255,255,255},
            {192,192,192},
            {128,128,128},
            {255,0,0},
            {128,0,0},
            {255,0,255},
            {128,0,128},
            {0,0,255},
            {0,0,128},
            {0,255,255},
            {0,128,128},
            {0,255,0},
            {0,128,0},
            {255,255,0},
            {128,128,0}
        }
        vramPallete.loadPallete(test)
    end
    if key == "o" then
        litiumapi.litgraphics.newSprite(heart, 90, 90, 6, "hrt")
    end
end
