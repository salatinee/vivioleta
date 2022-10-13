-- player's inventory

Inventory = {}

function Inventory:load()
    self.itemsLimit = 10
    self.itemSelectedIndex = 1

    self.items = {}
    for i = 1, self.itemsLimit do
        self.items[i] = nil
    end

    self.items[1] = Pickaxe:new()

    self.itemsCount = #self.items
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

function Inventory:addItem(item, i)
    if self.itemsCount < self.itemsLimit then
        local i = i or self.itemsCount + 1
        table.insert(self.items, i, item)
        self:updateItemCount()
    end
end

function Inventory:removeItem(item, index)
    local index = index or self:getItemIndex(item)
    table.remove(self.items, index)
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
    self.items[item:getIndex()], self.items[newPosition] = self.items[newPosition], self.items[item:getIndex()]
end

function Inventory:getItemIndex(item)
    for i, v in ipairs(self.items) do
        if v == item then
            return i
        end
    end
end

function Inventory:getItemSelected()
    return self.items[self.itemSelectedIndex]
end

function Inventory:setItemSelectedIndex(i)
    if i == 0 then
        self.itemSelectedIndex = self.itemsLimit
        return
    end
    self.itemSelectedIndex = i
end

function Inventory:getItemSelectedIndex()
    return self.itemSelectedIndex
end

