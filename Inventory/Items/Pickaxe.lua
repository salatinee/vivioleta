local options = {
    name = "Pickaxe",
    width = 116,
    height = 92,
    itemWidth = 42,
    itemHeight = 27,
    value = 100,
    icon = love.graphics.newImage("sprites/Items/Pickaxe.png"),
    sprite = love.graphics.newImage("sprites/Items/pickaxeAnimation.png"),
    type = "tool",
    scale = 1,
}

Pickaxe = Item:new(options)

function Pickaxe:load()
    self.grid = anim8.newGrid(self.width, self.height, self.sprite:getWidth(), self.sprite:getHeight())
    self.animationFrames = 2
    self.animationTimer = 0
    self.animationMaxTimer = player:getUsingItemTimer()
    self.animationMaxFrameTimer = self.animationMaxTimer / self.animationFrames
    self.animating = false
    self.animations = {
        front = anim8.newAnimation(self.grid('1-2', 1), self.animationMaxFrameTimer),
        back = anim8.newAnimation(self.grid('1-2', 2), self.animationMaxFrameTimer),
        right = anim8.newAnimation(self.grid('1-2', 3), self.animationMaxFrameTimer),
        left = anim8.newAnimation(self.grid('1-2', 4), self.animationMaxFrameTimer)
    }

    self.lastDirection = player:getLastDirection()
    self.currentAnimation = self.animations[self.lastDirection]
end


function Pickaxe:new()

    local newPickaxe = Item:new(options)
    self.__index = self
    setmetatable(newPickaxe, self)
    return newPickaxe
end

function Pickaxe:animate(dt)

    self.currentAnimation = self.animations[self.lastDirection]
    self.animationTimer = self.animationTimer + dt
    if self.animationTimer > self.animationMaxTimer then
        self.animationTimer = 0
        self.animating = false
        self.currentAnimation:gotoFrame(1)
    else
        self.currentAnimation:update(dt)
    end
end

function Pickaxe:update(dt)
    if self.animating then
        self:animate(dt)
    end
end

function Pickaxe:draw()
    if self.animating then
        self.lastDirection = player:getLastDirection()
        local playerScale = player:getScale()
        local playerX, playerY = player:getPosition()
        local playerSprite = player:getCurrentSpriteSheet()
        local playerWidth, playerHeight = player:getDimensions()
        local differenceX = ((self.sprite:getWidth() / 2 - playerHeight) * playerScale) / 2 - 1
        self.x = playerX - self.itemWidth * playerScale / 2 - differenceX
        self.y = playerY
        self.currentAnimation:draw(self.sprite, self.x, self.y, self.rotation, playerScale)
    end
end