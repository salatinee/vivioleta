Aurora = NPC:new()

function Aurora:new(x, y, limit)
    local width = 17
    local height = 48
    local scale = 0.67
    local speed = 30
    local idleImage = love.graphics.newImage("assets/npcs/Aurora/idle.png")
    idleImage:setFilter("nearest", "nearest")
    local idleGrid = anim8.newGrid(width, height, idleImage:getWidth(), idleImage:getHeight())
    local walkingImage = love.graphics.newImage("assets/npcs/Aurora/walking.png")
    walkingImage:setFilter("nearest", "nearest")
    local walkingGrid = anim8.newGrid(width, height, walkingImage:getWidth(), walkingImage:getHeight())
    local newAurora = NPC:new()
    -- name, scale, x, y, width, height, speed, idleImage, idleGrid, walkingImage, walkingGrid, limit
    newAurora.options = NPC.createOptions("Aurora", scale, x, y, width, height, speed, idleImage, idleGrid, walkingImage, walkingGrid, limit)

    newAurora.options.animations = {
        idle = {
            front = anim8.newAnimation(idleGrid('1-2', 1), 0.75),
            back = anim8.newAnimation(idleGrid('1-2', 2), 0.75),
            right = anim8.newAnimation(idleGrid('1-2', 3), 0.75),
            left = anim8.newAnimation(idleGrid('1-2', 4), 0.75),
        },
        
        walking = {
            front = anim8.newAnimation(walkingGrid('1-8', 1), 0.1),
            back = anim8.newAnimation(walkingGrid('1-8', 2), 0.1),
            right = anim8.newAnimation(walkingGrid('1-8', 3), 0.1),
            left = anim8.newAnimation(walkingGrid('1-8', 4), 0.1),
        }
    }

    self.__index = self
    setmetatable(newAurora, self)
    return newAurora
end

function Aurora:interactWithPlayer()
    self.isMoving = false
    self:printMessage("oi!!")
end

function Aurora:update(dt)
    self:updateNPC(dt)
    if not self.isMoving then
        self:facePlayer()
    end
end

function Aurora:facePlayer()
    local angle = self:angleToPlayer()
    local _, playerY = player:getCenteredPosition()

    if angle > 0 and angle < math.pi / 2 then
        self.lastDirection = "right"
    elseif angle > 2 * math.pi / 3 then
        self.lastDirection = "left"
    elseif self.y <= playerY then
        self.lastDirection = "front"
    else
        self.lastDirection = "back"
    end

end

