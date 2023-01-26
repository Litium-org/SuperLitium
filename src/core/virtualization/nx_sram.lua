sram = {}

local soundTH = require 'src.core.virtualization.drivers.nx_sound-drv'

buffer = {
    soundSources = {}
}
function findByTag(tag)
    for k, addr in pairs(buffer.soundSources) do
        if addr.tag == "$" .. tag then
            return k
        end
    end
end

function sram.newSoundSource(tag, songtable)
    SoundSource = {
        tag = "$" .. string.sub(tag, 1, 8),
        meta = {
            isPlaying = false,
            isLooped = false,
            msElapsed = 0,
            currentSection = 1      -- Section structure : {frequency, phase, length, type, waitMS}
        },
        song = songtable,
    }

    if #buffer.soundSources < 3 then
        table.insert(buffer.soundSources, SoundSource)
    end
end

function sram.update(tag)
    for _, soundSource in pairs(buffer.soundSources) do
        if soundSource.meta.isPlaying then
            soundSource.meta.msElapsed = soundSource.meta.msElapsed + 1
            if soundSource.meta.msElapsed > soundSource.song[soundSource.meta.currentSection][4] then
                soundSource.meta.msElapsed = 0
                soundTH.newTone(
                    soundSource.song[soundSource.meta.currentSection][1],
                    soundSource.song[soundSource.meta.currentSection][2],
                    soundSource.song[soundSource.meta.currentSection][3]
                )
                soundSource.meta.currentSection = soundSource.meta.currentSection + 1
                if soundSource.meta.isLooped then
                    soundSource.meta.currentSection = 1
                else
                    if soundSource.meta.currentSection > #soundSource.song then
                        soundSource.meta.currentSection = #soundSource.song - 1
                        soundSource.meta.isPlaying = false
                        return true
                    end
                end
            end
        end
    end
end

function sram.play(tag, loop)
    local id = findByTag(tag)
    buffer.soundSources[id].meta.isPlaying = true
    buffer.soundSources[id].meta.isLooped = loop
    print(debugcomponent.showTableContent(buffer.soundSources))
end

function sram.pause(tag)
    local id = findByTag(tag)
    buffer.soundSources[id].meta.isPlaying = false
end

function sram.stop(tag)
    local id = findByTag(tag)
    buffer.soundSources[id].meta.isPlaying = false
    buffer.soundSources[id].meta.currentSection = 1
end

return sram 