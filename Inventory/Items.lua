Items = {}

function Items:load()
    for _, item in ipairs(Inventory:getItems()) do
        item:load()
    end
end

function Items:update(dt)
    for _, item in ipairs(Inventory:getItems()) do
        item:update(dt)
    end
end