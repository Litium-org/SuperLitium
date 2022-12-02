graphics = require 'system.resources.nx_image-dvr'

shell = {
    pallete = {
        neos16 = {
            {0,0,0,0},	                -- [1]  transparent
            {250,250,250},
            {212,212,212},
            {157,157,157},
            {75,75,75},
            {249,147,138},
            {231,89,82},
            {249,211,129},
            {234,175,77},
            {154,209,249},
            {8,174,238},
            {141,237,167},
            {68,197,91},
            {195,167,225},
            {149,105,200},
            {186,181,170},
            {148,142,130}
        }
    },
    icons = {
        bootloader = {
            litlogo = {
                {1,1,3,3,3,3,3,1,1},
                {1,3,6,6,4,14,14,3,1},
                {3,6,6,3,5,14,14,14,3},
                {3,6,6,3,5,5,14,14,3},
                {3,4,5,3,5,5,5,4,3},
                {3,16,16,3,5,5,10,10,3},
                {3,16,16,3,3,3,10,10,3},
                {1,3,16,16,4,10,10,3,1},
                {1,1,3,3,3,3,3,1,1},
            },
            litlogoEasterEgg = {
                {1,1,3,3,3,3,3,1,1},
                {1,3,7,7,4,14,14,3,1},
                {3,7,7,3,5,14,14,14,3},
                {3,7,7,3,5,5,14,14,3},
                {3,4,5,3,5,5,5,4,3},
                {3,16,16,3,5,5,10,10,3},
                {3,16,16,3,3,3,10,10,3},
                {1,3,16,16,4,10,10,3,1},
                {1,1,3,3,3,3,3,1,1},
            },
        },
        desktop = {}
    }
}

shell.icons.desktop.arrow_r = images.importSpriteFile("system/resources/sprites/arrow_r.spr")
shell.icons.desktop.arrow_l = images.importSpriteFile("system/resources/sprites/arrow_l.spr")
shell.icons.desktop.config = images.importSpriteFile("system/resources/sprites/config.spr")
shell.icons.desktop.deskicon = images.importSpriteFile("system/resources/sprites/deskicon_lit.spr")
shell.icons.desktop.deskicon_hover = images.importSpriteFile("system/resources/sprites/deskicon_lit_hover.spr")
shell.icons.desktop.storeIcon = images.importSpriteFile("system/resources/sprites/store_icon.spr")
shell.icons.desktop.disk = images.importSpriteFile("system/resources/sprites/disk.spr")
shell.icons.desktop.about = images.importSpriteFile("system/resources/sprites/about_icon.spr")
shell.icons.desktop.save_manager = images.importSpriteFile("system/resources/sprites/save_manager_icon.spr")
shell.icons.desktop.commandline = images.importSpriteFile("system/resources/sprites/commandline.spr")



return shell
