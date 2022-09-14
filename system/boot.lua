function create()
    math.randomseed(os.clock())
    rand = math.random(10, 1)
    
    -- resources --
    shell = require 'system.resources.shell'

    TimeElapsed = 0
    state = "bootloader"

    -- secret logo <3 --
    if rand < 4 then
        litiumapi.litgraphics.newSprite(shell.icons.litlogoEasterEgg, 90, 90, 10, "logo")
    else
        litiumapi.litgraphics.newSprite(shell.icons.litlogo, 90, 90, 10, "logo")
    end

    litiumapi.litgraphics.newText("Welcome to litium", 200, 200, 5, 3, 1, "logo")
end

function update(elapsed)
    print(TimeElapsed)
    if state == "bootloader" then
        TimeElapsed = TimeElapsed + 1 * elapsed
        if math.floor(TimeElapsed) > 4 then
            litiumapi.litentity.killSprite("logo")
            litiumapi.litentity.destroyText("logo")
            state = "desktop"
        end
    end
    if state == "desktop" then
        if math.floor(TimeElapsed) == 0 then
            litiumapi.litgraphics.changePallete(shell.pallete.bubblegum)
        end
    end
end