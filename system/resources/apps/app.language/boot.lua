function _init()
    shell = require 'system.resources.nx_shell'

    shell.init()

    languages = {
        langNames = {
            lang_data.language._lg_en,
            lang_data.language._lg_pt,
        },
        langCodes = {
            "en",
            "pt",
        }
    }

    lang_cursor_y = 50
    lang_cursor = 1
    lang_cursor_maxY = 0
end

function _render()
    local txty = 50
    litiumapi.litgraphics.changePallete(shell.pallete.neos16)
    litiumapi.litgraphics.backgroundColor(5)
    litiumapi.litgraphics.rect("fill", 20, 40, litiumapi.litgraphics.windowWidth() - 300, litiumapi.litgraphics.windowHeight() - 80, 4)
    litiumapi.litgraphics.newSprite(shell.icons.desktop.lang_icon, 890, 90, 6)
    litiumapi.litgraphics.newSprite(shell.icons.desktop.arrow_l, 20, lang_cursor_y, 1)
    for langname = 1, #languages.langNames, 1 do
        litiumapi.litgraphics.newText(languages.langNames[langname], 50, txty, 3, 2, 1)
        txty = txty + 30
    end
    lang_cursor_maxY = txty - 30
end

function _update(elapsed)
    if lang_cursor_y < 50 then
        lang_cursor_y = 50
    end
    if lang_cursor_y > lang_cursor_maxY then
        lang_cursor_y = lang_cursor_maxY
    end

    if lang_cursor < 1 then
        lang_cursor = 1
    end
    if lang_cursor > #languages.langNames then
        lang_cursor = #languages.langNames
    end
end

function _keydown(k, code)
    if k == "up" then
       lang_cursor_y = lang_cursor_y - 30
       lang_cursor = lang_cursor - 1 
    end
    if k == "down" then
        lang_cursor_y = lang_cursor_y + 30 
        lang_cursor = lang_cursor + 1
    end
    if k == "return" then
        love.filesystem.write("bin/data/lang.data", languages.langCodes[lang_cursor])
    end
    if k == "escape" then
        bootfile = love.filesystem.write(".boot", "")
        _G.onBootLoading = false
        love.load()
    end
end

function _gamepaddown(jstk, button)
    
end