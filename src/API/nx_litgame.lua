litgame = {}

--- Close the Litium window
function litgame.quit()
    love.event.quit()
end

--- Restart the current instance of Litium
function litgame.restart()
    love.event.quit("restart")
end

function litgame.objectMeeting(object1, object2)
    object1.w = #object1.sprite[1]
    object1.h = #object1.sprite

    object2.w = #object2.sprite[1]
    object2.h = #object2.sprite
    return 
    (object1.x) < (object2.x) + (object2.w * object2.size) and
    (object1.x) + (object1.w * object1.size) > (object2.x) and
    (object1.y) < (object2.y) + (object2.h * object2.size) and
    (object1.h * object1.size) + (object1.y) > (object2.y)
end

return litgame