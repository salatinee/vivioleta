require("requireAll")
requireAll()

function love.load()
    love.window.setMode(624, 624)
    love.graphics.setDefaultFilter("nearest", "nearest")
    world = wf.newWorld(0, 0)
    scale = 3

    map:load()
    player:load()
    playerCamera:load()
end

function love.update(dt)
    map:update(dt)
    world:update(dt)
    player:update(dt)
    playerCamera:update(dt)
end

function love.draw()
    playerCamera:attach()
        love.graphics.scale(scale)
        map:draw()
        player:draw()
     -- world:draw()
    playerCamera:detach()
end