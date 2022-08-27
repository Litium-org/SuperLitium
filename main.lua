function love.load()
    installer = require 'src.engine.resources.nx_installer'
    litiumapi = require 'src.API.nx_litiumAPI'
    render = require 'src.core.render.nx_render'

    nxfirmware = {
        cartloader = require 'src.core.virtualization.nx_cartloader',
        bios = require 'src.engine.system.nx_BIOS'
    }

    -- NXHardware API, for virtual hardware component comunications
    nxhardapi = {
        vram = require 'src.core.virtualization.nx_vram',
        debug = require 'src.debug.nx_debug',
        vramPallete = require 'src.core.virtualization.nx_vramPallete'
    }

    -- main thread for install folders and system components (system not available now)
    installer.install()
    nxfirmware.bios.init()
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
    nxfirmware.bios.update()
end
