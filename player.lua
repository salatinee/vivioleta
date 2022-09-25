player = {}

function player:load()
    self.x = 100
    self.y = 100
    self.width = 58
    self.height = 92
    self.scale = 0.33
    local idleFront = love.graphics.newImage("sprites/newIdleFront.png")
    self.spriteSheets = {

        front = {
            idle = idleFront,
            grid = anim8.newGrid(58, 92, idleFront:getWidth(), idleFront:getHeight())
        },

        back = {

        },

        left = {

        },

        right = {
            
        },
    }

    self.animations = {
        front = anim8.newAnimation(self.spriteSheets.front.grid('1-2', 1), 0.5)
    }
    self.speed = 75
    self.collider = world:newRectangleCollider(self.x, self.y, self.width * self.scale, self.height * self.scale)
    self.collider:setFixedRotation(true)
end

function player:update(dt)
    self:move(dt)
    self:updateCollider()
end

function player:move(dt)
    local vx = 0
    local vy = 0
    local isMoving = false
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

    if vx ~= 0 or vy ~= 0 then
        isMoving = true
    end

    self.collider:setLinearVelocity(vx, vy)
    if not isMoving then
        self.animations.front:update(dt)
    end
end

function player:updateCollider()
    self.x = self.collider:getX() - self.width * self.scale / 2
    self.y = self.collider:getY() - self.height * self.scale / 2
end

function player:getDimensions()
    return self.x * scale, self.y * scale
end

function player:draw()
    self.animations.front:draw(self.spriteSheets.front.idle, self.x, self.y, nil, self.scale, self.scale)
end