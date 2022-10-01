Cow = NPC:new()

function Cow:new(x, y, limit)
    local width = 27
    local height = 17
    local idleImage = love.graphics.newImage("sprites/npcs/Cow/Idle.png")
    idleImage:setFilter("nearest", "nearest")
    local idleGrid = anim8.newGrid(width, height, idleImage:getWidth(), idleImage:getHeight())
    local walkingImage = love.graphics.newImage("sprites/npcs/Cow/Walking.png")
    walkingImage:setFilter("nearest", "nearest")
    local walkingGrid = anim8.newGrid(width, height, walkingImage:getWidth(), walkingImage:getHeight())
    local newCow = NPC:new()
    newCow.options = NPC.createOptions("Cow", 1, x, y, width, height, 25, idleImage, idleGrid, walkingImage, walkingGrid, limit)

    newCow.options.animations = {
        idle = {
            front = anim8.newAnimation(idleGrid('1-3', 1), 0.75),
            back = anim8.newAnimation(idleGrid('1-3', 2), 0.75),
            left = anim8.newAnimation(idleGrid('1-3', 2), 0.75),
            right = anim8.newAnimation(idleGrid('1-3', 1), 0.75)
        },
        
        walking = {
            front = anim8.newAnimation(walkingGrid('1-3', 1), 0.3),
            back = anim8.newAnimation(walkingGrid('1-3', 2), 0.3),
            left = anim8.newAnimation(walkingGrid('1-3', 2), 0.3),
            right = anim8.newAnimation(walkingGrid('1-3', 1), 0.3)
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