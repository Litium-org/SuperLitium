function _init()
    images = require 'system.resources.nx_image-dvr'
    ------------=[ Variables ]=---------------------
    math.randomseed(os.clock())
    timeElapsed = 0
    rand = math.random(10, 1)
    state = "bootloader"
    substate = 1
    substatesNames = {
        "load game",
        "Litium store",
        "settings",
        "About litium"
    }
    gamenames = love.filesystem.getDirectoryItems("carts")
    gamelib_cursor_pos = 22
    gamelib_cursor = 1
    gamelib_cursor_maxY = 0
    bootloader_isGameLoaded = false
    config_cursor = 1
    config_cursor_y = 60
    config_cursor_x = 1
    --------------=[ Modules ]=------------------- 
    shell = require 'system.resources.nx_shell'
    settings = require 'system.resources.nx_settings'
    Storage = require 'system.resources.nx_storage-dvr'
    version = require 'system.resources.nx_version'
    styles = require 'system.resources.nx_styles'
    ---------------------------------

    -- check for versions --
    isVersionDifferent = version.compare()
    -- load the settings --
    settings.loadSettings()
    desktopColor = {
        {15, 14},
        {13, 12},
        {11, 10},
        {9, 8},
        {7, 6},
        {5, 4},
    }

end

-- will render some states XD
function _render()
    
    switch(state, 
    {
        ["bootloader"] = function()
            if settings.getValue("enable_bootlogo") then
                styles.misc.bootloader()
                if bootloader_isGameLoaded then
                    strtxt = "Powered with SuperLitium"
                    litiumapi.litgraphics.newText(strtxt, (utils.screenWidth / 2) - (#strtxt * 8), 120, 4, 3, 1)
                end
            end
        end,
        ["oldversion"] = function()
            styles.misc.oldversion()
        end,
        ["config"] = function()
            styles.desktop.config()
            settings.render()
            litiumapi.litgraphics.newSprite(shell.icons.desktop.arrow_l, 30, config_cursor_y, 1)
        end,
        ["desktop"] = function()
            styles.desktop.data()
            switch(substate, 
            {
                [1] = function()
                    litiumapi.litgraphics.newSprite(shell.icons.desktop.disk, (utils.screenWidth / 2) - ((24 * 8) / 2), (utils.screenHeight / 2) - ((24 * 8) / 2), 8)
                end,
                [2] = function()
                    litiumapi.litgraphics.newSprite(shell.icons.desktop.storeIcon, (utils.screenWidth / 2) - ((24 * 8) / 2), (utils.screenHeight / 2) - ((24 * 8) / 2), 8)
                end,
                [3] = function()
                    litiumapi.litgraphics.newSprite(shell.icons.desktop.config, (utils.screenWidth / 2) - ((24 * 8) / 2), (utils.screenHeight / 2) - ((24 * 8) / 2), 8)
                end,
                [4] = function()
                    litiumapi.litgraphics.newSprite(shell.icons.desktop.about, (utils.screenWidth / 2) - ((24 * 8) / 2), (utils.screenHeight / 2) - ((24 * 8) / 2), 8)
                end,
            })
            litiumapi.litgraphics.newText(substatesNames[substate], 500, 530, 4, 2, 1)
        end,

        -- Substates --
        ["gamelib"] = function()
            styles.desktop.gamelib()
            litiumapi.litgraphics.newSprite(shell.icons.desktop.arrow_l, 0, gamelib_cursor_pos, 1)
            txtY = 22
            for gm = 1, #gamenames, 1 do
                litiumapi.litgraphics.newText(gamenames[gm], 22, txtY, 3, 3, 1)
                txtY = txtY + 22
            end
            gamelib_cursor_maxY = txtY
        end,

        ["about"] = function()
            styles.desktop.about()
        end
    })
    love.graphics.push()
    love.graphics.setColor(0, 0, 0, (0.1 * settings.getValue("c_brightness") - 0.1))
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    love.graphics.pop()
end 

function _update(elapsed)
    -- define the color table XD  --
    colorID = settings.getValue("enviroment_color")
    timeElapsed = timeElapsed + 1 * elapsed
    msElapsed = math.floor(timeElapsed)
    switch(state, 
    {
        ["bootloader"] = function()
            if msElapsed == 3 then
                if isVersionDifferent then
                    state = "oldversion"
                elseif bootloader_isGameLoaded then
                    love.load()
                else
                    state = "desktop"
                    litiumapi.litgraphics.changePallete(shell.pallete.neos16)
                    timeElapsed = 0
                end
            end
        end,

        ["oldversion"] = function()
            if litiumapi.litinput.isKeyDown("return") then
                love.event.quit()
            end
        end,

        ["desktop"] = function()
            if substate < 1 then
                substate = 4
            end
            if substate > 4 then
                substate = 1
            end
        end,
        ["gamelib"] = function()
            if gamelib_cursor_pos < 22 then
                gamelib_cursor_pos = 22
            end
            if gamelib_cursor_pos > gamelib_cursor_maxY - 22 then
                gamelib_cursor_pos = gamelib_cursor_maxY - 22
            end
            if gamelib_cursor < 1 then
                gamelib_cursor = 1
            end
            if gamelib_cursor > #gamenames then
                gamelib_cursor = #gamenames
            end
        end,
        ["config"] = function()
            if config_cursor < 1 then
                config_cursor = 1
            end
            if config_cursor > #settings.options then
                config_cursor = #settings.options
            end
            
            for settingOption = 1, #settings.options, 1 do
                if settings.options[settingOption].type == "num" then
                    if settings.options[settingOption].currentValue < settings.options[settingOption].min then
                        settings.options[settingOption].currentValue = settings.options[settingOption].min
                    end
                    if settings.options[settingOption].currentValue > settings.options[settingOption].max then
                        settings.options[settingOption].currentValue = settings.options[settingOption].max
                    end
                end
            end

            if settings.options[config_cursor].currentValue ~= nil then
                config_cursor_x = settings.options[config_cursor].currentValue
            end

            if config_cursor_y < 60 then
                config_cursor_y = 60
            end
            if config_cursor_y > settings.yMax then
                config_cursor_y = settings.yMax
            end
        end
    })
end

function _keydown(k)
    switch(state, 
    {
        ["desktop"] = function()
            if k == "left" then
                substate = substate + 1
            end
            if k == "right" then
                substate = substate - 1
            end
            if k == "return" then
                switch(substate, 
                {
                    [1] = function()
                        state = "gamelib"
                    end,
                    [2] = function()
                        state = "store"
                    end,
                    [3] = function()
                        state = "config"
                    end,
                    [4] = function()
                        state = "about"
                    end,
                })
            end
        end,
        ["gamelib"] = function()
            if k == "up" then
                gamelib_cursor_pos = gamelib_cursor_pos - 22
                gamelib_cursor = gamelib_cursor - 1
            end
            if k == "down" then
                gamelib_cursor_pos = gamelib_cursor_pos + 22
                gamelib_cursor = gamelib_cursor + 1
            end
            if k == "return" then
                bootfile = io.open(utils.saveDirectory() .. "/.boot", "w+")
                bootfile:write(gamenames[gamelib_cursor])
                bootfile:close()
                bootloader_isGameLoaded = true
            end
            -- unload game --
            if k == "crtl" then
                bootfile = io.open(utils.saveDirectory() .. "/.boot", "w+")
                bootfile:write("")
                bootfile:close()
                bootloader_isGameLoaded = false
            end
            -- play game --
            if k == "lshift" or k == "rshift" then
                if bootloader_isGameLoaded then
                    timeElapsed = 0
                    litiumapi.litgraphics.changePallete()
                    state = "bootloader"
                end
            end
            if k == "f5" then
                gamenames = love.filesystem.getDirectoryItems("carts")
            end
            if k == "escape" then
                state = "desktop"
            end
        end,
        ["config"] = function()
            if k == "up" then
                config_cursor = config_cursor - 1
                config_cursor_y = config_cursor_y - 30
            end
            if k == "down" then
                config_cursor = config_cursor + 1
                config_cursor_y = config_cursor_y + 30
            end
            if k == "right" then
                if settings.options[config_cursor].type == "num" then
                    config_cursor_x = config_cursor_x + 1
                    settings.changeValue(config_cursor, config_cursor_x)
                end
            end
            if k == "left" then
                if settings.options[config_cursor].type == "num" then
                    config_cursor_x = config_cursor_x - 1
                    settings.changeValue(config_cursor, config_cursor_x)                    
                end
            end
            if k == "return" then
                if settings.options[config_cursor].type == "bool" then
                    settings.change(config_cursor)
                end
                if settings.options[config_cursor].type == "button" then
                    settings.click("")
                end
            end
            if k == "escape" then
                settings.saveSettings()
                state = "desktop"
            end
        end,
        ["about"] = function()
            if k == "escape" then
                state = 'desktop'
            end
        end
    })
end
