keyboard = {}

-- allows for devs get only specifics keys --
keyboard.keys = {
    "a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z",
    "0","1","2","3","4","5","6","7","8","9",
    "!","=","$","(",")",",",".",":",";","+","-","/","|","<",">","?","[","]",
    "escape","space","backspace","return", "lshift", "rshift", "rctrl", "lctrl",
    "insert", "home", "delete", "end", "pageup", "pagedown",
    "up", "down", "left", "right",
    "f1","f2","f3","f4","f5","f6","f7","f8","f9","f10","f11","f12",
}

function keyboard.isKeyDown(key)
    for k, v in pairs(keyboard.keys) do
        if v == key then
            if love.keyboard.isDown(v) then
                return true
            end
        end
    end
    return false
end

return keyboard