images = {}

json = require 'libraries.json'

function images.importSpriteFile(name)
    local raw = love.filesystem.read(name)
    local sprite = json.decode(raw)
    return sprite
end

return images
