soundthread = {}

function soundthread.newTone(freq, wavelength, type)
    -- I stole this shit from love2d example XDDDD
    local rate      = 44100 -- samples per second
    local length    = wavelength / 32  -- 0.03125 seconds
    local tone      = freq -- Hz
    local p         = math.floor(rate / tone) -- 100 (wave length in samples)
    local soundData = love.sound.newSoundData(math.floor(length * rate), rate, 16, 1)
    for i = 0, soundData:getSampleCount() - 1 do
        if type == "sine" then
            soundData:setSample(i, math.sin(2*math.pi*i/p)) -- sine wave.
        end
        if type == "square" then
            soundData:setSample(i, i%p<p/2 and 1 or -1)     -- square wave; the first half of the wave is 1, the second half is -1.
        end
    end
    return soundData
end

return soundthread