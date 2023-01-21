gamepad = {}

function gamepad.isdown(button)
    return joystick:isGamepadDown(button)
end

return gamepad