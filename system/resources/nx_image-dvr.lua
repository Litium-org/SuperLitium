images = {}

json = require 'libraries.json'
basexx = require 'libraries.basexx'
luazlw = require 'libraries.luazlw'


function images.importSpriteFile(name)
    spritefile = io.open(name, "r")
    raw = spritefile:read("*all")

    sprite = json.decode(raw)

    return sprite
end

return images
