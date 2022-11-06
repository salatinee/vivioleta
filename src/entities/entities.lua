entities = {}

entities.entities = {}

function entities:load()
    self.allEntities = {Cow, Aurora, Tree}
    for _, entity in ipairs(self.allEntities) do
        entity:load()
    end
end

function entities:update(dt)
    for _, entity in ipairs(self.entities) do
        entity:update(dt)
    end
end

function entities:reset()
    self.entities = {}
end

function entities:getEntities()
    return self.entities
end

function entities:getEntityByName(name)
    for _, entity in ipairs(self.allEntities) do
        if entity.name == name then
            return entity
        end
    end
end

function entities:addEntity(newEntity)
    table.insert(self.entities, newEntity)
end

function entities:removeEntity(i)
    table.remove(self.entities, i)
end

function entities:draw()
    for _, entity in ipairs(self.entities) do
        entity:draw()
    end
end