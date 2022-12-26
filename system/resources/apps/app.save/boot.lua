function _init()
    storage = require 'src.core.virtualization.drivers.nx_storage-dvr'
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
        litiumapi.litgraphics.newText(savemngr_information.savename, 850, 60, 3, 3, 1)
        litiumapi.litgraphics.newText(savemngr_information.savedate, 850, 90, 3, 3, 1)
    end
end

function _update(elapsed)
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
end

function _gamepaddown(jstk, btn)
    
end