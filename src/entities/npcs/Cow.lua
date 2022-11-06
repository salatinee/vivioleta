Cow = {}
setmetatable(Cow, { __index = NPC })

function Cow:new(x, y)
    local newCow = NPC:new()
    self:newNPC(x, y)
    self.__index = self
    setmetatable(newCow, self)
    return newCow
end

function Cow:load()
    self.name = "Cow"
    self.scale = 1.1
    self.x = nil
    self.y = nil
    self.speed = 25
    self.width = 32
    self.height = 18
    self.limit = 50
    self.spriteSheets = {
        idle = {
            sprite = love.graphics.newImage("assets/npcs/Cow/idle.png"),
        },

        walking = {
            sprite = love.graphics.newImage("assets/npcs/Cow/Walking.png"),
        },
    }
    self.spriteSheets.idle.sprite:setFilter("nearest", "nearest")
    self.spriteSheets.idle.grid = anim8.newGrid(self.width, self.height, self.spriteSheets.idle.sprite:getWidth(), self.spriteSheets.idle.sprite:getHeight())


    self.spriteSheets.walking.sprite:setFilter("nearest", "nearest")
    self.spriteSheets.walking.grid = anim8.newGrid(self.width, self.height, self.spriteSheets.walking.sprite:getWidth(), self.spriteSheets.walking.sprite:getHeight())

    self.animations = {
        idle = {
            front = anim8.newAnimation(self.spriteSheets.idle.grid('1-2', 1), 0.75),
            back = anim8.newAnimation(self.spriteSheets.idle.grid('1-2', 2), 0.75),
            left = anim8.newAnimation(self.spriteSheets.idle.grid('1-2', 2), 0.75),
            right = anim8.newAnimation(self.spriteSheets.idle.grid('1-2', 1), 0.75)
        },
        
        walking = {
            front = anim8.newAnimation(self.spriteSheets.walking.grid('1-4', 1), 0.3),
            back = anim8.newAnimation(self.spriteSheets.walking.grid('1-4', 2), 0.3),
            left = anim8.newAnimation(self.spriteSheets.walking.grid('1-4', 2), 0.3),
            right = anim8.newAnimation(self.spriteSheets.walking.grid('1-4', 1), 0.3)
        }
    }

    self.limits = {
        up = self.limit,
        down = self.limit,
        right = self.limit,
        left = self.limit
    }

    self:loadNPC()

end

function Cow:getself(x, y, limit)


    return self
end

function Cow:update(dt)
    self:updateNPC(dt)
    if self.isInteracting then
        self.interactionTimer = self.interactionTimer + dt
        if self.interactionTimer >= self.interactionMaxTimer then
            self.isInteracting = false
            self.interactionTimer = 0.0
        end
    end
end

function Cow:interactWithPlayer()
    self:printMessage("moo!")
end