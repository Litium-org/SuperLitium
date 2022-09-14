sram = {}

soundTH = require 'src.core.virtualization.drivers.nx_sound-drv'

sram.buffer = {
    toneSources = {},
    soundSources = {}
}

function sram.newToneSource(tag, freq, waveLenght, type)
    Tone = {
        frequency = freq,
        lenght = waveLenght,
        type = type,
        soundSource = soundTH.newTone(Tone.frequency, Tone.lenght, Tone.type)
    }

    table.insert(sram.buffer.toneSources, Tone)
end

function sram.playTone()
    
end

return sram 