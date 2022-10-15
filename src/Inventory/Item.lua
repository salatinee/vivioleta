Item = {}
itemTypes = {"weapon", "tool", "ingredient"}

function Item:new(options)
    local newItem = {}

    if name ~= "NULL" then
        -- position must be set later
        newItem.x = nil
        newItem.y = nil
        newItem.xIcon = nil
        newItem.yIcon = nil

        newItem.scale = options.scale or 1
        newItem.name = options.name
        newItem.value = options.value
        newItem.icon = options.icon
        newItem.icon:setFilter("nearest", "nearest")
        newItem.sprite = options.sprite
        newItem.sprite:setFilter("nearest", "nearest")
        newItem.width = options.width * newItem.scale
        newItem.height = options.height * newItem.scale
        newItem.itemWidth = options.itemWidth
        newItem.itemHeight = options.itemHeight
        newItem.rotation = 0
        newItem.animating = false
        newItem.beingDragged = false
        local foundType = false
        for _, itemType in ipairs(itemTypes) do
            if options.type == itemType then
                newItem.type = options.type
                foundType = true
                break
            end
        end
        if not foundType then
            error("Invalid item type: " .. newItemType)
        end
    end
    
    self.__index = self
    setmetatable(newItem, self)
    return newItem
end

function Item:updateIndex()
    self.index = nil
    for i, item in ipairs(Inventory:getItems()) do
        if item.name == self.name then
            self.index = i
            break
        end
    end
end

function Item:getIndex()
    return self.index
end

function Item:getAnimating()
    return self.animating
end

function Item:setIndex(index)
    self.index = index
end

function Item:setIconDimensions(x, y)
    self.xIcon = x or self.xIcon
    self.yIcon = y or self.yIcon
end

function Item:updateIconDragging(x, y)
    self.xIcon = x - self.itemWidth / 2
    self.yIcon = y - self.itemHeight / 2
end

function Item:getBeingDragged()
    return self.beingDragged
end

function Item:setBeingDragged(bool)
    self.beingDragged = bool
end

function Item:drawIcon(scale)
    love.graphics.draw(self.icon, self.xIcon, self.yIcon, nil, scale)
end

function Item:drawSprite(x, y, scale)
    love.graphics.draw(self.sprite, x, y, nil, scale)
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

function Item:use()
    self.animating = true
end

function Item:load()
    -- override this
end