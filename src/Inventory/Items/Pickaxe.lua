Pickaxe = {}

setmetatable(Pickaxe, { __index = Item })

function Pickaxe:load()
    self.name = "Pickaxe"
    self.width = 116
    self.height = 92
    self.itemWidth = 42
    self.itemHeight = 27
    self.value = 100
    self.icon = love.graphics.newImage("assets/items/Pickaxe.png")
    self.sprite = love.graphics.newImage("assets/items/pickaxeAnimation.png")
    self.type = "tool"
    self.scale = player:getScale()

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


function Pickaxe:new()
    local newPickaxe = Item:new(self.options)
    self.__index = self
    setmetatable(newPickaxe, self)
    return newPickaxe
end

function Pickaxe:update(dt)
    self:updateItem(dt)
end

function Pickaxe:use()
    self.animating = true
    self:updatePosition()
    local colliders = world:queryRectangleArea(self.x, self.y, self.itemWidth, self.itemHeight, {"Tree"})
    if #colliders > 0 then
        local tree = colliders[1]:getObject()
    end
end