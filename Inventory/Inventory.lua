-- player's inventory

Inventory = {}

function Inventory:load()
    self.items = {
        Pickaxe:new()
    }
    self.itemsCount = #self.items
    self.itemsLimit = 10
    self.itemSelectedIndex = 1

end

function Inventory:changeItemSelected(intensity)
    intensity = -intensity
    self.itemSelectedIndex = self.itemSelectedIndex + intensity
    if self.itemSelectedIndex > self.itemsLimit then
        self.itemSelectedIndex = self.itemSelectedIndex - self.itemsLimit
    elseif self.itemSelectedIndex < 1 then
        self.itemSelectedIndex = self.itemsLimit - self.itemSelectedIndex
    end
end

function Inventory:addItem(item)
    if self.itemsCount < self.itemsLimit then
        table.insert(self.items, item)
        self:updateItemCount()
    end
end

function Inventory:removeItem(item)
    for i, v in ipairs(self.items) do
        if v == item then
            table.remove(self.items, i)
        end
    end

    self:updateItemCount()
end

function Inventory:updateItemCount()
    self.itemsCount = #self.items
end

function Inventory:getItem(i)
    return self.items[i]
end

function Inventory:getItems()
    return self.items
end

function Inventory:getItemsCount()
    return self.itemsCount
end

function Inventory:getItemsLimit()
    return self.itemsLimit
end

function Inventory:getItemPosition(item)
    for i, v in ipairs(self.items) do
        if v == item then
            return i
        end
    end
end

function Inventory:swapItemPosition(item, newPosition)
    local oldPosition = self:getItemPosition(item)
    if oldPosition ~= newPosition then

        local itemToSwap = nil
        if self.items[newPosition] ~= nil then
            local itemToSwap = self.items[newPosition]
        end
        
        self.items[oldPosition] = itemToSwap
        self.items[newPosition] = item
    end
end

function Inventory:getItemSelected()
    return self.items[self.itemSelectedIndex]
end

function Inventory:getItemSelectedIndex()
    return self.itemSelectedIndex
end

