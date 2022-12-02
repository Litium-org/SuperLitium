images = {}

json = require 'libraries.json'

function images.importSpriteFile(name)
    local spritefile = io.open(name, "r")
    local raw = spritefile:read("*all")

    local sprite = json.decode(raw)

    return sprite
end

return images
