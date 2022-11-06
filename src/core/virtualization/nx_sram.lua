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
        if addr.tag == tag then
            return buffer.soundSources[k], k
        end
    end
end

function sram.newSource(tag, songtable)
    SoundSource = {
        tag = "$" .. string.sub(tag, 1, 8),
        song = songtable,
        meta = {
            isPlaying = false,
            msElapsed = 0,
            currentSection = 1      -- Section structure : {frequency, pitch, length, type}
        }
    }

    if #sram.buffer.soundSources < 4 then
        table.insert(buffer.soundSources, SoundSource)
    end
end

return sram 