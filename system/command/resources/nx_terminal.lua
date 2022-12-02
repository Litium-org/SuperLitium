terminal = {}

terminal.screen = {}
terminal.textColor = 3
terminal.backgroundColor = 1
terminal.textBackgroundColor = 1
terminal.textSize = 2
stringx = require 'pl.stringx'

local function clearCommandTokens()
    for tkn = #cmdtokens, 1, -1 do
        table.remove(cmdtokens, tkn)
    end
end

local function clearTerminal()
    for termtext = 1, #terminal.screen, 1 do
        table.remove(terminal.screen, termtext)
    end
end

function terminal.echo(string, colortext, backgroundcolor)
    table.insert(terminal.screen, string)
end

function terminal.runCommand(command)
    terminal.echo("> " .. command)

    -- split command in tokens --
    cmdtokens = stringx.split(command, " ")

    --[[ normal commands ]]--

    -- exit command --
    if cmdtokens[1] == "exit" then
        love.filesystem.remove(".boot.tmp")
        love.load()
    end

    if cmdtokens[1] == "time" or cmdtokens[1] == "date" then
        terminal.echo("----------------------------")
        terminal.echo(os.date())
        terminal.echo("----------------------------")
    end
    
    --[[ multi-parameter commands ]]--

    --  project management --
    if cmdtokens[1] == "project" then
        if cmdtokens[2] == nil then
            terminal.echo("[project manager]")
            terminal.echo("_________________")
            terminal.echo("-n | create a new project")
            terminal.echo("-l | list all projects")
            terminal.echo("-r | remove a project")
            terminal.echo("-da | remove all projects")
        else
            if cmdtokens[2] == "-n" or cmdtokens[2] == "-nw" or cmdtokens[2] == "-new" then
                if cmdtokens[3] == nil then
                    terminal.echo("please type the name of your project")
                else
                    resc.createProjects(tostring(cmdtokens[3]))
                end
            end
            if cmdtokens[2] == "-l" or cmdtokens[2] == "-ls" or cmdtokens[2] == "-list" then
                local projectList = love.filesystem.getDirectoryItems("bin/projects")
                terminal.echo("[listing all projects]")
                terminal.echo("BBBBBBBBBBBBBBBBBBBBBB")
                for ip = 1, #projectList, 1 do
                    terminal.echo(projectList[ip])
                end

            end
            if cmdtokens[2] == "-r" or cmdtokens[2] == "-rm" or cmdtokens[2] == "-remove" then
                if cmdtokens[3] == nil then
                    terminal.echo("please type the name of your project")
                else
                    terminal.echo("project " .. cmdtokens .. " deleted sucesfully")
                    resc.deleteProjects(tostring(cmdtokens[3]))
                end   
            end
            if cmdtokens[2] == "-da" or cmdtokens[2] == "-delete-all"  then
                local confirm
                local projectList = love.filesystem.getDirectoryItems("bin/projects")
                terminal.echo("all projects are sucessfully deleted")
                for ip = 1, #projectList, 1 do
                    resc.deleteProjects(projectList[ip])
                end
            end
        end
    end

    if cmdtokens[1] == "color" then
        if cmdtokens[2] == nil then
            terminal.echo("change the color of the text")
            terminal.echo("usage : color <color-code-1><color-code-2>")
            terminal.echo("example : color 30 <change color of text to white and backgrond to black>")
        else
            if cmdtokens[3] == nil then
                terminal.echo("change the color of the text")
                terminal.echo("usage : color <color-code-1><color-code-2>")
                terminal.echo("example : color 30 <change color of text to white and backgrond to black>")
            else
                if cmdtokens[4] == nil then
                    terminal.echo("change the color of the text")
                    terminal.echo("usage : color <color-code-1><color-code-2>")
                    terminal.echo("example : color 30 <change color of text to white and backgrond to black>")
                else
                    if tonumber(cmdtokens[2]) < 1 then
                        terminal.echo("the range can't be lower than 1.")
                    elseif tonumber(cmdtokens[2]) > 17 then
                        terminal.echo("the range can't be higher than 17.E")
                    else
                        if tonumber(cmdtokens[3]) < 1 then
                            terminal.echo("the range can't be lower than 1.")
                        elseif tonumber(cmdtokens[3]) > 17 then
                            terminal.echo("the range can't be higher than 17.")
                        else
                            if tonumber(cmdtokens[4]) < 1 then
                                terminal.echo("the range can't be lower than 1.")
                            elseif tonumber(cmdtokens[4]) > 17 then
                                terminal.echo("the range can't be higher than 17.")
                            else
                                terminal.textColor = tonumber(cmdtokens[2])
                                terminal.textBackgroundColor = tonumber(cmdtokens[3])
                                terminal.backgroundColor = tonumber(cmdtokens[4])
                            end
                        end
                    end
                end
            end
        end
    end
    
    if cmdtokens[1] == "boot" then
        
    end

    clearCommandTokens()
end

function terminal.render()
    local term_txt_y = 0
    for tc = 1, #terminal.screen, 1 do
        litiumapi.litgraphics.newText(terminal.screen[tc], 0, term_txt_y, terminal.textSize, terminal.textColor, terminal.textBackgroundColor)
        term_txt_y = term_txt_y + (terminal.textSize * 10)
    end
end

function terminal.update(elapsed)
    if #terminal.screen > 37 then
        table.remove(terminal.screen, 1)
    end
end

return terminal