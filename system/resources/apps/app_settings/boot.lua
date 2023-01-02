function _init()
    shell = require 'system.resources.nx_shell'
    json = require 'libraries.json'
    require 'libraries.json-beautify'
    shell.init()


    config_cursor = 1
    config_cursor_y = 50
    config_cursor_x = 1
    config_cursor_maxY = 0
    config_values = {
        {
            tag = "check_update",
            enable = true,
        },
        {
            tag = "antialiasing",
            enable = true,
        },
        {
            tag = "audio_volume",
            curvalue = 7,
        },
        {
            tag = "brightness",
            curvalue = 2,
        },
    }

    if litiumapi.litsave.isSaveExist("system") then
        config_values = litiumapi.litsave.loadSavedata("system")
    end
end

function _render()
    litiumapi.litgraphics.changePallete(shell.pallete.neos16)
    litiumapi.litgraphics.backgroundColor(5)
    litiumapi.litgraphics.rect("fill", 20, 40, litiumapi.litgraphics.windowWidth() - 540, litiumapi.litgraphics.windowHeight() - 80, 4)
    render()
    litiumapi.litgraphics.newSprite(shell.icons.desktop.arrow_l, 20, config_cursor_y, 1)
    litiumapi.litgraphics.newText(config_cursor_x, 50, 0, 3, 2, 1)

    litiumapi.litgraphics.newText(lang_data.settings._select, 830, 430, 3, 2, 1)
    litiumapi.litgraphics.newText(lang_data.settings._exit, 830, 460, 3, 2, 1)
    
    if joystick ~= nil then
        litiumapi.litgraphics.newText(lang_data.settings._gpselect, 870, 550, 3, 2, 1)
        litiumapi.litgraphics.newText(lang_data.settings._gpexit, 870, 580, 3, 2, 1)

        litiumapi.litgraphics.newSprite(shell.icons.env.a_button, 840, 550, 1.5)
        litiumapi.litgraphics.newSprite(shell.icons.env.b_button, 840, 580, 1.5)
    end
end

function _update(elapsed)
    config_toRender = {
        {
            title = lang_data.settings._st_checkupd,
            type = "bool",
            param = {
                enable = config_values[1].enable
            }
        },
        {
            title = lang_data.settings._st_antialiasing,
            type = "bool",
            param = {
                enable = config_values[2].enable
            }
        },
        {
            title = lang_data.settings._st_audio,
            type = "num",
            param = {
                min = 0,
                max = 10,
                currentValue = config_values[3].curvalue
            }
        },
        {
            title = lang_data.settings._st_brightness,
            type = "num",
            param = {
                min = 1,
                max = 10,
                currentValue = config_values[4].curvalue
            }
        }, 
    }
    -- cursor values --
    if config_cursor < 1 then
        config_cursor = 1
    end

    if config_cursor > #config_values then
        config_cursor = #config_values
    end

    -- cursor position --
    if config_cursor_y < 50 then
        config_cursor_y = 50
    end

    if config_cursor_y > config_cursor_maxY then
        config_cursor_y = config_cursor_maxY
    end

    -- cursor max and min --
    for settingOption = 1, #config_toRender, 1 do
        if config_toRender[config_cursor].type == "num" then
            if config_values[settingOption].curvalue ~= nil then
                if config_values[settingOption].curvalue < config_toRender[settingOption].param.min then
                    config_values[settingOption].curvalue = config_toRender[settingOption].param.min
                end
                if config_values[settingOption].curvalue > config_toRender[settingOption].param.max then
                    config_values[settingOption].curvalue = config_toRender[settingOption].param.max
                end
            end
        end
    end

    -- cursor max and min --
    for settingOption = 1, #config_toRender, 1 do
        if config_toRender[config_cursor].type == "string" then
            if config_values[settingOption].curvalue ~= nil then
                if config_values[settingOption].curvalue < config_toRender[settingOption].param.min then
                    config_values[settingOption].curvalue = config_toRender[settingOption].param.min
                end
                if config_values[settingOption].curvalue > config_toRender[settingOption].param.max then
                    config_values[settingOption].curvalue = config_toRender[settingOption].param.max
                end
            end
        end
    end
    
    -- set curvalue to current value of cursor x --
    if config_toRender[config_cursor].type == "num" then
        if config_values[config_cursor].curvalue ~= nil then
            config_cursor_x = config_values[config_cursor].curvalue
        end
    end
