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

function gamepad.vibrate(side, strenght, duration)
    if joystick:isVibrationSupported() then
        if side == "left" then
            return joystick:setVibration(strenght, 0, duration)
        end
        if side == "right" then
            return joystick:setVibration(0, strenght, duration)
        end
        if side == "both" then
            return joystick:setVibration(strenght, strenght, duration)
        end
    end
end

return gamepad