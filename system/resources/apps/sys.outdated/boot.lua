function _init()
    shell = require 'system.resources.nx_shell'
    shell.init()

    strings = {
        lang_data.outdated._paragraph1,
        lang_data.outdated._paragraph2,
        " ",
        " ",
        " ",
        lang_data.outdated._footer,
    }
end

function _render()
    local txty = 140
    litiumapi.litgraphics.newSprite(shell.icons.bootloader.litlogo, 30, 30, 8)
    litiumapi.litgraphics.newText(lang_data.outdated._title, 150, 30, 5, 3, 1)
    for txt = 1, #strings, 1 do
        litiumapi.litgraphics.newText(strings[txt], 190, txty, 3, 3, 1)
        txty = txty + 30
    end
end

function _update(elapsed)
    
end

function _keydown(k, code)
    if k == "return" then
        love.event.quit()
    end
end

function _gamepaddown(jskt, button)
    
end