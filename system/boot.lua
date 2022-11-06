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
        "settings"
    }
    gamenames = love.filesystem.getDirectoryItems("carts")
    gamelib_cursor_pos = 22
    gamelib_cursor = 1
    gamelib_cursor_maxY = 0
    --------------=[ Modules ]=------------------- 
    shell = require 'system.resources.nx_shell'
    version = require 'system.resources.nx_version'
    styles = require 'system.resources.nx_styles'
    ---------------------------------

    -- check for versions --
    isVersionDifferent = version.compare()
end

-- will render some states XD
function _render() 
    switch(state, 
    {
        ["bootloader"] = function()
            styles.misc.bootloader()
        end,
        ["oldversion"] = function()
            styles.misc.oldversion()
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
        end
    })
end

function _update(elapsed)
    timeElapsed = timeElapsed + 1 * elapsed
    msElapsed = math.floor(timeElapsed)
    switch(state, 
    {
        ["bootloader"] = function()
            if msElapsed == 3 then
                if isVersionDifferent then
                    state = "oldversion"
                else
                    state = "desktop"
                    litiumapi.litgraphics.changePallete(shell.pallete.neos16)
                    timeElapsed = 0
                end
            end
        end,

        ["desktop"] = function()
            if substate < 1 then
                substate = 3
            end
            if substate > 3 then
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
        end

    })
end

function love.keypressed(k, sc, isrepeat)
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
                love.load()
            end
            if k == "f5" then
                gamenames = love.filesystem.getDirectoryItems("carts")
            end
            if k == "escape" then
                state = "desktop"
            end
        end
    })
end
