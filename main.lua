function love.load()
    love.keyboard.setKeyRepeat(true)
    installer           = require 'src.engine.resources.nx_installer'
    litiumapi           = require 'src.API.nx_litiumAPI'
    render              = require 'src.core.render.nx_render'
    cartloader          = require 'src.core.virtualization.nx_cartloader'
    bios                = require 'src.engine.system.nx_bios'
    nativelocks         = require 'src.core.misc.nx_nativelocks'

    -- NXHardware API, for virtual hardware component comunications
    nxhardapi = {
        vram            = require 'src.core.virtualization.nx_vram',
        debug           = require 'src.debug.nx_debug'
    }
    -- lock some commands XDDD
    nativelocks.lock()

    -- main thread for install folders and system components (system not available now)
    installer.install()

    -- cartdrive initialization
    cartdata = bios.init()
    
    pcall(cartdata(), create())
end

function love.draw()
    nxhardapi.vram.clear()
    nxhardapi.vram.renderBackgroundColor()
    nxhardapi.vram.renderBackgroundSpritesBuffer()
    nxhardapi.vram.renderBackgroundRectsBuffer()
    nxhardapi.vram.renderTextBuffer()
    nxhardapi.vram.renderSpriteBuffer()
end

function love.update(elapsed)
    pcall(cartdata(), update(elapsed))
    --print(a)
end