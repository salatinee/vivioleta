player = {}

function player:load()
    self.x = 176
    self.y = 256 
    self.width = 58
    self.height = 92
    self.scale = 0.33
    self.centeredX = self.x + self.width * self.scale / 2
    self.centeredY = self.y + self.height * self.scale / 2
    local idle = love.graphics.newImage("sprites/newIdle.png")
    local walking = love.graphics.newImage("sprites/newWalking.png")
    local usingItem = love.graphics.newImage("sprites/usingItem.png")
    local usingItem2 = love.graphics.newImage("sprites/usingItem2.png")
    self.spriteSheets = {
        idle = {
            sprite = idle,
            grid = anim8.newGrid(self.width, self.height, idle:getWidth(), idle:getHeight()),
        },

        walking = {
            sprite = walking,
            grid = anim8.newGrid(self.width, self.height, walking:getWidth(), walking:getHeight()),
        },

        usingItem = {
            sprite = usingItem,
            grid = anim8.newGrid(self.width, self.height, usingItem:getWidth(), usingItem:getHeight()),
        },

        usingItem2 = {
            sprite = usingItem2,
            grid = anim8.newGrid(self.width, self.height, usingItem2:getWidth(), usingItem2:getHeight()),
        },
    }

    self.animations = {
        idle = {
            front = anim8.newAnimation(self.spriteSheets.idle.grid('1-2', 1), 0.75),
            back = anim8.newAnimation(self.spriteSheets.idle.grid('1-2', 2), 0.75),
            right = anim8.newAnimation(self.spriteSheets.idle.grid('1-2', 3), 0.75),
            left = anim8.newAnimation(self.spriteSheets.idle.grid('1-2', 4), 0.75)
        },

        walking = {
            front = anim8.newAnimation(self.spriteSheets.walking.grid('1-8', 1), 0.1),
            back = anim8.newAnimation(self.spriteSheets.walking.grid('1-8', 2), 0.1),
            right = anim8.newAnimation(self.spriteSheets.walking.grid('1-8', 3), 0.1),
            left = anim8.newAnimation(self.spriteSheets.walking.grid('1-8', 4), 0.1)
        },

        usingItem = {
            front = anim8.newAnimation(self.spriteSheets.usingItem.grid('1-2', 1), 0.3),
            back = anim8.newAnimation(self.spriteSheets.usingItem.grid('1-2', 2), 0.3),
            right = anim8.newAnimation(self.spriteSheets.usingItem.grid('1-2', 3), 0.3),
            left = anim8.newAnimation(self.spriteSheets.usingItem.grid('1-2', 4), 0.3)
        },

        usingItem2 = {
            front = anim8.newAnimation(self.spriteSheets.usingItem2.grid('1-2', 1), 0.3),
            back = anim8.newAnimation(self.spriteSheets.usingItem2.grid('1-2', 2), 0.3),
            right = anim8.newAnimation(self.spriteSheets.usingItem2.grid('1-2', 3), 0.3),
            left = anim8.newAnimation(self.spriteSheets.usingItem2.grid('1-2', 4), 0.3)
        }
    }
    self.lastDirection = "front"
    -- interactionCollider is a collider so that it detects Player and NPC interaction, a bit ahead of the player
    self.interaction = {
        width = 10,
        height = 10
    }
    self.interactionCollider = world:newRectangleCollider(self.x + self.width * self.scale / 2, self.y + self.height * self.scale / 2 + self.interaction.height * 5/3, self.interaction.width, self.interaction.height)
    self.interactionCollider:setCollisionClass("PlayerInteraction")
    self.currentAnimation = self.animations.idle.front
    self.currentSpriteSheet = self.spriteSheets.idle.sprite
    self.speed = 75
    self.collider = world:newRectangleCollider(self.x, self.y, self.width * self.scale, self.height * self.scale)
    self.collider:setFixedRotation(true)
    self.collider:setCollisionClass("Player")
    self.usingItem = false
    self.usingItemTimer = 0.0
    self.usingItemMaxTimer = self.animations.usingItem.front.totalDuration
end

function player:update(dt)
    self:animate(dt)
    self:updateCollider()
    if self.usingItem then
        self.usingItemTimer = self.usingItemTimer + dt
        if self.usingItemTimer >= self.usingItemMaxTimer then
            self:changeUsingItemState()
            self.usingItemTimer = 0.0
        end
    end
end

