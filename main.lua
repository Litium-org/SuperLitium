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

    txt = ""
    bootloader_rand = math.random(1, 10)
    showCredits = false
    isError = false
    contributors = {
        "dxpixy",
        "sloow"
    }

    -- main thread for install folders and system components
    installer.install()

    local joysticks = love.joystick.getJoysticks()
	joystick = joysticks[1]

    print("-=[ SuperLitium ]=-")

    -- init --
    litiumapi.litgraphics.changePallete()

    -- lock some commands XDDD
    nativelocks.lock()

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
        if bootloader_rand < 4 then
            litiumapi.litgraphics.newSprite(shell.icons.bootloader.litlogoEasterEgg, 370, 170, 8)
        else
            litiumapi.litgraphics.newSprite(shell.icons.bootloader.litlogo, 370, 170, 8)
        end

        if showCredits then
            litiumapi.litgraphics.newText("Contributors", 10, 10, 3, 3, 1)
            local txty = 40
            for i = 1, #contributors, 1 do
                litiumapi.litgraphics.newText("-" .. contributors[i], 10, txty, 3, 3, 1)
                txty = txty + 30
            end
        end
        if isError or not isErrorOnFunction then
            litiumapi.litgraphics.backgroundColor(7)
            txt1 = "invalid game detected!"
            txt2 = "please drag'n drop a valid game"
            litiumapi.litgraphics.newText(txt1, 480 - (#txt1 * 2), 203, 3, 2, 1)
            litiumapi.litgraphics.newText(txt1, 480 - (#txt1 * 2), 200, 3, 3, 1)
            litiumapi.litgraphics.newText(txt2, 480 - (#txt2 * 2), 233, 3, 2, 1)
            litiumapi.litgraphics.newText(txt2, 480 - (#txt2 * 2), 230, 3, 3, 1)
        end
    end
end

function love.update(elapsed)
    if txt == "credits" then
        showCredits = true
    end
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
            if k == "del" then
                txt = ""
            end
        end
    end
end

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
        isError = true
        print(error)
    end
    -- call init function
    if cartdata ~= nil then
        _G.path = path
        pcall(cartdata(), _init())
    end
end

function love.textinput(t)
    txt = txt .. t
end