require("requireAll")
requireAll()

math.randomseed(os.time())

function love.load()
    love.window.setMode(624, 624)
    love.graphics.setDefaultFilter("nearest", "nearest")
    world = wf.newWorld(0, 0)
    scale = 3.5
    fullscreen = false
    _G.currentMap = loadTiledMap("viviMap")
    _G.currentMap:load()
    player:load()
    playerCamera:load()
    entities:load()
    Inventory:load()
    inventoryHud:load()
    Items:load()
end

function love.update(dt)
    _G.currentMap:update(dt)
    world:update(dt)
    entities:update(dt)
    player:update(dt)
    playerCamera:update(dt)
    inventoryHud:update(dt)
end

function love.mousepressed(x, y, button, istouch, presses)
    if button == 1 then
        local gotItem = false
        for i = 1, Inventory:getItemsLimit() do
            local inventorySlot = inventoryHud:getInventorySlot(i)
            local mouse = {x = x, y = y, width = 1, height = 1}
            if checkCollision(mouse, inventorySlot) then
                Inventory:setItemSelectedIndex(i)
                local item = Inventory:getItem(i)
                if item ~= nil then     
                    item:setBeingDragged(true)
                    gotItem = true
                end
            end
        end
        if not gotItem then
            local currentItem = Inventory:getItemSelected()
            if currentItem ~= nil then
                if not currentItem:getAnimating() then
                    player:changeUsingItemState()
                    currentItem:use()
                end
            end
        end
    end
end

function love.wheelmoved(x, y)
    Inventory:changeItemSelected(y)
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

    for i = 0, Inventory:getItemsLimit() - 1 do
        if key == tostring(i) then
            Inventory:setItemSelectedIndex(i)
        end
    end
end

function love.draw()
    playerCamera:attach()
        love.graphics.scale(scale)
        _G.currentMap:draw()
        entities:draw()
        player:draw()
     -- world:draw()
    playerCamera:detach()
    inventoryHud:draw()
end