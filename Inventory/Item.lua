Item = {}
itemTypes = {"weapon", "tool", "ingredient"}

function Item:new(name, value, image, scale, newItemType)
    local newItem = {}
    newItem.name = name
    newItem.value = value
    newItem.image = image
    newItem.width = image:getWidth() * scale
    newItem.height = image:getHeight() * scale
    newItem.scale = scale

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

    self.__index = self
    setmetatable(newItem, self)
    return newItem
end

function Item:draw(x, y)
    love.graphics.draw(self.image, x, y, 0, self.scale)
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
