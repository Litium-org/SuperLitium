function love.load()
    litiumapi = require 'src.API.nx_litiumAPI'
    render = require 'src.core.render.nx_render'
    nxhardapi = {
        vram = require 'src.core.virtualization.nx_vram',
        debug = require 'src.debug.debug',
        vramPallete = require 'src.core.virtualization.nx_vramPallete'
    }
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
