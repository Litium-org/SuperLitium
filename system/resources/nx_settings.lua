settings = {}

utils = require 'src.engine.resources.nx_utils'
json = require 'libraries.json'
basexx = require 'libraries.basexx'
debug = require 'src.debug.nx_debug'

settings.options = {
    {
        tag = "allow_check_updates",
        title = "check for updates",
        type = "bool",
        enable = true
    },
    {
        title = "For developers",
        type = "label",
    },
    {
        tag = "enable_bootlogo",
        title = "enable bootlogo",
        type = "bool",
        enable = true
    },
    {
        tag = "enable_joystick",
        title = "enable gamepad (gamepad functions and callbacks)",
        type = "bool",
        enable = true
    },
    {
        title = "Main functions",
        type = "label",
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
        title = "master volume",
        type = "num",
        currentValue = 7,
        min = 0,
        max = 10
    },
    {
        tag = "c_brightness",
        title = "brightness",
        type = "num",
        currentValue = 3,
        min = 1,
        max = 10
    }
}

local y = 60
settings.saveOptions = {}

settings.yMax = y

function settings.init()
    for opitem = 1, #settings.options, 1 do
        
    end
end

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
        if settings.options[oi].type == "label" then
            optext = "-=[ " .. tostring(settings.options[oi].title) .. " ]=-"
            litiumapi.litgraphics.newText(optext, 60, y, 3, 3, 1)
        end
        y = y + 30
    end
    settings.yMax = y - 30
end

function settings.changeValue(id, value)
    if settings.options[id].type == "num" then
        if settings.options[id].currentValue > settings.options[id].max then
            settings.options[id].currentValue = settings.options[id].max
        elseif settings.options[id].currentValue < settings.options[id].min then
            settings.options[id].currentValue = settings.options[id].min
        else
            settings.options[id].currentValue = value
        end
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
    dataFile = love.filesystem.getInfo("bin/data/data.slf")
    if dataFile ~= nil then
        datafile = io.open(love.filesystem.getSaveDirectory() .. "/bin/data/data.slf")
        data = datafile:read("*all")
        base64_decode = basexx.from_base64(data)
        config_Data = json.decode(base64_decode)
        settings.options = config_Data
    else
        return
    end
end

function settings.saveSettings()
    -- create json content --
    settingsFile = love.filesystem.getInfo("bin/data/data.slf")
    config_data = json.encode(settings.options)
    base64 = basexx.to_base64(config_data)

    if settingsFile == nil then
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