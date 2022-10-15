entities = {}

entities.entities = {}

function entities:load()
    -- hardcoded test
    table.insert(self.entities, Cow:new(100, 100, 50))
    table.insert(self.entities, Aurora:new(200, 200, 50))

    for _, entity in ipairs(self.entities) do
        entity:load(entity.options or nil)
    end
end

function entities:update(dt)
    for _, entity in ipairs(self.entities) do
        entity:update(dt)
    end
end

function entities:getEntities()
    return self.entities
end

function entities:addEntity(newEntity)
    table.insert(self.entities, newEntity)
end

function entities:removeEntity(entity)
    table.remove(self.entities, entity)
end

function entities:draw()
    for _, entity in ipairs(self.entities) do
        entity:draw()
    end
end