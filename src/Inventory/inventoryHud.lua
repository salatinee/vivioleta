inventoryHud = {}

function inventoryHud:load()
    self.inventorySlot = {}
    self.scale = 0.55 * getVH()
    self.iconScale = self.scale * 0.75
    self.inventorySlot.image = love.graphics.newImage("assets/inventory/inventorySlot.png")
    self.inventorySlot.width = self.inventorySlot.image:getWidth() * self.scale 
    self.inventorySlot.height = self.inventorySlot.image:getHeight() * self.scale
    self.inventorySlot.padding = self.scale * 2
    self.drawing = true
end

function inventoryHud:update(dt)
    self:updateScaling()
    self:updateIcons(dt)
end

function inventoryHud:updateScaling()
    self.scale = 0.55 * getVH()
    self.iconScale = self.scale * 0.75
    self.inventorySlot.padding = self.scale * 2
    self.inventorySlot.width = self.inventorySlot.image:getWidth() * self.scale
    self.inventorySlot.height = self.inventorySlot.image:getHeight() * self.scale
    self.inventorySlots = {}
    for i=1, Inventory:getItemsLimit() do
        self.inventorySlots[i] = {
            x = (love.graphics.getWidth() / 2) - ((self.inventorySlot.width + self.inventorySlot.padding) * Inventory:getItemsLimit() / 2) + ((self.inventorySlot.width + self.inventorySlot.padding) * (i - 1)),
            y = love.graphics.getHeight() - self.inventorySlot.height - self.inventorySlot.padding,
            width = self.inventorySlot.width,
            height = self.inventorySlot.height,
        }
    end
end

function inventoryHud:updateIcons(dt)
    for i = 1, Inventory:getItemsLimit() do
        local item = Inventory:getItem(i)
        if item ~= nil then
            item:update(dt)
            item:setIndex(i)
            self:followCursor(item)
        end
    end
end

function inventoryHud:getInventorySlot(i)
    return self.inventorySlots[i]
end

function inventoryHud:followCursor(item)
    if item:getBeingDragged() then
        local stillDragging = love.mouse.isDown(1)
        item:setBeingDragged(stillDragging)
        local x, y = love.mouse.getPosition()
        if stillDragging then
            item:updateIconDragging(x, y)
        else
            self:swapItemSlot(item, x, y)
        end
    end
end

function inventoryHud:swapItemSlot(item, x, y)
    for i = 1, Inventory:getItemsLimit() do
        local inventorySlot = inventoryHud:getInventorySlot(i)
        local mouse = {x = x, y = y, width = 1, height = 1}
        if checkCollision(mouse, inventorySlot) then
            Inventory:setItemSelectedIndex(i)
            Inventory:swapItemPosition(item, i)
        end
    end
end

function inventoryHud:draw()
    if self.drawing == true then
        for i = 1, Inventory:getItemsLimit() do
            if i == Inventory:getItemSelectedIndex() then
                love.graphics.rectangle("fill", self.inventorySlots[i].x - 5, self.inventorySlots[i].y - 5, self.inventorySlot.width + 10, self.inventorySlot.height + 10)
            end
            love.graphics.draw(self.inventorySlot.image, self.inventorySlots[i].x, self.inventorySlots[i].y, 0, self.scale)
        end

        for i = 1, Inventory:getItemsLimit() do
            local item = Inventory:getItem(i)
            if item ~= nil then
                if not item:getBeingDragged() then
                   item:setIconDimensions(
                   self.inventorySlots[i].x - self.inventorySlot.width / 2 + item.icon:getWidth() * self.iconScale / 2 + self.inventorySlot.padding + 1,
                   self.inventorySlots[i].y - self.inventorySlot.height / 2 + item.icon:getHeight() * self.iconScale / 2 + self.inventorySlot.padding + 1
                )
                end

                item:drawIcon(self.iconScale)
            end
        end
    end
end