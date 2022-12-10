function love.load()
    love.keyboard.setKeyRepeat(true)
    love.setDeprecationOutput(false)
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

    local joysticks = love.joystick.getJoysticks()
	joystick = joysticks[1]

    print("-=[ SuperLitium ]=-")

    -- init --
    litiumapi.litgraphics.changePallete()

    -- set the volume --
    love.audio.setVolume(0.1 * settings.getValue("volume_master"))

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

function love.keypressed(k, code)
    for key, value in pairs(keyboard.keys) do
        if value == k then
            pcall(cartdata(), _keydown(k, code))
            if k == "home" then
                local bootfile = io.open(love.filesystem.getSaveDirectory() .. "/.boot", "w")
                bootfile:write("")
                bootfile:close()
                love.load()
            end
        end
    end
end

function love.quit()
    love.filesystem.remove("bin/temp/.boot.tmp")
end

function love.gamepadpressed(jstk, button)
    if settings.getValue("enable_joystick") then
        if joystick ~= nil then
            print("callback running " .. button .. " ")
            pcall(cartdata(), _gamepaddown(jstk, button))
            if joystick:isGamepadDown("start") and love.filesystem.read(".boot") ~= "" then
                local bootfile = io.open(love.filesystem.getSaveDirectory() .. "/.boot", "w")
                bootfile:write("")
                bootfile:close()
                love.load()
            end
        end
    end
end