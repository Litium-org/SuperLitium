function love.conf(w)
    w.window.width          = 1280
    w.window.height         = 720
    w.window.icon           = "assets/icon.png"
    w.window.title          = "Superlitium Player"
    w.console               = true
    w.identity              = "superLitium"
    w.window.resizable      = false 

    w.modules.audio         = true              -- Enable the audio module (boolean)
    w.modules.data          = false               -- Enable the data module (boolean)
    w.modules.event         = true              -- Enable the event module (boolean)
    w.modules.font          = true               -- Enable the font module (boolean)
    w.modules.graphics      = true           -- Enable the graphics module (boolean)
    w.modules.image         = true              -- Enable the image module (boolean)
    w.modules.joystick      = true           -- Enable the joystick module (boolean)
    w.modules.keyboard      = true           -- Enable the keyboard module (boolean)
    w.modules.math          = true               -- Enable the math module (boolean)
    w.modules.mouse         = true              -- Enable the mouse module (boolean)
    w.modules.physics       = false            -- Enable the physics module (boolean)
    w.modules.sound         = true              -- Enable the sound module (boolean)
    w.modules.system        = true             -- Enable the system module (boolean)
    w.modules.thread        = false             -- Enable the thread module (boolean)
    w.modules.timer         = true              -- Enable the timer module (boolean), Disabling it will result 0 delta time in love.update
    w.modules.touch         = false              -- Enable the touch module (boolean)
    w.modules.video         = false              -- Enable the video module (boolean)
    w.modules.window        = true             -- Enable the window module (boolean)
end
