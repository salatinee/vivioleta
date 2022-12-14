player = {}

function player:load()
    self.x = 176
    self.y = 256 
    self.width = 58
    self.height = 92
    self.scale = 0.33
    self.centeredX = self.x + self.width * self.scale / 2
    self.centeredY = self.y + self.height * self.scale / 2
    local idle = love.graphics.newImage("assets/vivi/idle.png")
    local walking = love.graphics.newImage("assets/vivi/walking.png")
    local usingItem = love.graphics.newImage("assets/vivi/usingItem.png")
    local usingItem2 = love.graphics.newImage("assets/vivi/usingItem2.png")
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
    self:newCollider()
    self.currentAnimation = self.animations.idle.front
    self.currentSpriteSheet = self.spriteSheets.idle.sprite
    self.speed = 75
    self.usingItem = false
    self.usingItemTimer = 0.0
    self.usingItemMaxTimer = self.animations.usingItem.front.totalDuration
end

function player:getUsingItemTimer()
    return self.usingItemMaxTimer
end

function player:update(dt)
    self:animate(dt)
    self:updateCollider()
    self:checkBoundaries()
    if self.usingItem then
        self.usingItemTimer = self.usingItemTimer + dt
        if self.usingItemTimer >= self.usingItemMaxTimer then
            self.currentAnimation = self.animations.idle[self.lastDirection]
            self.currentSpriteSheet = self.spriteSheets.idle.sprite
            self:changeUsingItemState()
            self.usingItemTimer = 0.0
            self.currentAnimation:gotoFrame(1)
        end
    end
end

function player:animate(dt)
    if not self.usingItem then
        self:move(dt)
        self.currentAnimation2 = nil
        self.currentSpriteSheet2 = nil
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

function player:setPosition(x, y)
    x = x or self.x + self.width * self.scale / 2
    y = y or self.y + self.height * self.scale / 2
    self.collider:setPosition(x, y)
    self.interactionCollider:setPosition(x, y)
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

function player:calculateBoundaryPosition(direction)
    local position = {
        x = nil,
        y = nil
    }

    local mapWidth, mapHeight = _G.currentMap:getDimensions()
    local width, height = self.width * self.scale, self.height * self.scale
    local offsetX = 5 * scale

    if direction == "up" then
        position.x, position.y = nil, mapHeight - height / 2
    elseif direction == "down" then
        position.x, position.y = nil, height / 2
    elseif direction == "left" then
        position.x, position.y = mapWidth - width / 2 - offsetX, nil
    elseif direction == "right" then
        position.x, position.y = width / 2 + offsetX, nil
    end

    return position
end

function player:resetPosition(direction)
    local position = self:calculateBoundaryPosition(direction)
    self:setPosition(position.x, position.y)
end

function player:checkBoundaries()

    local mapWidth, mapHeight = _G.currentMap:getDimensions()
    local direction = nil

    local x, y = self:getCenteredPosition()
    local offsetX = 5 * scale
    local width, height = self.width * self.scale, self.height * self.scale
    if x < width / 2 then
        direction = "left"
        self:setPosition(width / 2, nil)
    elseif x > (mapWidth - width) then
        direction = "right"
        self:setPosition(mapWidth - width, nil)
    elseif y < height / 2 then
        direction = "up"
        self:setPosition(nil, height / 2)
    elseif y > (mapHeight - height / 2) then
        direction = "down"
        self:setPosition(nil, mapHeight - height / 2)
    end

    if direction then
        playerCamera:resetPosition()
        changeCurrentMap(direction)
    end
end

function player:updateCollider()
    self.x = self.collider:getX() - self.width * self.scale / 2
    self.y = self.collider:getY() - self.height * self.scale / 2
    self.centeredX = self.x + self.width * self.scale / 2
    self.centeredY = self.y + self.height * self.scale / 2
end

function player:reset()
    self:newCollider()
end

function player:newCollider()
    self.interactionCollider = world:newRectangleCollider(self.x + self.width * self.scale / 2, self.y + self.height * self.scale / 2 + self.interaction.height * 5/3, self.interaction.width, self.interaction.height)
    self.interactionCollider:setCollisionClass("PlayerInteraction")
    self.collider = world:newRectangleCollider(self.x, self.y, self.width * self.scale, self.height * self.scale)
    self.collider:setFixedRotation(true)
    self.collider:setCollisionClass("Player")
end

function player:getScale()
    return self.scale
end

function player:getCurrentSpriteSheet()
    return self.currentSpriteSheet
end

function player:getPositionScaled()
    local x = (self.x + self.width  * self.scale / 2) * scale
    local y = (self.y) * scale
    return x, y 
end

function player:draw()
    if self.usingItem then
        self.currentAnimation2:draw(self.currentSpriteSheet2, self.x, self.y, nil, self.scale)
        local currentItem = Inventory:getItemSelected()
        if currentItem ~= nil then
            if self.lastDirection ~= "front" then
                currentItem:draw()
            else
                self.currentAnimation:draw(self.currentSpriteSheet, self.x, self.y, nil, self.scale)
                currentItem:draw()
                return
            end
        end
    end
    self.currentAnimation:draw(self.currentSpriteSheet, self.x, self.y, nil, self.scale)
end