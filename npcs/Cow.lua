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
    newCow.interactionFont = love.graphics.newFont("fonts/8bitOperatorPlus8-Regular.ttf", 8)
    newCow.interactionFont:setFilter("nearest", "nearest")
    newCow.interactionTimer = 0.0
    newCow.interactionMaxTimer = 1
    newCow.isInteracting = false
    newCow.options = {
        scale = 1,
        name = "Cow",
        x = x,
        y = y,
        speed = 25,
        width = width,
        height = height,
        idle = {
            image = idleImage,
            grid = idleGrid
        },
    
        walking = {
            image = walkingImage,
            grid = walkingGrid
        },
        
        animations = {
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
        },
    
        limits = {
            up = limit,
            down = limit,
            left = limit,
            right = limit
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

function Cow:getIsInteracting()
    return self.isInteracting
end

function Cow:setIsInteracting(isInteracting)
    self.isInteracting = isInteracting
end

function Cow:interactWithPlayer()
    -- draw text above cow
    love.graphics.setFont(self.interactionFont)
    local text = "moo!"
    local textWidth = self.interactionFont:getWidth(text)
    local textHeight = self.interactionFont:getHeight(text)
    love.graphics.print(text, self.x + self.width / 2 - textWidth, self.y - self.height / 2 - 15 + textHeight / 2, nil, self.scale, self.scale)
end

function Cow:draw()
    self:drawNPC()
    if self.isInteracting then
        self:interactWithPlayer()
    end
end