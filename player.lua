player = {}

function player:load()
    self.x = 0
    self.y = 0
    self.width = 20
    self.height = 20
    self.speed = 75
    self.collider = world:newRectangleCollider(self.x, self.y, self.width, self.height)
    self.collider:setFixedRotation(true)
end

function player:update(dt)
    self:move(dt)
    self:updateCollider()
end

function player:move(dt)
    local vx = 0
    local vy = 0
    if love.keyboard.isDown("w") then
        vy = -self.speed
    end

    if love.keyboard.isDown("a") then
        vx = -self.speed
    end

    if love.keyboard.isDown("s") then
        vy = self.speed
    end

    if love.keyboard.isDown("d") then 
        vx = self.speed
    end

    self.collider:setLinearVelocity(vx, vy)
end

function player:updateCollider()
    self.x = self.collider:getX() - self.width / 2
    self.y = self.collider:getY() - self.height / 2
end

function player:draw()
    love.graphics.rectangle("line", self.x, self.y, self.height, self.width)
end