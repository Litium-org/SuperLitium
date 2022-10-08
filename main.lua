function love.load()
    love.keyboard.setKeyRepeat(true)
    installer           = require 'src.engine.resources.nx_installer'
    litiumapi           = require 'src.API.nx_litiumAPI'
    cartloader          = require 'src.core.virtualization.nx_cartloader'
    bios                = require 'src.engine.system.nx_bios'
    switch              = require 'libraries.switch'
    nativelocks         = require 'src.core.misc.nx_nativelocks'


    print("         SuperLitium")


    --https               = require 'libraries.https'

    -- lock some commands XDDD
    nativelocks.lock()

    -- main thread for install folders and system components
    installer.install()

    -- cartdrive initialization
    cartdata = bios.init()

    -- call init function
    pcall(cartdata(), init())
end

function love.draw()
    love.graphics.clear()
    pcall(cartdata(), render())
end

function love.update(elapsed)
    pcall(cartdata(), update(elapsed))
end
