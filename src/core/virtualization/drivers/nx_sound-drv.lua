soundthread = {}

function soundthread.newTone(freq, wavelength, type)
    -- I stole this shit from love2d example XDDDD
    local rate      = 44100 
    local length    = wavelength / 32 
    local tone      = freq
    local phase     = math.floor(rate / tone) 
    local soundData = love.sound.newSoundData(math.floor(length * rate), rate, 16, 1)
    for i = 0, soundData:getSampleCount() - 1 do
        switch(type, 
        {
            ["square"] = function()
                soundData:setSample(i, i % phase < phase / 2 and 1 or -1) 
            end,
            ["sine"] = function()
                soundData:setSample(i, math.sin(2 * math.pi * i / phase))
            end,
            ["noise"] = function()
                soundData:setSample(i, math.random())
            end
        })
    end
    snd = love.audio.newSource(soundData)
    return snd
end

return soundthread