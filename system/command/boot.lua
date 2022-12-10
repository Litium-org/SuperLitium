function _init()
    terminal = require 'system.command.resources.nx_terminal'
    resc = require 'system.command.resources.nx_resc'
    version = require 'system.resources.nx_version'

    letters = {}
    Text = ""

    -- print the logo --
    terminal.echo("superlitium terminal v" .. returnCurrentVersion())
    terminal.echo("type 'help' to see all commands")
end

function _render()
    --litiumapi.litgraphics.newText("test", 90, 90, 3, 3, 1)
    litiumapi.litgraphics.backgroundColor(terminal.backgroundColor)
    terminal.render()
    generateString()
end

function _update(elapsed)
    terminal.update()
end

function _keydown(k, code)
    if checkForAcceptedKeys(code) then
        if k == "backspace" then
            backspaceCMD()
        elseif k == "return" then
            enterCMD()
        elseif k == "space" then
            table.insert(letters, " ")
        else
            table.insert(letters, k)
        end
    end
end

----------------------------------------------------------------
--[[                       Functions                        ]]--
----------------------------------------------------------------

function checkForAcceptedKeys(keyboardkey)
    for key = 1, #resc.acceptedKeys do
        if keyboardkey == resc.acceptedKeys[key] then
            return true
        else
            key = key + 1
        end
    end
    return false
end

function generateString()
    litiumapi.litgraphics.newText(">", 0, 700, terminal.textSize, terminal.textColor, terminal.textBackgroundColor)
    for l = 1, #letters, 1 do
        Text = table.concat(letters, "")
        litiumapi.litgraphics.newText(Text .. "_", 15, 700, terminal.textSize, terminal.textColor, terminal.textBackgroundColor)
    end
end

function backspaceCMD()
    table.remove(letters, #letters)
end

function enterCMD()
    for i = #letters, 1, -1 do
        table.remove(letters, i)
    end

    terminal.runCommand(Text)
    Text = ""
end

function returnCurrentVersion()
    VersionFile = love.filesystem.read(".litversion")
    return VersionFile
end