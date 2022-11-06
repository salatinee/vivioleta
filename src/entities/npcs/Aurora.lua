Aurora = {}
setmetatable(Aurora, { __index = NPC })

function Aurora:new(x, y)
    local newAurora = NPC:new()
    self:newNPC(x, y)
    self.__index = self
    setmetatable(newAurora, self)
    return newAurora
end

function Aurora:load()
    self.name = "Aurora"
    self.scale = 0.67
    self.x = nil
    self.y = nil
    self.speed = 30
    self.width = 17
    self.height = 48
    self.limit = 50

    self.spriteSheets = {
        idle = {
            sprite = love.graphics.newImage("assets/npcs/Aurora/idle.png"),
        },

        walking = {
            sprite = love.graphics.newImage("assets/npcs/Aurora/walking.png"),
        }
    }
    self.spriteSheets.idle.sprite:setFilter("nearest", "nearest")
    self.spriteSheets.idle.grid = anim8.newGrid(self.width, self.height, self.spriteSheets.idle.sprite:getWidth(), self.spriteSheets.idle.sprite:getHeight())


    self.spriteSheets.walking.sprite:setFilter("nearest", "nearest")
    self.spriteSheets.walking.grid = anim8.newGrid(self.width, self.height, self.spriteSheets.walking.sprite:getWidth(), self.spriteSheets.walking.sprite:getHeight())

    self.limits = {
        up = self.limit,
        down = self.limit,
        right = self.limit,
        left = self.limit
    }

    self.animations = {
        idle = {
            front = anim8.newAnimation(self.spriteSheets.idle.grid('1-2', 1), 0.75),
            back = anim8.newAnimation(self.spriteSheets.idle.grid('1-2', 2), 0.75),
            right = anim8.newAnimation(self.spriteSheets.idle.grid('1-2', 3), 0.75),
            left = anim8.newAnimation(self.spriteSheets.idle.grid('1-2', 4), 0.75),
        },
        
        walking = {
            front = anim8.newAnimation(self.spriteSheets.walking.grid('1-8', 1), 0.1),
            back = anim8.newAnimation(self.spriteSheets.walking.grid('1-8', 2), 0.1),
            right = anim8.newAnimation(self.spriteSheets.walking.grid('1-8', 3), 0.1),
            left = anim8.newAnimation(self.spriteSheets.walking.grid('1-8', 4), 0.1),
        }
    }

    self:loadNPC()
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

