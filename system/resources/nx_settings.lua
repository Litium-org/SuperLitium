settings = {}

utils = require 'src.engine.resources.nx_utils'
json = require 'libraries.json'
basexx = require 'libraries.basexx'

settings.options = {
    {
        tag = "allow_check_updates",
        title = "Check for updates",
        type = "bool",
        enable = true
    },
    {
        tag = "enable_bootlogo",
        title = "enable bootlogo",
        type = "bool",
        enable = true
    },
    {
        tag = "enviroment_color",
        title = "enviroment color",
        type = "num",
        currentValue = 3,
        min = 1,
        max = 7
    },
    {
        tag = "volume_master",
        title = "Master volume",
        type = "num",
        currentValue = 10,
        min = 1,
        max = 10
    },
    {
        tag = "c_brightness",
        title = "brightness",
        type = "num",
        currentValue = 5,
        min = 1,
        max = 10
    },
}

y = 60
settings.yMax = y

function settings.render()
    y = 60
    for oi = 1, #settings.options, 1 do
        if settings.options[oi].type == "bool" then
            optext = tostring(settings.options[oi].title) .. "   [" .. tostring(settings.options[oi].enable) .. "]"
            litiumapi.litgraphics.newText(optext, 60, y, 3, 3, 1)
        end
        if settings.options[oi].type == "num" then
            optext = tostring(settings.options[oi].title) .. "   <" .. tostring(settings.options[oi].currentValue) .. ">"
            litiumapi.litgraphics.newText(optext, 60, y, 3, 3, 1)
        end
        y = y + 30
    end
    settings.yMax = y - 30
end

function settings.changeValue(id, value)
    if settings.options[id].type == "num" then
        settings.options[id].currentValue = value
    end
end

function settings.changeBool(id)
    if settings.options[id].type == "bool" then
        if settings.options[id].enable then
            settings.options[id].enable = false
        else
            settings.options[id].enable = true
        end
    end
end

function settings.getValue(tag)
    for opitem = 1, #settings.options, 1 do
        if settings.options[opitem].tag == tag then
            if settings.options[opitem].type == "bool" then
                return settings.options[opitem].enable
            end
            if settings.options[opitem].type == "num" then
                return settings.options[opitem].currentValue
            end
        end
    end
end

function settings.loadSettings()
    data = love.filesystem.read("bin/data/data.slf")
    base64_decode = basexx.from_base64(data)
    config_Data = json.decode(base64_decode)
    settings.options = config_Data
end

function settings.saveSettings()
    -- create json content --
    config_data = json.encode(settings.options)
    base64 = basexx.to_base64(config_data)

    if not utils.exist("file", "bin/data/data.slf") then
        config_file = love.filesystem.newFile("bin/data/data.slf", "w")
        config_file:write(base64)
        config_file:close()
    else
        config_file = io.open(love.filesystem.getSaveDirectory() .. "/bin/data/data.slf", "w+")
        config_file:write(base64)
        config_file:close()
    end
end

return settings