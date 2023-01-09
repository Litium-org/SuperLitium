function _init()
    shell = require 'system.resources.nx_shell'
    version = require 'system.resources.nx_version'
    tween = require 'libraries.tween'
    lip = require 'libraries.lip'
    
    shell.init()

    data = litiumapi.litsave.loadSavedata("system")
    if data == nil then
        data = {
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
    end

    _G.antialiasing = data[2].enable or false
    _G.masterVolume = data[3].curvalue or 0
    _G.brightness = data[4].curvalue or 0
    
    --print(debugcomponent.showTableContent(data))

    ---------------------------------
    states = "bootloader"
    bootloader_rand = math.random(1, 10)
    bootloader_elapsed = 0
    hub_iconlist = {
        icons = {
            shell.icons.desktop.disk,
            shell.icons.desktop.save_manager,
            shell.icons.desktop.lang_icon,
            shell.icons.desktop.config,
            shell.icons.desktop.turnoff_icon
        },
        iconTray = {
            shell.icons.env.no_wifi_icon,
            shell.icons.desktop.controller_icon
        },
        names = {
            lang_data.hub._gamelib,
            lang_data.hub._savemngr,
            lang_data.hub._langSelect,
            lang_data.hub._config,
            lang_data.hub._shutdown
        },
        states = {
            "__gamelib",
            "__savemngr",
            "__lang",
            "__config",
            "shutdown",
        }
    }
    hub_iconOffset = 0
    hub_selection = 1

    -- check version --
    if data[1].enable then
        isVersionOld = version.compare()
        print(isVersionOld)
        if isVersionOld then
            love.filesystem.write(".boot", "___outdated")
            love.load()
        end
    end
end

function _render()
    switch(states, 
    {
        ["bootloader"] = function()
            if bootloader_rand < 4 then
                litiumapi.litgraphics.newSprite(shell.icons.bootloader.litlogoEasterEgg, (utils.screenWidth / 2) - 50, (utils.screenHeight / 2) - 80, 8)
            else
                litiumapi.litgraphics.newSprite(shell.icons.bootloader.litlogo, (utils.screenWidth / 2) - 50, (utils.screenHeight / 2) - 80, 8)
            end
            litiumapi.litgraphics.newText(lang_data.bootloader._load_warning, 20, 690, 2, 3, 1)
        end,
        ["shutdown"] = function()
            if bootloader_rand < 4 then
                litiumapi.litgraphics.newSprite(shell.icons.bootloader.litlogoEasterEgg, (utils.screenWidth / 2) - 50, (utils.screenHeight / 2) - 80, 8)
            else
                litiumapi.litgraphics.newSprite(shell.icons.bootloader.litlogo, (utils.screenWidth / 2) - 50, (utils.screenHeight / 2) - 80, 8)
            end
        end,
        ["hub"] = function()
            local hub_icon_x = 600 + hub_iconOffset
            litiumapi.litgraphics.changePallete(shell.pallete.neos16)
            litiumapi.litgraphics.backgroundColor(5)
            litiumapi.litgraphics.newText(lang_data.hub._date .. os.date(), 10, 10, 3, 2, 1)
            litiumapi.litgraphics.rect("fill", 0, litiumapi.litgraphics.windowHeight() / 2 - (120 / 2), 1280, 120, 4)
            litiumapi.litgraphics.rect("fill", litiumapi.litgraphics.windowWidth() / 2 - (120 / 2), litiumapi.litgraphics.windowHeight() / 2 - (120 / 2), 128, 120, 3)
            for icon = 1, #hub_iconlist.icons, 1 do
                litiumapi.litgraphics.newSprite(hub_iconlist.icons[icon], hub_icon_x, litiumapi.litgraphics.windowHeight() / 2 - (110 / 2), 5)
                hub_icon_x = hub_icon_x + 240
            end

            if not version.isConnectedToNetwork or joystick ~= nil then
                litiumapi.litgraphics.rect("fill", 0, 60, 220, 90, 4)
            end
            if not version.isConnectedToNetwork then
                litiumapi.litgraphics.newSprite(hub_iconlist.iconTray[1], 50, 80, 3)
            end
            if joystick ~= nil then
                litiumapi.litgraphics.newSprite(hub_iconlist.iconTray[2], 120, 80, 3)
            end
                

            litiumapi.litgraphics.newText(hub_iconlist.names[hub_selection], litiumapi.litgraphics.windowWidth() / 2 - 100, litiumapi.litgraphics.windowHeight() / 2 + 100, 5, 2, 1)
        end
    })
end

function _update(elapsed)
    switch(states, {
        ["bootloader"] = function()
            if _G.onBootLoading then
                bootloader_elapsed = bootloader_elapsed + 1 * elapsed
                if math.floor(bootloader_elapsed) >= 3 then
                    _G.onBootLoading = false
                    states = "hub"
                end
            else
                states = "hub"
            end
        end,
        ["shutdown"] = function()
            bootloader_elapsed = bootloader_elapsed + 1 * elapsed
            if math.floor(bootloader_elapsed) >= 3 then
                litiumapi.litgame.quit()
            end
        end,
        ["hub"] = function()
            if hub_selection < 1 then
                hub_selection = 1
            end
            if hub_selection > #hub_iconlist.states then
                hub_selection = #hub_iconlist.states
            end
            
            if hub_iconOffset > 0 then
                hub_iconOffset = 0 
            end
            
            if hub_iconOffset < -960 then
                hub_iconOffset = -960
            end
        end
    })
end

function _keydown(k, code)
    switch(states, {
        ["bootloader"] = function()
            if k == "f11" then
                local tempfile = love.filesystem.newFile("bin/temp/.boot.tmp", "w")
                tempfile:close()
                love.load()
            end
        end,
        ["hub"] = function()
            if k == "right" then
                hub_iconOffset = hub_iconOffset - 240
                hub_selection = hub_selection + 1
            end
            if k == "left" then
                hub_iconOffset = hub_iconOffset + 240
                hub_selection = hub_selection - 1
            end
            if k == "return" then
                if hub_selection == 5 then
                    states = "shutdown"
                    litiumapi.litgraphics.changePallete()
                    bootloader_elapsed = 0
                else
                    bootfile = love.filesystem.write(".boot", hub_iconlist.states[hub_selection])
                    love.load()
                end
            end
        end
    })
end

function _gamepaddown(jstk, button)
    switch(states, {
        ["hub"] = function()
            if joystick:isGamepadDown("dpleft") or joystick:isGamepadDown("leftshoulder") then
                hub_iconOffset = hub_iconOffset + 240
                hub_selection = hub_selection - 1
            end
            if joystick:isGamepadDown("dpright") or joystick:isGamepadDown("rightshoulder") then
                hub_iconOffset = hub_iconOffset - 240
                hub_selection = hub_selection + 1
            end
            if joystick:isGamepadDown("a") then
                if hub_selection == 5 then
                    litiumapi.litgraphics.changePallete()
                    bootloader_elapsed = 0
                    states = "shutdown"
                else
                    bootfile = love.filesystem.write(".boot", hub_iconlist.states[hub_selection])
                    love.load()
                end
            end
        end
    })
end