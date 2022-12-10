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
        desktop = {},
        env = {}
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
shell.icons.desktop.controller_icon = images.importSpriteFile("system/resources/sprites/controller_icon.spr")

shell.icons.env.x_button = images.importSpriteFile("system/resources/sprites/x-button.spr")
shell.icons.env.y_button = images.importSpriteFile("system/resources/sprites/y-button.spr")
shell.icons.env.a_button = images.importSpriteFile("system/resources/sprites/a-button.spr")
shell.icons.env.b_button = images.importSpriteFile("system/resources/sprites/b-button.spr")
shell.icons.env.start_button = images.importSpriteFile("system/resources/sprites/start-button.spr")
shell.icons.env.select_button = images.importSpriteFile("system/resources/sprites/select-button.spr")
shell.icons.env.dir_up = images.importSpriteFile("system/resources/sprites/dir_up.spr")
shell.icons.env.dir_down = images.importSpriteFile("system/resources/sprites/dir_down.spr")
shell.icons.env.dir_left = images.importSpriteFile("system/resources/sprites/dir_left.spr")
shell.icons.env.dir_right = images.importSpriteFile("system/resources/sprites/dir_right.spr")



return shell
