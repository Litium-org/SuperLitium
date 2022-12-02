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
        "litium store",
        "settings",
        "about litium",
        "save manager",
        "command line"
    }
    substatesTags = {
        "gamelib",
        "store",
        "config",
        "about",
        "savemngr",
        "commandline"
    }
    desktop_iconOffset = 7
    gamenames = love.filesystem.getDirectoryItems("carts")
    gamelib_cursor_pos = 22
    gamelib_cursor = 1
    gamelib_cursor_maxY = 0
    bootloader_isGameLoaded = false
    config_cursor = 1
    config_cursor_y = 60
    config_cursor_x = 1
    savemngr_cursor_y = 60
    savemngr_cursor = 1
    savemngr_cursor_offset = 1
    --------------=[ Modules ]=------------------- 
    shell = require 'system.resources.nx_shell'
    settings = require 'system.resources.nx_settings'
    storage = require 'src.core.virtualization.drivers.nx_storage-dvr'
    version = require 'system.resources.nx_version'
    styles = require 'system.resources.nx_styles'
    ---------------------------------

    -- load the settings --
    settings.loadSettings()

    -- check for versions --
    if settings.getValue("allow_check_updates") then
        isVersionDifferent = version.compare()
    end

    desktopColor = {
        {17, 16},
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
                    strtxt = "powered with SuperLitium"
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
                    litiumapi.litgraphics.newSprite(shell.icons.desktop.disk, (utils.screenWidth / 2) - ((24 * desktop_iconOffset) / 2), (utils.screenHeight / 2) - ((24 * 8) / 2), 8)
                end,
                [2] = function()
                    litiumapi.litgraphics.newSprite(shell.icons.desktop.storeIcon, (utils.screenWidth / 2) - ((24 * desktop_iconOffset) / 2), (utils.screenHeight / 2) - ((24 * 8) / 2), 8)
                end,
                [3] = function()
                    litiumapi.litgraphics.newSprite(shell.icons.desktop.config, (utils.screenWidth / 2) - ((24 * desktop_iconOffset) / 2), (utils.screenHeight / 2) - ((24 * 8) / 2), 8)
                end,
                [4] = function()
                    litiumapi.litgraphics.newSprite(shell.icons.desktop.about, (utils.screenWidth / 2) - ((24 * desktop_iconOffset) / 2), (utils.screenHeight / 2) - ((24 * 8) / 2), 8)
                end,
                [5] = function()
                    litiumapi.litgraphics.newSprite(shell.icons.desktop.save_manager, (utils.screenWidth / 2) - ((24 * desktop_iconOffset) / 2), (utils.screenHeight / 2) - ((24 * 8) / 2), 8)
                end,
                [6] = function()
                    litiumapi.litgraphics.newSprite(shell.icons.desktop.commandline, (utils.screenWidth / 2) - ((24 * desktop_iconOffset) / 2), (utils.screenHeight / 2) - ((24 * 8) / 2), 8)
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
        end,

        ["savemngr"] = function()
            styles.desktop.savemngr()
            storage.renderPage(savemngr_cursor_offset)
            litiumapi.litgraphics.newSprite(shell.icons.desktop.arrow_l, 0, gamelib_cursor_pos, 1)
        end
    })
    love.graphics.push()
        litiumapi.litgraphics.newText(substatesTags[substate] .. " " .. substate, 0, 0, 1, 3, 1)
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
                substate = #substatesNames
            end
            if substate > #substatesNames then
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
        end,
        ["savemngr"] = function()
            storage.update(elapsed)
            if savemngr_cursor_offset < 1 then
                savemngr_cursor_offset = 1
            end
            if savemngr_cursor_offset > #storage.listItems then
                savemngr_cursor_offset = #storage.listItems
            end
        end
    })
end

function _keydown(k, code)
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
                if substate == 6 then
                    tempfile = love.filesystem.newFile(".boot.tmp", "w")
                    tempfile:close()
                    love.load()
                else
                    state = substatesTags[substate]
                end
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
            if k == "f2" then
                bootfile = io.open(utils.saveDirectory() .. "/.boot", "w+")
                bootfile:write("")
                bootfile:close()
                bootloader_isGameLoaded = false
            end
            -- play game --
            if k == "f1" or k == "rshift" then
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
                    settings.changeBool(config_cursor)
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
        end,
        ["savemngr"] = function()
            if k == "escape" then
                state = "desktop"
            end
            if k == "up" then
                savemngr_cursor_offset = savemngr_cursor_offset - 1
            end

            if k == "down" then
                savemngr_cursor_offset = savemngr_cursor_offset + 1
            end

            if k == "1" then
                storage.export()
            end
        end
    })
end