function player:animate(dt)
    if not self.usingItem then
        self:move(dt)
        self.currentAnimation2 = nil
        self.currentSpriteSheet2 = nil
        local vx, vy = self.collider:getLinearVelocity()
        if vx ~= 0 or vy ~= 0 then
            isMoving = true
            self.currentSpriteSheet = self.spriteSheets.walking.sprite
        else
            self.currentSpriteSheet = self.spriteSheets.idle.sprite
            self.currentAnimation = self.animations.idle[self.lastDirection]
        end
    else
        self.currentSpriteSheet = self.spriteSheets.usingItem.sprite
        self.currentAnimation = self.animations.usingItem[self.lastDirection]
        self.currentSpriteSheet2 = self.spriteSheets.usingItem2.sprite
        self.currentAnimation2 = self.animations.usingItem2[self.lastDirection]
        self:setCollidersVelocity(0, 0)
    end
    
    self.currentAnimation:update(dt)

    if self.currentAnimation2 ~= nil then
        self.currentAnimation2:update(dt)
    end
end

function player:move(dt)
    local vx = 0
    local vy = 0
    local isMoving = false
    local keysPressed = 0
    if love.keyboard.isDown("w") then
        vy = -self.speed
        self.currentAnimation = self.animations.walking.back
        self.lastDirection = "back"
        self.interactionCollider:setPosition(self.x + self.width * self.scale / 2, self.y + self.height * self.scale / 2 - self.interaction.height * 5/3)
        keysPressed = keysPressed + 1
    end

    if love.keyboard.isDown("a") then
        vx = -self.speed
        self.currentAnimation = self.animations.walking.left
        self.lastDirection = "left"
        self.interactionCollider:setPosition(self.x + self.width * self.scale / 2 - self.interaction.width * 5/3, self.y + self.height * self.scale / 2)
        keysPressed = keysPressed + 1
    end

    if love.keyboard.isDown("s") then
        vy = self.speed
        self.currentAnimation = self.animations.walking.front
        self.lastDirection = "front"
        self.interactionCollider:setPosition(self.x + self.width * self.scale / 2, self.y + self.height * self.scale / 2 + self.interaction.height * 5/3)
        keysPressed = keysPressed + 1
    end

    if love.keyboard.isDown("d") then 
        vx = self.speed
        self.currentAnimation = self.animations.walking.right
        self.lastDirection = "right"
        self.interactionCollider:setPosition(self.x + self.width * self.scale / 2 + self.interaction.width * 5/3, self.y + self.height * self.scale / 2)
        keysPressed = keysPressed + 1
    end

    if keysPressed >= 2 then
        vx = vx * 0.7071
        vy = vy * 0.7071
    end

    if vx ~= 0 or vy ~= 0 then
        isMoving = true
        self.currentSpriteSheet = self.spriteSheets.walking.sprite
    else
        self.currentSpriteSheet = self.spriteSheets.idle.sprite
        self.currentAnimation = self.animations.idle[self.lastDirection]
    end

    self:setCollidersVelocity(vx, vy)
end

function player:setCollidersVelocity(vx, vy)
    self.collider:setLinearVelocity(vx, vy)
    self.interactionCollider:setLinearVelocity(vx, vy)
end

function player:changeUsingItemState()
    self.usingItem = not self.usingItem
end

function player:checkInteractionWithNPC()
    local colliders = world:queryRectangleArea(self.interactionCollider:getX() - self.interaction.width / 2, self.interactionCollider:getY() - self.interaction.height / 2, self.interaction.width, self.interaction.height, {"NPC"})
    if #colliders > 0 then
        return colliders[1]:getObject()
    end
end

function player:getLastDirection()
    return self.lastDirection
end

function player:getCenteredPosition()
    return self.centeredX, self.centeredY
end

function player:getPosition()
    return self.x, self.y
end

function player:getDimensions()
    return self.width, self.height
end

function player:interactWithNPC()
    local npc = self:checkInteractionWithNPC()
    if npc ~= nil then
        npc:setIsInteracting(true)
    end
end

function player:updateCollider()
    self.x = self.collider:getX() - self.width * self.scale / 2
    self.y = self.collider:getY() - self.height * self.scale / 2
    self.centeredX = self.x + self.width * self.scale / 2
    self.centeredY = self.y + self.height * self.scale / 2
end


function player:getPositionScaled()
    local x = (self.x + self.width  * self.scale / 2) * scale
    local y = (self.y) * scale
    return x, y 
end

function player:draw()
    if self.usingItem then
        self.currentAnimation2:draw(self.currentSpriteSheet2, self.x, self.y, nil, self.scale)
        local currentItem = Inventory:getCurrentItem()
        -- currentItem:draw()
    end
    self.currentAnimation:draw(self.currentSpriteSheet, self.x, self.y, nil, self.scale)
end