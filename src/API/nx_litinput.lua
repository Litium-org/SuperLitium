litinput = {}
litinput.keyboard = {}
litinput.mouse = {}
litinput.gamepad = {}

local keyboard = require 'src.core.virtualization.drivers.nx_keyboard-dvr'
local mouse = require 'src.core.virtualization.drivers.nx_mouse-dvr'
local gamepad = require 'src.core.virtualization.drivers.nx_gamepad'

function litinput.keyboard.isKeyDown(key)
    return keyboard.isKeyDown(key)
end

function litinput.mouse.isButtonDown(button)
    return mouse.isButtonDown(button)
end

function litinput.mouse.getMousePosition()
    return mouse.getMousePos()
end

function litinput.gamepad.isButtonPressed(button)
    return gamepad.isdown(button)
end

function litinput.gamepad.getAxis(axisName)
    return gamepad.getAxis(axisName)
end

function litinput.gamepad.vibrateGamepad(side, strenght, duration)
    return gamepad.vibrate(side, strenght, duration)
end

return litinput