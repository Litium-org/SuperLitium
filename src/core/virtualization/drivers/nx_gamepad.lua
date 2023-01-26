gamepad = {}

function gamepad.isdown(button)
    return joystick:isGamepadDown(button)
end

function gamepad.getAxis(axis)
    -- if litiumapi.litinput.gamepad.getAxis(axis) == "left" then end
    local dir = joystick:getGamepadAxis(axis)
    if dir < 0 then
        return "left"
    end
    if dir > 0 then
        return "right"
    end
end

return gamepad