inventoryHud = {}

function inventoryHud:load()
    self.inventorySlot = {}
    self.scale = 0.55 * getVH()
    self.iconScale = self.scale * 0.75
    self.inventorySlot.image = love.graphics.newImage("sprites/inventorySlot.png")
    self.inventorySlot.width = self.inventorySlot.image:getWidth() * self.scale 
    self.inventorySlot.height = self.inventorySlot.image:getHeight() * self.scale
    self.inventorySlot.padding = self.scale * 2
    self.drawing = true
end

function inventoryHud:update(dt)
    self:updateScaling()
end

function inventoryHud:updateScaling()
    self.scale = 0.55 * getVH()
    self.iconScale = self.scale * 0.75
    self.inventorySlot.padding = self.scale * 2
    self.inventorySlot.width = self.inventorySlot.image:getWidth() * self.scale
    self.inventorySlot.height = self.inventorySlot.image:getHeight() * self.scale
end

function inventoryHud:draw()
    if self.drawing == true then
        local inventorySlotX = (love.graphics.getWidth() / 2) - ((self.inventorySlot.width + self.inventorySlot.padding) * Inventory:getItemsLimit() / 2)
        local inventorySlotY = love.graphics.getHeight() - self.inventorySlot.height - self.inventorySlot.padding
        for i = 1, Inventory:getItemsLimit() do
            if i == Inventory:getItemSelectedIndex() then
                love.graphics.rectangle("fill", inventorySlotX - 5, inventorySlotY - 5, self.inventorySlot.width + 10, self.inventorySlot.height + 10)
            end
            love.graphics.draw(self.inventorySlot.image, inventorySlotX, inventorySlotY, 0, self.scale)
            inventorySlotX = inventorySlotX + self.inventorySlot.width + self.inventorySlot.padding

            local item = Inventory:getItem(i)
            if item ~= nil then

                local itemIconX = inventorySlotX - self.inventorySlot.width / 2 - item.icon:getWidth() * self.iconScale / 2 - self.inventorySlot.padding
                local itemIconY = inventorySlotY - self.inventorySlot.height / 2 + item.icon:getHeight() * self.iconScale / 2 + self.inventorySlot.padding + 1
                item:drawIcon(itemIconX, itemIconY, self.iconScale)
            end
        end
    end
end