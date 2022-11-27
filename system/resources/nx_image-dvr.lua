images = {}

json = require 'libraries.json'

function images.importSpriteFile(name)
    spritefile = io.open(name, "r")
    raw = spritefile:read("*all")

    sprite = json.decode(raw)

    return sprite
end

return images
