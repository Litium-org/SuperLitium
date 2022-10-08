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
            keyText = "press [enter] to shutdown Litium"
            litiumapi.litgraphics.newText("You are currently running a outdated version of Litium", 20, 20, 3, 3, 1)
            litiumapi.litgraphics.newText("Please go to github page to get most recent version", 20, 50, 3, 3, 1)
            litiumapi.litgraphics.newText(keyText, (utils.screenWidth / 2) - (#keyText * 16), 600, 4, 3, 1)
            litiumapi.litgraphics.newSprite(shell.icons.bootloader.litlogo, 40, 130, 8)
        end
    },

    desktop = {
        data = function()
            txt = "welcome user"
                --=[hub]=--
            litiumapi.litgraphics.backgroundColor(11)
            litiumapi.litgraphics.newText(txt, (utils.screenWidth / 2) - (#txt * 16), 90, 4, 2, 1)
            litiumapi.litgraphics.rect("fill", (utils.screenWidth / 2) - 160, (utils.screenHeight / 2) - 160, 320, 320, 10)
        end,
        gamelib = function()
            litiumapi.litgraphics.backgroundColor(7)
            litiumapi.litgraphics.rect("fill", 20, 20, (utils.screenWidth / 2) - 20, utils.screenHeight - 40, 6)
        end
    }
}



return styles