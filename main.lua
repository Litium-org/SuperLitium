function love.load()
    litiumapi = require 'src.API.nx_litiumAPI'
    render = require 'src.core.render.nx_render'
    nxhardapi = {
        vram = require 'src.core.virtualization.nx_vram',
        debug = require 'src.debug.debug',
        vramPallete = require 'src.core.virtualization.nx_vramPallete'
    }

    test = {
        {255,255,0,255},	-- transparent
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


    heart = {
        {1,6,1,6,1},
        {6,6,6,6,6},
        {6,6,6,6,6},
        {1,6,6,6,1},
        {1,1,6,1,1},
    }

    x = 100
    y = 200

    litiumapi.litgraphics.newSprite(heart, x, 230, 9, "hrt")

    litiumapi.litgraphics.newText("this is a test", 90, 90, 9, 6, 1)

    for i = 1, 20, 1 do
        nxhardapi.vram.addBgSprite(heart, x, 290, 6)
        x = x + 32
    end

    litiumapi.litgraphics.backgroundColor(4)

end

function love.draw()
    nxhardapi.vram.clear()
    nxhardapi.vram.renderBackgroundColor()
    nxhardapi.vram.renderBackgroundSpritesBuffer()
    nxhardapi.vram.renderBackgroundRectsBuffer()
    nxhardapi.vram.renderTextBuffer()
    nxhardapi.vram.renderSpriteBuffer()
end

function love.update(dt)

end
