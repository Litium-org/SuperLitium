_G.onBootLoading = true
_G.masterVolume = 0
_G.brightness = 0
_G.antialiasing = false
_G.Current_language = "en"
function love.load()
    love.keyboard.setKeyRepeat(true)
    love.setDeprecationOutput(false)
    https               = require 'https'
    stringx             = require 'pl.stringx'
    installer           = require 'src.engine.resources.nx_installer'
    litiumapi           = require 'src.API.nx_litiumAPI'
    keyboard            = require 'src.core.virtualization.drivers.nx_keyboard-dvr'
    cartloader          = require 'src.core.virtualization.nx_cartloader'
    bios                = require 'src.engine.system.nx_bios'
    switch              = require 'libraries.switch'
    storage             = require 'src.core.virtualization.drivers.nx_storage-dvr'
    nativelocks         = require 'src.core.misc.nx_nativelocks'
    shell               = require 'system.resources.nx_shell'
    lip                 = require 'libraries.lip'

    -- main thread for install folders and system components
    installer.install()

    local langFile = love.filesystem.getInfo("bin/data/lang.data")
    if langFile == nil then
        filedata = love.filesystem.newFile("bin/data/lang.data", "w")
        filedata:write("en")
        filedata:close()
    end
    _G.Current_language = love.filesystem.read("bin/data/lang.data")

    -- load translation file --
    lang_data = lip.parse("translations/" .. _G.Current_language .. ".ltf")

    local joysticks = love.joystick.getJoysticks()
	joystick = joysticks[1]

    print("-=[ SuperLitium ]=-")

    -- init --
    litiumapi.litgraphics.changePallete()

    -- set the volume --
    love.audio.setVolume(0.1 * _G.masterVolume)

    -- lock some commands XDDD
    nativelocks.lock()

    -- cartdrive initialization
    cartdata = bios.init()

    -- create storage file 
    storage.init()

    -- call init function
    pcall(cartdata(), _init())

    -- antialising --
    if not _G.antialiasing then
        love.graphics.setDefaultFilter("nearest", "nearest")
    else
        love.graphics.setDefaultFilter("linear", "linear")
    end
end

function love.draw()
    love.graphics.clear()
    pcall(cartdata(), _render())
    
    love.graphics.push()
        love.graphics.setColor(0, 0, 0, (0.1 * _G.brightness - 0.1))
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
                love.filesystem.write(".boot", "")  
                love.load()
            end
        end
    end
end

function love.quit()
    love.filesystem.remove("bin/temp/.boot.tmp")
    love.filesystem.write(".boot", "")
end

function love.gamepadpressed(jstk, button)
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