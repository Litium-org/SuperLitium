images = {}

json = require 'libraries.json'
basexx = require 'libraries.basexx'


function images.importSpriteFile(name)
    gamename = bios.getFileName()
    
    print(name)
    spritefile = io.open(name, "r")
    raw = spritefile:read()

    -- file formatting process --
    format1 = basexx.from_z85(raw)
    format2 = basexx.from_base64(format1)
    format3 = basexx.from_base32(format2)
    sprite = json.decode(format3)

    return sprite
end

return images