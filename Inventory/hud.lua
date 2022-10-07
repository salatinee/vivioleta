hud = {}

function hud:load()
    self.inventorySlot = {}
    self.scale = 0.55 * getVH()
    self.inventorySlot.image = love.graphics.newImage("sprites/inventorySlot.png")
    self.inventorySlot.width = self.inventorySlot.image:getWidth() * self.scale 
    self.inventorySlot.height = self.inventorySlot.image:getHeight() * self.scale
    self.inventorySlot.padding = 1 * getVW()

end

function hud:update(dt)
    self:updateScaling()
end

function hud:updateScaling()
    self.scale = 0.55 * getVH()
    self.inventorySlot.padding = 1 * getVH()
    self.inventorySlot.width = self.inventorySlot.image:getWidth() * self.scale
    self.inventorySlot.height = self.inventorySlot.image:getHeight() * self.scale
end

function hud:draw()
    -- creates a horizontal grid of inventory slots and draws them in the horizontal center of the screen
    local inventorySlotX = (love.graphics.getWidth() / 2) - ((self.inventorySlot.width + self.inventorySlot.padding) * Inventory:getItemsLimit() / 2)
    local inventorySlotY = love.graphics.getHeight() - self.inventorySlot.height - self.inventorySlot.padding
    for i = 1, Inventory:getItemsLimit() do
        love.graphics.draw(self.inventorySlot.image, inventorySlotX, inventorySlotY, 0, self.scale)
        inventorySlotX = inventorySlotX + self.inventorySlot.width + self.inventorySlot.padding
    end
end