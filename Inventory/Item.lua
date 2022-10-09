Item = {}
itemTypes = {"weapon", "tool", "ingredient"}

function Item:new(name, value, icon, sprite, newItemType, scale)
    local newItem = {}

    -- position must be set later
    newItem.x = nil
    newItem.y = nil

    newItem.name = name
    newItem.value = value
    newItem.icon = icon
    newItem.sprite = sprite
    newItem.width = image:getWidth() * scale
    newItem.height = image:getHeight() * scale
    newItem.scale = scale or 1
    newItem.rotation = 0

    local foundType = false
    for _, itemType in ipairs(itemTypes) do
        if newItemType == itemType then
            newItem.type = newItemType
            foundType = true
            break
        end
    end
    if not foundType then
        error("Invalid item type: " .. newItemType)
    end

    newItem.directions = {
        front = 1,
        back = 2,
        right = 3,
        left = 4
    }
    
    self.__index = self
    setmetatable(newItem, self)
    return newItem
end

function Item:draw()
    love.graphics.draw(self.image, self.x, self.y, self.rotation, self.scale)
end

function Item:getName()
    return self.name
end

function Item:getValue()
    return self.value
end

function Item:getImage()
    return self.image
end

function Item:getScale()
    return self.scale
end
