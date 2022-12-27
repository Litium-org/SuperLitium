function _init()
    storage = require 'src.core.virtualization.drivers.nx_storage-dvr'
    shell = require 'system.resources.nx_shell'
    shell.init()
    savemngr_cursor_y = 60
    savemngr_cursor = 1
    savemngr_cursor_offset = 1
    savemngr_cursor_saveID = 1
    savemngr_cursor_y = 60
    savemngr_information = {}
end

function _render()
    litiumapi.litgraphics.changePallete(shell.pallete.neos16)
    litiumapi.litgraphics.backgroundColor(5)
    litiumapi.litgraphics.rect("fill", 20, 40, litiumapi.litgraphics.windowWidth() - 540, litiumapi.litgraphics.windowHeight() - 80, 4)

    storage.renderPage(savemngr_cursor_offset)
            
    if #storage.diskdata.partitions > 0 then
        litiumapi.litgraphics.newSprite(shell.icons.desktop.arrow_l, 0, savemngr_cursor_y, 1)
    end

    if savemngr_information ~= nil then
        litiumapi.litgraphics.newSprite(shell.icons.desktop.save_manager, 860, 100, 8)
        litiumapi.litgraphics.newText(savemngr_information.savename, 850, 260, 3, 3, 1)
        litiumapi.litgraphics.newText(savemngr_information.savedate, 850, 290, 3, 3, 1)
    end

    litiumapi.litgraphics.newText(lang_data.savemngr._delete, 870, 430, 3, 2, 1)
    litiumapi.litgraphics.newText(lang_data.savemngr._export, 870, 460, 3, 2, 1)
    litiumapi.litgraphics.newText(lang_data.savemngr._exit, 870, 490, 3, 2, 1)
    if joystick ~= nil then
        litiumapi.litgraphics.newText(lang_data.savemngr._gpdelete, 870, 550, 3, 2, 1)
        litiumapi.litgraphics.newText(lang_data.savemngr._gpexport, 870, 580, 3, 2, 1)
        litiumapi.litgraphics.newText(lang_data.savemngr._gpexit, 870, 610, 3, 2, 1)

        litiumapi.litgraphics.newSprite(shell.icons.env.y_button, 840, 550, 1.5)
        litiumapi.litgraphics.newSprite(shell.icons.env.x_button, 840, 580, 1.5)
        litiumapi.litgraphics.newSprite(shell.icons.env.b_button, 840, 610, 1.5)
    end
end

function _update(elapsed)
    if savemngr_cursor_offset < 1 then
        savemngr_cursor_offset = 1
    end
    if #storage.diskdata.partitions > 20 then
        if savemngr_cursor_offset > #storage.diskdata.partitions + 20 then
            savemngr_cursor_offset = #storage.diskdata.partitions - 20
        end
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

    if savemngr_cursor_y > storage.maxTxtY - 30 then
        savemngr_cursor_y = storage.maxTxtY - 30
    end

    savemngr_information = storage.getSaveInfo(savemngr_cursor_saveID)
end

function _keydown(k, code)
    if k == "escape" then
        bootfile = love.filesystem.write(".boot", "")
        _G.onBootLoading = false
        love.load()
    end

    if k == "up" then
        if #storage.diskdata.partitions > 0 then
            if savemngr_cursor_offset > 0 then
                if savemngr_cursor_y == 60 then
                    savemngr_cursor_offset = savemngr_cursor_offset - 1
                end
                    savemngr_cursor_y = savemngr_cursor_y - 30
                savemngr_cursor_saveID = savemngr_cursor_saveID - 1
            else
                print(" if savemngr_cursor_offset > 0", savemngr_cursor_offset)
            end
        else
            print("if #storage.diskdata.partitions > 0 ")
        end
    end

    if k == "down" then
        if #storage.diskdata.partitions > 0 then
            if savemngr_cursor_offset < #storage.diskdata.partitions then
                if savemngr_cursor_y == 660 then
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
end

function _gamepaddown(jstk, btn)
        if joystick:isGamepadDown("b") then
        bootfile = love.filesystem.write(".boot", "")
        _G.onBootLoading = false
        love.load()
    end
    
    if joystick:isGamepadDown("dpup") then
        if #storage.diskdata.partitions > 0 then
            if savemngr_cursor_offset > 0 then
                if savemngr_cursor_y == 60 then
                    savemngr_cursor_offset = savemngr_cursor_offset - 1
                end
                    savemngr_cursor_y = savemngr_cursor_y - 30
                savemngr_cursor_saveID = savemngr_cursor_saveID - 1
            else
                print(" if savemngr_cursor_offset > 0", savemngr_cursor_offset)
            end
        else
            print("if #storage.diskdata.partitions > 0 ")
        end
    end

    if joystick:isGamepadDown("dpdown") then
        if #storage.diskdata.partitions > 0 then
            if savemngr_cursor_offset < #storage.diskdata.partitions then
                if savemngr_cursor_y == 660 then
                    savemngr_cursor_offset = savemngr_cursor_offset + 1
                end
                savemngr_cursor_y = savemngr_cursor_y + 30

                savemngr_cursor_saveID = savemngr_cursor_saveID + 1
            end
        end
    end

    if joystick:isGamepadDown("x") then
        storage.export()
    end
    if joystick:isGamepadDown("y") then
        storage.deleteSave(savemngr_cursor_saveID)
    end 
end