Pickaxe = {}
Pickaxe.animationFrames = 2
Pickaxe.currentFrame = 1
Pickaxe.animationTimer = 0
Pickaxe.animationMaxFrameTimer = 0.25
Pickaxe.animationMaxTimer = Pickaxe.animationMaxFrameTimer * Pickaxe.animationFrames

function Pickaxe:new()
    local newPickaxe = Item:new("Pickaxe", 100, love.graphics.newImage("Assets/Items/Pickaxe.png"), nil, -- sprite
    "tool", 1)
    newPickaxe.animating = false
    self.__index = self
    setmetatable(newPickaxe, self)
    return newPickaxe
end

function Pickaxe:animate(dt)
    self.animationTimer = self.animationTimer + dt
    if self.animationTimer > self.animationMaxFrameTimer then
        self.currentFrame = self.currentFrame + 1
        if self.currentFrame > self.animationFrames then
            self.animating = false
            self.animationTimer = 0
        end
    end

    if self.currentFrame == 1 then
        self.rotation = 0
    else
        self.rotation = 3 * math.pi / 4 -- 135°
    end
end



function Pickaxe:update(dt)
    if self.animating then
        self:animate(dt)
    end
end

function Pickaxe:draw()
    if self.animating then
        local playerX, playerY = player:getCenteredPosition()
        local playerWidth, _ = player:getDimensions()
        self.x = playerX + playerWidth / 2 - self.width / 2 + 10
        self.y = playerY - self.height / 2
        love.graphics.draw(self.image, self.x, self.y, self.rotation, self.scale, self.scale, self.width, self.height)
    end
end