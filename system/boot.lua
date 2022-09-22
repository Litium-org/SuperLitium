function init()
    math.randomseed(os.clock())
    shell = require 'system.resources.nx_shell'
    version = require 'system.resources.nx_version'
    storage = require 'system.resources.nx_storage-dvr'
    mouse = require 'src.core.virtualization.drivers.nx_mouse-dvr'
    debug = require 'src.debug.nx_debug'

    version.getCurrentVersion()

    screenCenterX = litiumapi.litgraphics.windowWidth() / 2
    screenCenterY = litiumapi.litgraphics.windowHeight() / 2

    timeElapsed = 0
    rand = math.random(10, 1)
    state = "bootloader"

    cursorX = screenCenterX
    cursorY = screenCenterY
    cursorSpeed = 200
    hold = 0
end

function render()
    if state == "upgrade" then
        
    end

    if state == "bootloader" then
        if rand < 4 then
            litiumapi.litgraphics.newSprite(shell.icons.bootloader.litlogoEasterEgg, screenCenterX - 50, screenCenterY - 80, 8)
        else
            litiumapi.litgraphics.newSprite(shell.icons.bootloader.litlogo, screenCenterX - 50, screenCenterY - 80, 8)
        end
    end

    if state == "desktop" then
        litiumapi.litgraphics.backgroundColor(10)
        litiumapi.litgraphics.rect("fill", 0, 0, 1280, 64, 11)
        litiumapi.litgraphics.rect("fill", 0, litiumapi.litgraphics.windowHeight() - 64, 1280, 64, 11)
        -----------------------------------------------------------------------------------------------
        litiumapi.litgraphics.newSprite(shell.icons.desktop.deskicon.normal, 10, 10, 3)
        litiumapi.litgraphics.newSprite(shell.icons.desktop.config, 70, 10, 3)
        litiumapi.litgraphics.newSprite(shell.icons.desktop.storeIcon, 140, 10, 3)
        -----------------------------------------------------------------------------------------------
        --litiumapi.litgraphics.newSprite(shell.icons.desktop.cursor, mx - 30, my - 30, 3)
        litiumapi.litgraphics.newSprite(shell.icons.desktop.cursor, cursorX - 3 * 10, cursorY - 3 * 10, 3)
    end

    if state == "love" then
        litiumapi.litgraphics.newSprite(shell.icons.desktop.donate, screenCenterX - 80, screenCenterY - 80, 8)
    end
end

function update(elapsed)
    timeElapsed = timeElapsed + 1 * elapsed
    msElapsed = math.floor(timeElapsed)
    if state == "bootloader" then
        if msElapsed == 3 then
            state = "desktop"
            litiumapi.litgraphics.changePallete(shell.pallete.neos16)
            timeElapsed = 0
        end
    end
    if state == "desktop" then
        mx, my = mouse.getMousePos()

        if litiumapi.litinput.isKeyDown("up") then
            cursorY = cursorY - cursorSpeed * elapsed
        end
        if litiumapi.litinput.isKeyDown("down") then
            cursorY = cursorY + cursorSpeed * elapsed
        end
        if litiumapi.litinput.isKeyDown("left") then
            cursorX = cursorX - cursorSpeed * elapsed
        end
        if litiumapi.litinput.isKeyDown("right") then
            cursorX = cursorX + cursorSpeed * elapsed
        end
        if litiumapi.litinput.isKeyDown("return") then
            hold = hold + 1
        else
            hold = 0
        end

        if hold > 20 then
            state = "love"
        end
    end
    if state == "love" then
        litiumapi.litgraphics.changePallete(shell.pallete.secret)
    end
end
