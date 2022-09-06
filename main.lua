function love.load()
    love.keyboard.setKeyRepeat(true)
    installer           = require 'src.engine.resources.nx_installer'
    litiumapi           = require 'src.API.nx_litiumAPI'
    render              = require 'src.core.render.nx_render'
    cartloader          = require 'src.core.virtualization.nx_cartloader'
    bios                = require 'src.engine.system.nx_bios'

    -- NXHardware API, for virtual hardware component comunications
    nxhardapi = {
        vram            = require 'src.core.virtualization.nx_vram',
        debug           = require 'src.debug.nx_debug',
    }

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
end

function love.keypressed(k, scancode, isRepeat)
    if k == "-" then
        if isRepeat then
            nxhardapi.debug.showCurrentColorPallete(true)
        else
            nxhardapi.debug.showCurrentColorPallete(false)
        end
    end
end