end

function _keydown(k, code)
    if k == "up" then
        config_cursor_y = config_cursor_y - 30
        config_cursor = config_cursor - 1
    end
    if k == "down" then
        config_cursor_y = config_cursor_y + 30
        config_cursor = config_cursor + 1
    end
    if k == "right" then
        if config_toRender[config_cursor].type == "num" then
            config_cursor_x = config_cursor_x + 1
            config_values[config_cursor].curvalue = config_cursor_x 
        end
    end
    if k == "left" then
        if config_toRender[config_cursor].type == "num" then
            config_cursor_x = config_cursor_x - 1
            config_values[config_cursor].curvalue = config_cursor_x 
        end
    end
    if k == "return" then
        if config_toRender[config_cursor].type == "bool" then
            if config_values[config_cursor].enable then
                config_values[config_cursor].enable = false
            else
                config_values[config_cursor].enable = true 
            end
        end
    end
    if k == "escape" then
        bootfile = love.filesystem.write(".boot", "")
        _G.onBootLoading = false
        save()
        love.load()
    end
end

function _gamepaddown(jstk, button)
    if joystick:isGamepadDown("dpup") then
        config_cursor_y = config_cursor_y - 30
        config_cursor = config_cursor - 1
    end
    if joystick:isGamepadDown("dpdown") then
        if config_toRender[config_cursor].type == "num" then
        config_cursor_y = config_cursor_y + 30
        config_cursor = config_cursor + 1
        end
    end
    if joystick:isGamepadDown("dpright") then
        if config_toRender[config_cursor].type == "num" then
            config_cursor_x = config_cursor_x + 1
            config_values[config_cursor].curvalue = config_cursor_x 
        end
    end
    if joystick:isGamepadDown("dpleft") then
        if config_toRender[config_cursor].type == "num" then
            config_cursor_x = config_cursor_x - 1
            config_values[config_cursor].curvalue = config_cursor_x 
        end
    end
    if joystick:isGamepadDown("a") then
        if config_toRender[config_cursor].type == "bool" then
            if config_values[config_cursor].enable then
                config_values[config_cursor].enable = false
            else
                config_values[config_cursor].enable = true 
            end
        end
    end
    if joystick:isGamepadDown("b") then
        bootfile = love.filesystem.write(".boot", "")
        _G.onBootLoading = false
        save()
        love.load()
    end
end

-----------==[ internal functions ]==------------------

function render()
    local txty = 50
    for settingsItem = 1, #config_toRender, 1 do
        if config_toRender[settingsItem].type == "bool" then
            local text = config_toRender[settingsItem].title .. " [" .. tostring(config_values[settingsItem].enable) .. "]"
            litiumapi.litgraphics.newText(text, 50, txty, 3, 2, 1)
        end
        if config_toRender[settingsItem].type == "num" then
            local text = config_toRender[settingsItem].title .. " <" .. tostring(config_values[settingsItem].curvalue) .. ">"
            litiumapi.litgraphics.newText(text, 50, txty, 3, 2, 1)
        end
        txty = txty + 30
    end
    config_cursor_maxY = txty - 30
end

function getValue(tag)
    print(config_values)
end

-----------==[ File functions ]==------------------

function save()
    litiumapi.litsave.saveData("system", config_values)
end

function load()
    config_values = litiumapi.litsave.loadSavedata("system")
end