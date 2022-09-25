require("requireAll")
requireAll()

function love.load()
    love.window.setMode(624, 624)
    world = wf.newWorld(0, 0)
    map:load()
    player:load()
end

function love.update(dt)
    map:update(dt)
    world:update(dt)
    player:update(dt)
end

function love.draw()
    love.graphics.scale(3)
    map:draw()
    player:draw()
end