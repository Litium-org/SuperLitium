function init()
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
    --------------=[ Modules ]=------------------- 
    shell = require 'system.resources.nx_shell'
    version = require 'system.resources.nx_version'
    styles = require 'system.resources.nx_styles'
    ---------------------------------

    -- check for versions --
    isVersionDifferent = version.compare()
end

-- will render some states XD
function render() 
    switch(state, {
        ["bootloader"] = function()
            styles.misc.bootloader()
        end,
        ["oldversion"] = function()
            styles.misc.oldversion()
        end,
        ["desktop"] = function()
            styles.desktop.data()
            switch(substate, {
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
            litiumapi.litgraphics.newText(substatesNames[substate], (utils.screenWidth / 2) - (#substatesNames[substate] * (#substatesNames[substate] * 6) / 4), 530, 4, 2, 1)
        end,

        -- Substates --
        ["gamelib"] = function()
            styles.desktop.gamelib()
        end
    })
end

function update(elapsed)
    timeElapsed = timeElapsed + 1 * elapsed
    msElapsed = math.floor(timeElapsed)
    if state == "bootloader" then
        if msElapsed == 3 then
            if isVersionDifferent then
                state = "oldversion"
            else
                state = "desktop"
                litiumapi.litgraphics.changePallete(shell.pallete.neos16)
                timeElapsed = 0
            end
        end
    end

    if state == "desktop" then
        if substate < 1 then
            substate = 3
        end
        if substate > 3 then
            substate = 1
        end
    end
end

function love.keypressed(k, sc, isrepeat)
    isrepeat = false
    if state == "desktop" then
        if k == "left" then
            substate = substate + 1
        end
        if k == "right" then
            substate = substate - 1
        end
        if k == "return" then
            switch(substate, {
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
    end
end
