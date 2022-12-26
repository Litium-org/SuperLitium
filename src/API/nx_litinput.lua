litinput = {}
litinput.keyboard = {}
litinput.mouse = {}

local keyboard = require 'src.core.virtualization.drivers.nx_keyboard-dvr'
local mouse = require 'src.core.virtualization.drivers.nx_mouse-dvr'

function litinput.keyboard.isKeyDown(key)
    return keyboard.isKeyDown(key)
end

function litinput.mouse.isButtonDown(button)
    return mouse.isButtonDown(button)
end

function litinput.mouse.getMousePosition()
    return mouse.getMousePos()
end

return litinput