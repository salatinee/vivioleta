-- player's inventory

Inventory = {}

function Inventory:load()
    self.items = {}
    self.itemsCount = #self.items
    self.itemsLimit = 10

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

