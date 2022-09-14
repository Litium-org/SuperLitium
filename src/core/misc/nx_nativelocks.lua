nativelocks = {}

function nativelocks.lock()

    --[[: OS Lib :]]--
    os.execute = nil
    os.difftime = nil
    os.getenv = nil
    os.remove = nil
    os.rename = nil
    os.setlocale = nil

    --[[: IO Lib :]]--
    io.flush = nil
    io.popen = nil

    --[[: LOVE Functions :]]--

    -- graphics --
    love.graphics.applyTransform = nil
    love.graphics.arc = nil
    love.graphics.captureScreenshot = nil
    love.graphics.circle = nil
    love.graphics.discard = nil
    love.graphics.draw = nil
    love.graphics.drawInstanced = nil
    love.graphics.drawLayer = nil
    love.graphics.ellipse = nil
    love.graphics.flushBatch = nil
    love.graphics.newArrayImage = nil
    love.graphics.newCanvas = nil
    love.graphics.newCubeImage = nil
    love.graphics.newFont = nil
    love.graphics.newImage = nil
    love.graphics.newImageFont = nil
    love.graphics.newMesh = nil
    love.graphics.newParticleSystem = nil
    love.graphics.newQuad = nil
    love.graphics.newShader = nil
    love.graphics.newText = nil
    love.graphics.newVideo = nil
    love.graphics.newVolumeImage = nil
    love.graphics.setNewFont = nil
    love.graphics.print = nil
    love.graphics.printf = nil

    -- Audio --

    love.audio.getActiveEffects = nil
    love.audio.getActiveSourceCount = nil
    love.audio.getDistanceModel = nil
    love.audio.getDopplerScale = nil
    love.audio.getEffect = nil
    love.audio.getMaxSceneEffects = nil
    love.audio.getMaxSourceEffects = nil
    love.audio.getOrientation = nil
    love.audio.getPosition = nil
    love.audio.getRecordingDevices = nil
    love.audio.getVelocity = nil
    love.audio.getVolume = nil
    love.audio.isEffectsSupported = nil
    love.audio.newQueueableSource = nil
    love.audio.pause = nil
    love.audio.play = nil
    love.audio.setActiveEffects = nil
    love.audio.setActiveSourceCount = nil
    love.audio.setDistanceModel = nil
    love.audio.setDopplerScale = nil
    love.audio.setEffect = nil
    love.audio.setMaxSceneEffects = nil
    love.audio.setMaxSourceEffects = nil
    love.audio.setOrientation = nil
    love.audio.setPosition = nil
    love.audio.setRecordingDevices = nil
    love.audio.setVelocity = nil
    love.audio.setVolume = nil

    -- sound --

    love.sound.newDecoder = nil
end

return nativelocks