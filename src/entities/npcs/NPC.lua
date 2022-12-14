NPC = {}
setmetatable(NPC, { __index = Entity })

function NPC:new()
    local newNPC = Entity:new() 
    self.__index = self
    setmetatable(newNPC, self)
    return newNPC
end

function NPC:newNPC(x, y)
    self.x = x
    self.y = y
    self.originalPosition = {
        x = x,
        y = y,
    }
    self.collider = world:newRectangleCollider(x, y, self.width * self.scale, self.height * self.scale)
    self.collider:setFixedRotation(true)
    self.collider:setCollisionClass("NPC")
    self.collider:setObject(self)
end

function NPC:loadNPC()
    local directions = {"front", "back", "left", "right"}
    self.lastDirection = directions[math.random(1, #directions)]
    self.timer = 0
    self.maxTimer = math.random(0, 5) + math.random()
    self.interactionFont = love.graphics.newFont("assets/fonts/8bitOperatorPlus8-Regular.ttf", 64)
    self.interactionFont:setFilter("nearest", "nearest")
    self.interactionTextScale = 0.125 -- 1/8
    self.interactionTimer = 0.0
    self.interactionMaxTimer = 1
    self.isInteracting = false
    
    self.currentAnimation = self.animations.idle[self.lastDirection]
    self.currentSpriteSheet = self.spriteSheets.idle.sprite

    self.timer = 0.0
    local falseTrue = {false, true}
    self.isMoving = falseTrue[math.random(2)]
    self.maxTimer = math.random(0, 5) + math.random()
end

function NPC:newCollider()
    self.collider = world:newRectangleCollider(self.x, self.y, self.width * self.scale, self.height * self.scale)
    self.collider:setFixedRotation(true)
    self.collider:setCollisionClass("NPC")
    self.collider:setObject(self)
end

function NPC:getObject(name)
    if self.name == name then
        return self
    end
end

function NPC:getIsInteracting()
    return self.isInteracting
end

function NPC:setIsInteracting(isInteracting)
    self.isInteracting = isInteracting
end

function NPC:checkCollision()
    if self.collider:enter("Collision") then
        self.maxTimer = math.random(0, 5) + math.random()
        self.timer = 0.0

        local vx, vy = self.collider:getLinearVelocity()
        if self.lastDirection == "front" then
            self.lastDirection = "back"
            vy = -vy
        elseif self.lastDirection == "back" then
            self.lastDirection = "front"
            vy = -vy
        elseif self.lastDirection == "left" then
            self.lastDirection = "right"
            vx = -vx
        elseif self.lastDirection == "right" then
            self.lastDirection = "left"
            vx = -vx
        end

        self.collider:setLinearVelocity(vx, vy)
    end
end

function NPC:update(dt)
    -- generally this function is overriden for other updating purposes besides character movement
    self:updateNPC(dt)
end

function NPC:updateNPC(dt)
    self.timer = self.timer + dt
    if self.timer > self.maxTimer then
        local falseTrue = {false, true}
        self.isMoving = falseTrue[math.random(2)]
        self.timer = 0.0
        self.maxTimer = math.random(0, 5) + math.random()

        if self.isMoving then
            local directions = {"front", "back", "left", "right"}
            self.lastDirection = directions[math.random(1, #directions)]
        end
    end

    self:move(dt)
    self:updateCollider(dt)
    self:checkLimit()
    if self.isMoving then
        self:checkCollision()
    end

    if self.isInteracting then
        self.interactionTimer = self.interactionTimer + dt
        if self.interactionTimer >= self.interactionMaxTimer then
            self.isInteracting = false
            self.interactionTimer = 0.0
        end
    end
end

function NPC:move(dt)
    local vx = 0
    local vy = 0
    if self.isMoving then
        self.currentSpriteSheet = self.spriteSheets.walking.sprite
        self.currentAnimation = self.animations.walking[self.lastDirection]
        if self.lastDirection == "front" then
            vy = self.speed
        elseif self.lastDirection == "back" then
            vy = -self.speed
        elseif self.lastDirection == "left" then
            vx = -self.speed
        elseif self.lastDirection == "right" then
            vx = self.speed
        end
    else
        self.currentSpriteSheet = self.spriteSheets.idle.sprite
        self.currentAnimation = self.animations.idle[self.lastDirection]
    end

    self.collider:setLinearVelocity(vx, vy)
    self.currentAnimation:update(dt)
end

function NPC:checkLimit()
    if self.x < self.originalPosition.x - self.limits.left then
        self.x = self.originalPosition.x - self.limits.left
        self.lastDirection = "right"
    elseif self.x > self.originalPosition.x + self.limits.right then
        self.x = self.originalPosition.x + self.limits.right
        self.lastDirection = "left"
    end

    if self.y < self.originalPosition.y - self.limits.up then
        self.y = self.originalPosition.y - self.limits.up
        self.lastDirection = "front"
    elseif self.y > self.originalPosition.y + self.limits.down then
        self.y = self.originalPosition.y + self.limits.down
        self.lastDirection = "back"
    end

    self.collider:setPosition(self.x, self.y)
end

function NPC:getCollider()
    return self.collider
end

function NPC:updateCollider(dt)
    self.x = self.collider:getX()
    self.y = self.collider:getY()
end

function NPC:draw()
    -- generally this function is overriden for other drawing purposes besides character drawing
    self:drawNPC()
    if self.isInteracting then
        self:interactWithPlayer()
    end
end

function NPC:printMessage(text)
    love.graphics.setFont(self.interactionFont)
    local textWidth = self.interactionFont:getWidth(text)
    local textHeight = self.interactionFont:getHeight(text)
    local textX = self.x + self.width * self.scale / 2 - textWidth * self.interactionTextScale
    local textY = self.y - self.height * self.scale / 2 - textHeight * self.interactionTextScale
    love.graphics.print(text, textX, textY, nil, self.interactionTextScale, self.interactionTextScale)
    
    -- default font
    love.graphics.setNewFont(12)
end

function NPC:drawNPC()
    self.currentAnimation:draw(self.currentSpriteSheet, self.x, self.y, 0, self.scale, self.scale, self.width / 2, self.height / 2)
end

function NPC:interactWithPlayer()
    error("This function must be overriden")
end

function NPC:angleToPlayer()
    local playerX, playerY = player:getCenteredPosition()
    local hypothenuse = math.sqrt(math.pow((playerX - self.x), 2) + math.pow((playerY - self.y), 2))
    local angle = math.acos((playerX - self.x) / hypothenuse)
    return angle
end