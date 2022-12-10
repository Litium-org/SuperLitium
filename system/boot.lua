function _init()
    --------------=[ Modules ]=------------------- 
    images = require 'system.resources.nx_image-dvr'
    shell = require 'system.resources.nx_shell'
    settings = require 'system.resources.nx_settings'
    storage = require 'src.core.virtualization.drivers.nx_storage-dvr'
    version = require 'system.resources.nx_version'
    styles = require 'system.resources.nx_styles'
    tween = require 'libraries.tween'
    
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
        "commandline",
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
    savemngr_cursor_saveID = 1
    savemngr_cursor_y = 60
    savemngr_information = {}
    about_txt_y = 180
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
    
    loadingBar = {size = 0}
    loadingBar_tween = tween.new(2, loadingBar, {size = 1280}, 'outSine')
    colorInit = math.random(#desktopColor, 1)
end

-- will render some states XD
function _render()
    switch(state, 
    {
        ["bootloader"] = function()
            if settings.getValue("enable_bootlogo") then
                styles.misc.bootloader()
                if bootloader_isGameLoaded then
                    strtxt = "powered with superlitium"
                    litiumapi.litgraphics.newText(strtxt, (utils.screenWidth / 2) - (#strtxt * 13), 120, 4, 3, 1)
                else
                    strtxt = "Loading components"
                    litiumapi.litgraphics.newText(strtxt, (utils.screenWidth / 2) - (#strtxt * 13), 120, 4, 3, 1)
                end
            end
            litiumapi.litgraphics.rect("fill", 0, 700, loadingBar.size, 64, desktopColor[colorInit][1])
            litiumapi.litgraphics.rect("fill", 0, 700, loadingBar.size, 2, desktopColor[colorInit][2])
        end,
        ["oldversion"] = function()
            styles.misc.oldversion()
        end,
        ["config"] = function()
            styles.desktop.config()
            settings.render()
            litiumapi.litgraphics.newSprite(shell.icons.desktop.arrow_l, 30, config_cursor_y, 1)
            if joystick ~= nil and settings.getValue("enable_joystick") then
                litiumapi.litgraphics.newSprite(shell.icons.env.dir_up, 200, 680, 2)
                litiumapi.litgraphics.newSprite(shell.icons.env.dir_down, 230, 680, 2)
                litiumapi.litgraphics.newSprite(shell.icons.env.dir_left, 260, 680, 2)
                litiumapi.litgraphics.newSprite(shell.icons.env.dir_right, 290, 680, 2)
                litiumapi.litgraphics.newText("move cursor", 330, 686, 2, 3, 1)
                litiumapi.litgraphics.newSprite(shell.icons.env.a_button, 480, 680, 1.7)
                litiumapi.litgraphics.newText("select", 510, 686, 2, 3, 1)
                litiumapi.litgraphics.newSprite(shell.icons.env.b_button, 640, 680, 1.7)
                litiumapi.litgraphics.newText("back", 670, 686, 2, 3, 1)
            else
                local controlsText = "[esc] back | [up/down/left/right arrow] move cursor | [enter] change value"
                litiumapi.litgraphics.newText(controlsText, 20, 690, 2.7, 3, 1)
            end
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

            if joystick ~= nil and settings.getValue("enable_joystick") then
                litiumapi.litgraphics.newSprite(shell.icons.env.dir_left, 20, 680, 2)
                litiumapi.litgraphics.newSprite(shell.icons.env.dir_right, 60, 680, 2)
                litiumapi.litgraphics.newText("change option", 110, 686, 2, 3, 1)
                litiumapi.litgraphics.newSprite(shell.icons.env.a_button, 240, 680, 1.7)
                litiumapi.litgraphics.newText("accept", 290, 686, 2, 3, 1)
            else
                local controlsText = "[left/right arrow] Change option | [enter] accept"
                litiumapi.litgraphics.newText(controlsText, 190, 700, 2, 3, 1)
            end
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
            if bootloader_isGameLoaded then
                litiumapi.litgraphics.newText("cart loaded", 1000, 400, 3, 3, 1)
            end
            if joystick ~= nil and settings.getValue("enable_joystick") then
                litiumapi.litgraphics.newSprite(shell.icons.env.dir_up, 230, 680, 2)
                litiumapi.litgraphics.newSprite(shell.icons.env.dir_down, 260, 680, 2)
                litiumapi.litgraphics.newText("move cursor", 300, 686, 2, 3, 1)
                litiumapi.litgraphics.newSprite(shell.icons.env.a_button, 460, 680, 1.7)
                litiumapi.litgraphics.newText("load game", 490, 686, 2, 3, 1)
                litiumapi.litgraphics.newSprite(shell.icons.env.y_button, 620, 680, 1.7)
                litiumapi.litgraphics.newText("unload game", 650, 686, 2, 3, 1)
                litiumapi.litgraphics.newSprite(shell.icons.env.start_button, 800, 680, 1.7)
                litiumapi.litgraphics.newText("run game", 830, 686, 2, 3, 1)
                litiumapi.litgraphics.newSprite(shell.icons.env.select_button, 950, 680, 1.7)
                litiumapi.litgraphics.newText("reload list", 980, 686, 2, 3, 1)
            else
                local controlsText = "[esc] back | [up/down arrow] Move cursor | [f1] play game | [f2] unload game | [enter] load game"
                litiumapi.litgraphics.newText(controlsText, 20, 700, 2, 3, 1)
            end
        end,
        ["about"] = function()
            styles.desktop.about()
            about_txt_y = 210
            for c = 1, #styles.contributors, 1 do
                litiumapi.litgraphics.newText(styles.contributors[c], 40, about_txt_y, 3, 2, 1)
                about_txt_y = about_txt_y + 30
            end
            if joystick ~= nil and settings.getValue("enable_joystick") then
                litiumapi.litgraphics.newSprite(shell.icons.env.b_button, 210, 680, 2)
                litiumapi.litgraphics.newText("back", 250, 686, 2, 3, 1)
            else
                local controlsText = "[esc] back"
                litiumapi.litgraphics.newText(controlsText, 20, 690, 3, 3, 1)
            end
            
        end,
        ["savemngr"] = function()
            styles.desktop.savemngr()
            storage.renderPage(savemngr_cursor_offset)
            
            if #storage.diskdata.partitions > 0 then
                litiumapi.litgraphics.newSprite(shell.icons.desktop.arrow_l, 0, savemngr_cursor_y, 1)
            end

            -- info --
            litiumapi.litgraphics.rect("fill", 840, 60, 512, 100, 5)
            if savemngr_information ~= nil then
                litiumapi.litgraphics.newText(savemngr_information.savename, 850, 60, 3, 3, 1)
                litiumapi.litgraphics.newText(savemngr_information.savedate, 850, 90, 3, 3, 1)
            end

            if joystick ~= nil and settings.getValue("enable_joystick") then
                litiumapi.litgraphics.newSprite(shell.icons.env.dir_up, 230, 680, 2)
                litiumapi.litgraphics.newSprite(shell.icons.env.dir_down, 260, 680, 2)
                litiumapi.litgraphics.newText("move cursor", 300, 686, 2, 3, 1)
                litiumapi.litgraphics.newSprite(shell.icons.env.start_button, 400, 680, 1.7)
                litiumapi.litgraphics.newText("export save", 480, 686, 2, 3, 1)
                litiumapi.litgraphics.newSprite(shell.icons.env.select_button, 950, 680, 1.7)
                litiumapi.litgraphics.newText("delete save", 580, 686, 2, 3, 1)
            else
                local controlsText = "[esc] back | [up/down arrow] Move cursor | [f1] export save | [f2] delete save"
                litiumapi.litgraphics.newText(controlsText, 20, 690, 2.5, 3, 1)
            end
        end,
        ["store"] = function()
            styles.desktop.store()

            if joystick ~= nil and settings.getValue("enable_joystick") then
                litiumapi.litgraphics.newSprite(shell.icons.env.b_button, 210, 680, 2)
                litiumapi.litgraphics.newText("back", 250, 686, 2, 3, 1)
            else
                local controlsText = "[esc] back"
                litiumapi.litgraphics.newText(controlsText, 20, 690, 3, 3, 1)
            end
        end
    })
    if joystick ~= nil and settings.getValue("enable_joystick") then
        litiumapi.litgraphics.newSprite(shell.icons.desktop.controller_icon, 1200, 640, 4)
    end
end 

function _update(elapsed)
    -- define the color table XD  --
    colorID = settings.getValue("enviroment_color")
    timeElapsed = timeElapsed + 1 * elapsed
    msElapsed = math.floor(timeElapsed)
    switch(state, 
    {
        ["bootloader"] = function()
            loadingBar_tween:update(elapsed)
            if msElapsed == 2 then
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
            if litiumapi.litinput.keyboard.isKeyDown("return") then
                love.event.quit()
            end
        end,
        ["desktop"] = function()
            if substate < 1 then
                substate = #substatesTags
            end
            if substate > #substatesTags then
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
            if savemngr_cursor_offset < 1 then
                savemngr_cursor_offset = 1
            end
            if savemngr_cursor_offset > #storage.diskdata.partitions - 15 then
                savemngr_cursor_offset = #storage.diskdata.partitions - 15
            end

            if savemngr_cursor_saveID < 1 then
                savemngr_cursor_saveID = 1
            end
            if savemngr_cursor_saveID > #storage.diskdata.partitions - 1 then
                savemngr_cursor_saveID = #storage.diskdata.partitions
            end

            
            if savemngr_cursor_y < 60 then
                savemngr_cursor_y = 60
            end

            if savemngr_cursor_y > 510 then
                savemngr_cursor_y = 510
            end

            savemngr_information = storage.getSaveInfo(savemngr_cursor_saveID)
        end,
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
                    tempfile = love.filesystem.newFile("bin/temp/.boot.tmp", "w")
                    tempfile = io.open(love.filesystem.getSaveDirectory() .. "/bin/temp/.boot.tmp", "w")
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
                if #storage.diskdata.partitions > 0 then
                    if savemngr_cursor_offset > 0 then
                        if savemngr_cursor_y == 60 then
                            savemngr_cursor_offset = savemngr_cursor_offset - 1
                        end
                        savemngr_cursor_y = savemngr_cursor_y - 30
                        savemngr_cursor_saveID = savemngr_cursor_saveID - 1
                    end
                end
            end

            if k == "down" then
                if #storage.diskdata.partitions > 0 then
                    if savemngr_cursor_offset < #storage.diskdata.partitions then
                        if savemngr_cursor_y == 510 then
                            savemngr_cursor_offset = savemngr_cursor_offset + 1
                        end
                        savemngr_cursor_y = savemngr_cursor_y + 30

                        savemngr_cursor_saveID = savemngr_cursor_saveID + 1
                    end
                end
            end

            if k == "f1" then
                storage.export()
            end
            if k == "f2" then
                storage.deleteSave(savemngr_cursor_saveID)
            end
        end,
        ["store"] = function()
            if k == "escape" then
                state = "desktop"
            end
        end
    })
end

function _gamepaddown(joystick, button)
    switch(state, 
    {
        ["desktop"] = function()
            if joystick:isGamepadDown("dpleft") or joystick:isGamepadDown("leftshoulder") then
                substate = substate - 1
            end
            if joystick:isGamepadDown("dpright") or joystick:isGamepadDown("rightshoulder") then
                substate = substate + 1
            end
            if joystick:isGamepadDown("a") then
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
            if joystick:isGamepadDown("dpup") then
                gamelib_cursor_pos = gamelib_cursor_pos - 22
                gamelib_cursor = gamelib_cursor - 1
            end
            if joystick:isGamepadDown("dpdown") then
                gamelib_cursor_pos = gamelib_cursor_pos + 22
                gamelib_cursor = gamelib_cursor + 1
            end
            if joystick:isGamepadDown("a") then
                bootfile = io.open(utils.saveDirectory() .. "/.boot", "w+")
                bootfile:write(gamenames[gamelib_cursor])
                bootfile:close()
                bootloader_isGameLoaded = true
            end
            -- unload game --
            if joystick:isGamepadDown("y") then
                bootfile = io.open(utils.saveDirectory() .. "/.boot", "w+")
                bootfile:write("")
                bootfile:close()
                bootloader_isGameLoaded = false
            end
            -- play game --
            if joystick:isGamepadDown("start") then
                if bootloader_isGameLoaded then
                    timeElapsed = 0
                    litiumapi.litgraphics.changePallete()
                    state = "bootloader"
                end
            end
            if joystick:isGamepadDown("back") then
                gamenames = love.filesystem.getDirectoryItems("carts")
            end
            if joystick:isGamepadDown("b") then
                state = "desktop"
            end
        end,
        ["config"] = function()
            if joystick:isGamepadDown("dpup") then
                config_cursor = config_cursor - 1
                config_cursor_y = config_cursor_y - 30
            end
            if joystick:isGamepadDown("dpdown") then
                config_cursor = config_cursor + 1
                config_cursor_y = config_cursor_y + 30
            end
            if joystick:isGamepadDown("dpright") then
                if settings.options[config_cursor].type == "num" then
                    config_cursor_x = config_cursor_x + 1
                    settings.changeValue(config_cursor, config_cursor_x)
                end
            end
            if joystick:isGamepadDown("dpleft") then
                if settings.options[config_cursor].type == "num" then
                    config_cursor_x = config_cursor_x - 1
                    settings.changeValue(config_cursor, config_cursor_x)                    
                end
            end
            if joystick:isGamepadDown("a") then
                if settings.options[config_cursor].type == "bool" then
                    settings.changeBool(config_cursor)
                end
                
            end
            if joystick:isGamepadDown("b") then
                settings.saveSettings()
                state = "desktop"
            end
        end,
        ["savemngr"] = function()
            if joystick:isGamepadDown("b") then
                state = "desktop"
            end
            if joystick:isGamepadDown("dpup") then
                if savemngr_cursor_offset > 0 then
                    if savemngr_cursor_y == 60 then
                        savemngr_cursor_offset = savemngr_cursor_offset - 1
                    end
                    savemngr_cursor_y = savemngr_cursor_y - 30
                    savemngr_cursor_saveID = savemngr_cursor_saveID - 1
                end
            end

            if joystick:isGamepadDown("dpdown") then
                if savemngr_cursor_offset < #storage.diskdata.partitions then
                    if savemngr_cursor_y == 510 then
                        savemngr_cursor_offset = savemngr_cursor_offset + 1
                    end
                    savemngr_cursor_y = savemngr_cursor_y + 30

                    savemngr_cursor_saveID = savemngr_cursor_saveID + 1
                end
            end

            if joystick:isGamepadDown("start") then
                storage.export()
            end
            if joystick:isGamepadDown("back") then
                storage.deleteSave(savemngr_cursor_saveID)
            end
        end,
        ["about"] = function()
            if joystick:isGamepadDown("b") then
                state = 'desktop'
            end
        end,
        ["store"] = function()
            if joystick:isGamepadDown("b") then
                state = 'desktop'
            end
        end,
    })
end