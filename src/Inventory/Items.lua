Items = {}

function Items:load()
    for _, item in ipairs(Inventory:getItems()) do
        item:load()
    end
end