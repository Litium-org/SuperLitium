_G.path = ""
function love.load()
    math.randomseed(os.time())
    love.graphics.setDefaultFilter("nearest", "nearest")

    love.keyboard.setKeyRepeat(true)
    love.setDeprecationOutput(false)
    https               = require 'https'
    stringx             = require 'pl.stringx'
    installer           = require 'src.engine.resources.nx_installer'
    litiumapi           = require 'src.API.nx_litiumAPI'
    keyboard            = require 'src.core.virtualization.drivers.nx_keyboard-dvr'
    cartloader          = require 'src.core.virtualization.nx_cartloader'
    --bios                = require 'src.engine.system.nx_bios'
    switch              = require 'libraries.switch'
    storage             = require 'src.core.virtualization.drivers.nx_storage-dvr'
    nativelocks         = require 'src.core.misc.nx_nativelocks'
    shell               = require 'system.resources.nx_shell'
    lip                 = require 'libraries.lip'
    fs                  = require 'libraries.nativefs'

    -- main thread for install folders and system components
    installer.install()

    local joysticks = love.joystick.getJoysticks()
	joystick = joysticks[1]

    print("-=[ SuperLitium ]=-")

    -- init --
    litiumapi.litgraphics.changePallete()

    -- lock some commands XDDD
    nativelocks.lock()

    -- cartdrive initialization
    --cartdata = bios.init()

    -- create storage file 
    storage.init()

    -- call init function
    if cartdata ~= nil then
        pcall(cartdata(), _init())
    end
end

function love.draw()
    love.graphics.clear()
    if cartdata ~= nil then
        pcall(cartdata(), _render())
    else
        litiumapi.litgraphics.newText("No game loaded", 480, 200, 3, 3, 1)
        litiumapi.litgraphics.newText("drag 'n drop a folder with a valid game", 280, 280, 3, 3, 1)
        litiumapi.litgraphics.newSprite(shell.icons.bootloader.litlogo, 370, 170, 8)
    end
end

function love.update(elapsed)
    if cartdata ~= nil then
        pcall(cartdata(), _update(elapsed))
    end
end

function love.keypressed(k, code)
    for key, value in pairs(keyboard.keys) do
        if value == k then
            if cartdata ~= nil then
                pcall(cartdata(), _keydown(k, code))
            end
            if k == "home" then
                cartdata = nil
                love.load()
            end
        end
    end
end

--[[
function love.quit()
    love.filesystem.remove("bin/temp/.boot.tmp")
    love.filesystem.write(".boot", "")
end
]]--
function love.gamepadpressed(jstk, button)
    if joystick ~= nil then
        print("callback running " .. button .. " ")
        if cartdata ~= nil then
            pcall(cartdata(), _gamepaddown(jstk, button))
        end
        if joystick:isGamepadDown("start") and cartdata ~= nil then
            cartdata = nil
            love.load()
        end
    end
end

function love.directorydropped(path)
    cartdata, error = fs.load(path .. "/" .. "boot.lua")
    if error ~= nil then
        print(error)
    end
    -- call init function
    if cartdata ~= nil then
        _G.path = path
        pcall(cartdata(), _init())
    end
end