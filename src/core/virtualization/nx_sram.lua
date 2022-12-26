sram = {}

soundTH = require 'src.core.virtualization.drivers.nx_sound-drv'

-- vars for update --
isPlaying = false
isPaused = false
isLooping = false
msElapsed = 0
curSection = 1

buffer = {
    soundSources = {}
}
function findByTag(tag)
    for k, addr in pairs(buffer.soundSources) do
        if addr.tag == "$" .. tag then
            return buffer.soundSources[k]
        end
    end
end

function sram.newSoundSource(tag, filename)  -- found for .mus json file
    gameFile = love.filesystem.read(".boot")

    if filename ~= nil then
        musFile = love.filesystem.read("carts/" .. gameFile .. "/sound/" .. filename .. ".mus")
        musData = json.decode(musFile)
    end

    SoundSource = {
        tag = "$" .. string.sub(tag, 1, 8),
        meta = {
            isPlaying = false,
            isLooped = false,
            msElapsed = 0,
            currentSection = 1      -- Section structure : {frequency, pitch, length, type, waitMS}
        },
        song = songtable,
    }

    if #sram.buffer.soundSources < 3 then
        table.insert(buffer.soundSources, SoundSource)
    end
end

function sram.update(tag)
    for _, soundSource in pairs(buffer.soundSources) do
        if soundSource.tag == "$" .. tag then
            if soundSource.meta.isPlaying then
                soundSource.meta.msElapsed = soundSource.meta.msElapsed + 1
                if soundSource.meta.msElapsed > soundSource.song[soundSource.meta.currentSection][5] then
                    soundSource.meta.msElapsed = 0
                    soundSource.meta.currentSection = soundSource.meta.currentSection + 1
                    if soundSource.meta.isLooped then
                        soundSource.meta.currentSection = 1
                    else
                        soundSource.meta.currentSection = #soundSource.song
                        soundSource.meta.isPlaying = false
                    end
                end
            end
        end
    end
end

return sram 