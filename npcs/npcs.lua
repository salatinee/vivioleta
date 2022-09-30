npcs = {}

function npcs:load()
    npcs.npcs = {
        Cow:new(100, 100, 50)
    }
    for i, npc in ipairs(npcs.npcs) do
        npc:load(npc.options)
        npc.collider:setObject(npc)
    end
end

function npcs:update(dt)
    for _, npc in ipairs(npcs.npcs) do
        npc:update(dt)
    end
end

function npcs:draw()
    for _, npc in ipairs(npcs.npcs) do 
        npc:draw()
    end
end