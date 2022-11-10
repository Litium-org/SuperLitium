settings = {}

ext = require 'system.resources.nx_settings-ext'

settings.options = ext

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

function settings.change(id)
    if settings.options[id].type == "bool" then
        if settings.options[id].enable then
            settings.options[id].enable = false
        else
            settings.options[id].enable = true
        end
    end
end

function settings.loadSettings()
    
end

function settings.saveSettings()
    
end

return settings