Cow = NPC:new()

function Cow:new(x, y, limit)
    local width = 32
    local height = 18
    local idleImage = love.graphics.newImage("assets/npcs/Cow/idle.png")
    idleImage:setFilter("nearest", "nearest")
    local idleGrid = anim8.newGrid(width, height, idleImage:getWidth(), idleImage:getHeight())
    local walkingImage = love.graphics.newImage("assets/npcs/Cow/Walking.png")
    walkingImage:setFilter("nearest", "nearest")
    local walkingGrid = anim8.newGrid(width, height, walkingImage:getWidth(), walkingImage:getHeight())
    local newCow = NPC:new()
    newCow.options = NPC.createOptions("Cow", 1, x, y, width, height, 25, idleImage, idleGrid, walkingImage, walkingGrid, limit)
    newCow.options.scale = 1.1
    newCow.options.animations = {
        idle = {
            front = anim8.newAnimation(idleGrid('1-2', 1), 0.75),
            back = anim8.newAnimation(idleGrid('1-2', 2), 0.75),
            left = anim8.newAnimation(idleGrid('1-2', 2), 0.75),
            right = anim8.newAnimation(idleGrid('1-2', 1), 0.75)
        },
        
        walking = {
            front = anim8.newAnimation(walkingGrid('1-4', 1), 0.3),
            back = anim8.newAnimation(walkingGrid('1-4', 2), 0.3),
            left = anim8.newAnimation(walkingGrid('1-4', 2), 0.3),
            right = anim8.newAnimation(walkingGrid('1-4', 1), 0.3)
        }
    }
    self.__index = self
    setmetatable(newCow, self)
    return newCow
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