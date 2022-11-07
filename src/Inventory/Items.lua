Items = {}

function Items:load()
    self.allItems = {Pickaxe, WateringCan}
    for _, item in ipairs(self.allItems) do
        item:load()
    end
end