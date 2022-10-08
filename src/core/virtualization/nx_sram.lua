sram = {}

soundTH = require 'src.core.virtualization.drivers.nx_sound-drv'

sram.buffer = {
    soundSources = {}
}

function sram.newToneSource(tag, soundTable)
    SoundSource = {
        tag = "$" .. string.sub(tag, 1, 8),
        sndtbl = soundTable
    }

    if #sram.buffer.soundSources < 5 then
        table.insert(sram.buffer.soundSources, SoundSource)
    end
end

function sram.play(tag, loop)
    
end

return sram 