function _init()
    shell = require 'system.resources.nx_shell'
    shell.init()

    gamenames = love.filesystem.getDirectoryItems("carts")

    gamelib_offset = 1
    gamelib_cursor_y = 50
    gamelib_maxCursorY = 0
    gamelib_cursorSelection = 1
    gamelib_cursorSelected = 0
    gamelib_gamefile = {}
    gamelib_isCartLoaded = false
end

function _render()
    litiumapi.litgraphics.changePallete(shell.pallete.neos16)
    litiumapi.litgraphics.backgroundColor(5)
    litiumapi.litgraphics.rect("fill", 20, 40, litiumapi.litgraphics.windowWidth() - 540, litiumapi.litgraphics.windowHeight() - 80, 4)
    renderGames(gamelib_offset)
    if #gamenames > 0 then
        litiumapi.litgraphics.newSprite(shell.icons.desktop.arrow_l, 30, gamelib_cursor_y, 1)
        if iconData ~= nil then
            IconData = json.decode(iconData)
            litiumapi.litgraphics.newSprite(IconData, 940, 100, 8)
        else
            litiumapi.litgraphics.newSprite(shell.icons.env.iconNotFound, 940, 100, 8)
        end
    else
        litiumapi.litgraphics.newText("no games installed", 50, 50, 3, 2, 1)
    end
    litiumapi.litgraphics.newText(lang_data.gamelib._load, 870, 430, 3, 2, 1)
    litiumapi.litgraphics.newText(lang_data.gamelib._unload, 870, 460, 3, 2, 1)
    litiumapi.litgraphics.newText(lang_data.gamelib._play, 870, 490, 3, 2, 1)
    litiumapi.litgraphics.newText(lang_data.gamelib._exit, 870, 520, 3, 2, 1)
    if joystick ~= nil then
        litiumapi.litgraphics.newText(lang_data.gamelib._gpload, 870, 550, 3, 2, 1)
        litiumapi.litgraphics.newText(lang_data.gamelib._gpunload, 870, 580, 3, 2, 1)
        litiumapi.litgraphics.newText(lang_data.gamelib._gpplay, 870, 610, 3, 2, 1)
        litiumapi.litgraphics.newText(lang_data.gamelib._gpexit, 870, 640, 3, 2, 1)

        litiumapi.litgraphics.newSprite(shell.icons.env.a_button, 840, 550, 1.5)
        litiumapi.litgraphics.newSprite(shell.icons.env.y_button, 840, 580, 1.5)
        litiumapi.litgraphics.newSprite(shell.icons.env.x_button, 840, 610, 1.5)
        litiumapi.litgraphics.newSprite(shell.icons.env.b_button, 840, 640, 1.5)
    end

    litiumapi.litgraphics.newText(lang_data.gamelib._info, 890, 50, 3, 2, 1)
    if gamelib_gamefile.size == nil then
        litiumapi.litgraphics.newText(lang_data.gamelib._size .. lang_data.gamelib._noinfo, 820, 350, 3, 2, 1)
    else
        litiumapi.litgraphics.newText(lang_data.gamelib._size .. bytesToSize(gamelib_gamefile.size), 820, 350, 3, 2, 1)
    end
end

function _update(elapsed)
    if gamenames[gamelib_cursorSelection] ~= nil then
        gamelib_gamefile = love.filesystem.getInfo("carts/" .. gamenames[gamelib_cursorSelection] .. "/boot.lua")
    end
    

    if gamelib_cursor_y < 50 then
        gamelib_cursor_y = 50
    end
    if gamelib_cursor_y > gamelib_maxCursorY then
        gamelib_cursor_y = gamelib_maxCursorY
    end

    if gamelib_offset < 1 then
        gamelib_offset = 1
    end

    if gamelib_cursorSelection < 1 then
        gamelib_cursorSelection = 1
    end

    if gamelib_cursorSelection > #gamenames then
        gamelib_cursorSelection = #gamenames
    end
end

