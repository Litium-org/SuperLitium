litinput = {}

keyboard = require 'src.core.virtualization.drivers.nx_keyboard-dvr'

function litinput.isKeyDown(key)
    bool = keyboard.isKeyDown(key)
    return bool
end

return litinput