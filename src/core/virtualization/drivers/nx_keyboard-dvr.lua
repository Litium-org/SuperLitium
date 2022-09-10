keyboard = {}

-- allows for devs get only specifics keys --
keys = {
    "a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z",
    "0","1","2","3","4","5","6","7","8","9",
    "!","=","$","(",")",",",".",":",";","+","-","/","|","<",">","?","[","]",
    "space","backspace","return", "lshift", "rshift", "rctrl", "lctrl",
    "insert", "home", "delete", "end", "pageup", "pagedown" 
}

function keyboard.isKeyDown(key)
    for k, v in pairs(keys) do
        if v == key then
            if love.keyboard.isDown(v) then
                return true
            end
        end
    end
    return false
end


return keyboard