function _keydown(k, code)
    if k == "escape" then
        bootfile = love.filesystem.write(".boot", "")
        _G.onBootLoading = false
        love.load()
    end

    if k == "return" then
        bootfile = love.filesystem.write(".boot", gamenames[gamelib_cursorSelection])
        gamelib_isCartLoaded = true
        gamelib_cursorSelected = gamelib_cursorSelection
    end

    if k == "f1" then
        bootfile = love.filesystem.write(".boot", "")
        gamelib_isCartLoaded = false
    end

    if k == "f2" then
        if gamelib_isCartLoaded then
            love.load()
        end
    end

    if k == "up" then
        if #gamenames > 0 then
            if gamelib_offset > 0 then
                if gamelib_cursor_y == 50 then
                    gamelib_offset = gamelib_offset - 1
                else
                    print("gamelib_cursor_y == 50")
                end
                gamelib_cursor_y = gamelib_cursor_y - 30
                gamelib_cursorSelection = gamelib_cursorSelection - 1
            end
        end
    end

    if k == "down" then
        if #gamenames > 0 then
            if gamelib_offset < #gamenames then
                if gamelib_cursor_y == 650 then
                    gamelib_offset = gamelib_offset + 1
                end
                gamelib_cursor_y = gamelib_cursor_y + 30
                gamelib_cursorSelection = gamelib_cursorSelection + 1
            end
        end
    end    
end

function _gamepaddown(jstk, btn)
    if joystick:isGamepadDown("b") then
        bootfile = love.filesystem.write(".boot", "")
        _G.onBootLoading = false
        love.load()
    end

    if joystick:isGamepadDown("a") then
        bootfile = love.filesystem.write(".boot", gamenames[gamelib_cursorSelection])
        gamelib_isCartLoaded = true
        gamelib_cursorSelected = gamelib_cursorSelection
    end

    if joystick:isGamepadDown("y") then
        bootfile = love.filesystem.write(".boot", "")
        gamelib_isCartLoaded = false
    end

    if joystick:isGamepadDown("x") then
        if gamelib_isCartLoaded then
            love.load()
        end
    end

    if joystick:isGamepadDown("dpup") then
        if #gamenames > 0 then
            if gamelib_offset > 0 then
                if gamelib_cursor_y == 50 then
                    gamelib_offset = gamelib_offset - 1
                end
                gamelib_cursor_y = gamelib_cursor_y - 30
                gamelib_cursorSelection = gamelib_cursorSelection - 1
            end
        end
    end

    if joystick:isGamepadDown("dpdown") then
        if #gamenames > 0 then
            if gamelib_offset < #gamenames then
                if gamelib_cursor_y == 650 then
                    gamelib_offset = gamelib_offset + 1
                end
                gamelib_cursor_y = gamelib_cursor_y + 30
                gamelib_cursorSelection = gamelib_cursorSelection + 1
            end
        end
    end
end

function round(num, idp)
    return tonumber(string.format("%." .. (idp or 0) .. "f", num))
  end

function bytesToSize(bytes)
    precision = 2
    kilobyte = 1024
    megabyte = kilobyte * 1024
    gigabyte = megabyte * 1024
    terabyte = gigabyte * 1024
  
    if((bytes >= 0) and (bytes < kilobyte)) then
      return bytes .. " Bytes";
    elseif((bytes >= kilobyte) and (bytes < megabyte)) then
      return round(bytes / kilobyte, precision) .. ' KB'
    elseif((bytes >= megabyte) and (bytes < gigabyte)) then
      return round(bytes / megabyte, precision) .. ' MB'
    elseif((bytes >= gigabyte) and (bytes < terabyte)) then
      return round(bytes / gigabyte, precision) .. ' GB'
    elseif(bytes >= terabyte) then
      return round(bytes / terabyte, precision) .. ' TB'
    else
      return bytes .. ' B';
    end
end

function renderGames(offset)
    local txtY = 50
    for games = offset, 20 + offset, 1 do
        if gamenames[games] ~= nil then
            litiumapi.litgraphics.newText(tostring(gamenames[games]), 60, txtY, 3, 2, 1)
            txtY = txtY + 30
        end
    end
    gamelib_maxCursorY = txtY - 30
end