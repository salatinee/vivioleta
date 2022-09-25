map = {}

function map:load()
    self.currentMap = sti("maps/viviMap.lua")


    self.collisions = {}
    if self.currentMap.layers["grassCollision"] then
        for i, obj in pairs(self.currentMap.layers["grassCollision"].objects) do
            local collider = world:newRectangleCollider(obj.x, obj.y, obj.width, obj.height)
            collider:setType("static")
            table.insert(self.collisions, collider)
        end
    end
end

function map:update(dt)

end

function map:draw()
    self.currentMap:drawLayer(self.currentMap.layers["grass2"])
    self.currentMap:drawLayer(self.currentMap.layers["grass"])
end