litgame = {}

--- Close the Litium window
function litgame.quit()
    love.event.quit()
end

--- Restart the current instance of Litium
function litgame.restart()
    love.event.quit("restart")
end

return litgame