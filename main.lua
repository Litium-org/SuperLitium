function love.load()
    love.keyboard.setKeyRepeat(true)
    stringx             = require 'pl.stringx'
    installer           = require 'src.engine.resources.nx_installer'
    litiumapi           = require 'src.API.nx_litiumAPI'
    keyboard            = require 'src.core.virtualization.drivers.nx_keyboard-dvr'
    cartloader          = require 'src.core.virtualization.nx_cartloader'
    bios                = require 'src.engine.system.nx_bios'
    settings            = require 'system.resources.nx_settings'
    switch              = require 'libraries.switch'
    storage             = require 'src.core.virtualization.drivers.nx_storage-dvr'
    nativelocks         = require 'src.core.misc.nx_nativelocks'


    print("-=[ SuperLitium ]=-")


    --https               = require 'libraries.https'

    -- lock some commands XDDD
    nativelocks.lock()

    -- main thread for install folders and system components
    installer.install()

    -- cartdrive initialization
    cartdata = bios.init()

    -- create storage file 
    storage.init()

    -- call init function
    pcall(cartdata(), _init())
end

function love.draw()
    love.graphics.clear()
    pcall(cartdata(), _render())
    love.graphics.push()
        love.graphics.setColor(0, 0, 0, (0.1 * settings.getValue("c_brightness") - 0.1))
        love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    love.graphics.pop()
end

function love.update(elapsed)
    pcall(cartdata(), _update(elapsed))
end

function love.keypressed(k)
    for key, value in pairs(keyboard.keys) do
        if value == k then
            pcall(cartdata(), _keydown(k))
        end
    end
end
