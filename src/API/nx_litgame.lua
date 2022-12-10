litgame = {}

--- module to provide collision detection
litgame.collision = {}

--- Close the Litium window
function litgame.quit()
    love.event.quit()
end

--- Restart the current instance of Litium
function litgame.restart()
    love.event.quit("restart")
end

--- Provide a rectangle collision check for 2 objects
--- Check wiki for how to setup a object.
---@param object1 table
---@param object2 table
---@return boolean
function litgame.collision.objectMeeting(object1, object2)
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

--- Provide a rectangle collision check for 2 rectangles
---@param rect1 table
---@param rect2 table
---@return boolean
function litgame.collision.rectMetting(rect1, rect2)
    return
    rect1.x < rect2.x + rect2.w and
    rect1.x + rect1.w > rect2.x and
    rect1.y < rect2.y + rect2.h and
    rect1.h + rect1.y > rect2.y
end

return litgame