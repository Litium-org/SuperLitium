styles = {
    misc = {
        bootloader = function()
            if rand < 4 then
                litiumapi.litgraphics.newSprite(shell.icons.bootloader.litlogoEasterEgg, (utils.screenWidth / 2) - 50, (utils.screenHeight / 2) - 80, 8)
            else
                litiumapi.litgraphics.newSprite(shell.icons.bootloader.litlogo, (utils.screenWidth / 2) - 50, (utils.screenHeight / 2) - 80, 8)
            end
        end,
        oldversion = function()
            local keyText = "press [enter] to shutdown Litium"
            litiumapi.litgraphics.newText("You are currently running a outdated version of Litium", 20, 20, 3, 3, 1)
            litiumapi.litgraphics.newText("Please go to github page to get most recent version", 20, 50, 3, 3, 1)
            litiumapi.litgraphics.newText(keyText, (utils.screenWidth / 2) - (#keyText * 16), 600, 4, 3, 1)
            litiumapi.litgraphics.newSprite(shell.icons.bootloader.litlogo, 40, 130, 8)
        end
    },

    desktop = {
        data = function()
            local txt = "welcome user"
                --=[hub]=--
            litiumapi.litgraphics.backgroundColor(desktopColor[colorID][1])
            litiumapi.litgraphics.newText(txt, (utils.screenWidth / 2) - (#txt * 13), 90, 4, 2, 1)

            litiumapi.litgraphics.newText("version " .. tostring(returnCurrentVersion()), 10, 700, 2, 2, 1)
            litiumapi.litgraphics.rect("fill", (utils.screenWidth / 2) - 160, (utils.screenHeight / 2) - 160, 320, 320, desktopColor[colorID][2])
        end,
        gamelib = function()
            litiumapi.litgraphics.backgroundColor(7)
            litiumapi.litgraphics.rect("fill", 20, 20, (utils.screenWidth / 2) - 20, utils.screenHeight - 40, 6)
        end,
        config = function()
            litiumapi.litgraphics.backgroundColor(5)
            litiumapi.litgraphics.newText("settings", 20, 10, 3, 3, 1)
            litiumapi.litgraphics.newText("[esc] - save and back", 20, 690, 3, 3, 1)
            litiumapi.litgraphics.rect("fill", 20, 40, utils.screenWidth - 40, utils.screenHeight - 80, 4)
        end,
        about = function()
            litiumapi.litgraphics.backgroundColor(11)
            litiumapi.litgraphics.newText("bbout superlitium", 20, 10, 3, 3, 1)
            litiumapi.litgraphics.newSprite(shell.icons.desktop.deskicon_hover, 340, 0, 2)
            litiumapi.litgraphics.rect("fill", 20, 40, utils.screenWidth - 40, utils.screenHeight - 80, 10)
            litiumapi.litgraphics.newText("[esc] - back", 20, 690, 3, 3, 1)
        end,
        savemngr = function()
            litiumapi.litgraphics.backgroundColor(5)
            litiumapi.litgraphics.newText("save manager", 20, 10, 3, 3, 1)
            litiumapi.litgraphics.newSprite(shell.icons.desktop.save_manager, 340, 0, 2)
            litiumapi.litgraphics.newText("[esc] - back", 20, 690, 3, 3, 1)
            litiumapi.litgraphics.rect("fill", 20, 40, utils.screenWidth - 40, utils.screenHeight - 80, 4)
        end
    }
}

function returnCurrentVersion()
    VersionFile = love.filesystem.read(".litversion")
    return VersionFile
end

return styles