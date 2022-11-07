WateringCan = {}

setmetatable(WateringCan, {__index = Item})

function WateringCan:load()
    self.name = "WateringCan"
    self.width = 116
    self.height = 92
    self.itemWidth = 42
    self.itemHeight = 24 
    self.value = 100
    self.icon = love.graphics.newImage("assets/items/WateringCan.png")
    self.sprite = love.graphics.newImage("assets/items/wateringCanAnimation.png")
    self.type = "tool"
    self.options = {
        name = self.name,
        width = self.width,
        height = self.height,
        itemWidth = self.itemWidth,
        itemHeight = self.itemHeight,
        icon = self.icon,
        sprite = self.sprite,
        type = self.type,
        scale = self.scale,
    }

    self.iconScale = 1.5
    self.grid = anim8.newGrid(self.width, self.height, self.sprite:getWidth(), self.sprite:getHeight())
    self.animationFrames = 2
    self.animationTimer = 0
    self.animationMaxTimer = player:getUsingItemTimer()
    self.animationMaxFrameTimer = self.animationMaxTimer / self.animationFrames
    self.animations = {
        front = anim8.newAnimation(self.grid('1-2', 1), self.animationMaxFrameTimer),
        back = anim8.newAnimation(self.grid('1-2', 2), self.animationMaxFrameTimer),
        right = anim8.newAnimation(self.grid('1-2', 3), self.animationMaxFrameTimer),
        left = anim8.newAnimation(self.grid('1-2', 4), self.animationMaxFrameTimer)
    }
    self.x, self.y = player:getPosition()
    self.lastDirection = player:getLastDirection()
    self.currentAnimation = self.animations[self.lastDirection]
end

function WateringCan:new()
    local newWateringCan = Item:new(self.options)
    
    newWateringCan.iconOffset = {
        x = -3,
        y = 0
    }
    self.__index = self
    setmetatable(newWateringCan, self)
    return newWateringCan
end

function WateringCan:update(dt)
    self:updateItem(dt)
end

function WateringCan:use()
    self.animating = true
end