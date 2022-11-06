soundTH = {}

function soundTH.newTone(freq, phase, type)
    local samplerate = 44100
    local freq = 440.0
    local SD = love.sound.newSoundData(256,samplerate,8,1)
    local phase = 0.0
    
    wave = {
        sine = function(phase, frequency) 
            return math.sin(phase * 2.0 * math.pi * frequency) 
        end,
        triangle = function(phase, frequency) 
            return 4.0 * math.abs((phase * frequency) - math.floor(phase * frequency) - .5) - 1.0 
        end,
    
        square = function(phase, frequency)
            return 2.0 * (2.0 *  math.floor(phase * frequency) - math.floor(2.0 * phase * frequency)) + 1.0
        end,
        sawtooth = function(phase, frequency)
            return 1.0 - (((phase * frequency) % 1.0) * 2.0)
        end,
        noise      = function(phase, frequency) return love.math.random() end
    }
    
    for i=0, SD:getSampleCount()-1 do
        phase = phase + (freq / samplerate)
        SD:SetSample(i, wave[type](phase))
    end
end

return soundTH