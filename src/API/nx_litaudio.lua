litaudio = {}
litaudio.control = {}

local sram = require 'src.core.virtualization.nx_sram'

---create a new sound source but don't play it
---@param sourceName string
---@param songData table
function litaudio.newSource(sourceName, songData)
    sram.newSoundSource(sourceName, songData)
end

---update sound sources and play based on tag
---@param sourceName string
function litaudio.updateSource(sourceName)
    sram.update(sourceName)
end

---Play a sound source based on tag
---@param tag string
---@param loop boolean
function litaudio.control.play(tag, loop)
    sram.play(tag, loop)
end

---Pause a sound source based on tag
---@param tag string
function litaudio.control.pause(tag)
    sram.pause(tag)
end

---Stop a sound source based on tag
---@param tag string
function litaudio.control.stop(tag)
    sram.stop(tag)
end

return litaudio