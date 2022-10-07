require("requireAll")
requireAll()

math.randomseed(os.time())

function love.load()
    love.window.setMode(624, 624)
    love.graphics.setDefaultFilter("nearest", "nearest")
    world = wf.newWorld(0, 0)
    scale = 3.5
    fullscreen = false
    _G.viviMap = loadTiledMap("viviMap")
    map:load()
    player:load()
    playerCamera:load()
    npcs:load()
    Inventory:load()
end

function love.update(dt)
    map:update(dt)
    world:update(dt)
    npcs:update(dt)
    player:update(dt)
    playerCamera:update(dt)
end

function love.keypressed(key, scancode, isrepeat)
    if key == "e" then
        player:interactWithNPC()
    end

    if key == "escape" then
        love.event.quit()
    end

    if key == "f1" then
        fullscreen = not fullscreen
        love.window.setFullscreen(fullscreen)
    end
end

function love.draw()
    playerCamera:attach()
        love.graphics.scale(scale)
        map:draw()
        npcs:draw()
        player:draw()
     -- world:draw()
    playerCamera:detach()
    hud:draw()
end