map = {}

function map:load()
    self.currentMap = sti("viviMap.lua")
    
    self.collisions = {}
    self.collisionClass = world:addCollisionClass("Collision")
    self.playerCollisionClass = world:addCollisionClass("Player")
    self.npcCollisionClass = world:addCollisionClass("NPC")
    if self.currentMap.layers["grassCollision"] then
        for i, obj in pairs(self.currentMap.layers["grassCollision"].objects) do
            local collider = world:newRectangleCollider(obj.x, obj.y, obj.width, obj.height)
            collider:setType("static")
            table.insert(self.collisions, collider)
            collider:setCollisionClass("Collision")
        end
    end
end

function map:getCollisions()
    return map.collisions
end

function map:update(dt)
    _G.viviMap:update(dt)
end

function map:draw()
    _G.viviMap:draw()
end