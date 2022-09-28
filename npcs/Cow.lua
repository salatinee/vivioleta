local width = 27
local height = 17
local idleImage = love.graphics.newImage("sprites/npcs/Cow/Idle.png")
idleImage:setFilter("nearest", "nearest")
local idleGrid = anim8.newGrid(width, height, idleImage:getWidth(), idleImage:getHeight())
local walkingImage = love.graphics.newImage("sprites/npcs/Cow/Walking.png")
walkingImage:setFilter("nearest", "nearest")
local walkingGrid = anim8.newGrid(width, height, walkingImage:getWidth(), walkingImage:getHeight())
local limit = 25


Cow = NPC:new()
Cow.options = {
    scale = 1,
    name = "Cow",
    x = 100,
    y = 100,
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