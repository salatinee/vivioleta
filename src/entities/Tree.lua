Tree = {}
setmetatable(Tree, { __index = Entity })

function Tree:new(x, y)
    local newTree = Entity:new()
    newTree.x, newTree.y = x, y
    setmetatable(newTree, self)
    self.__index = self
    return newTree
end

function Tree:load()
    self.scale = 1.5
    self.name = "Tree"
    self.rotation = 0
    self.image = love.graphics.newImage("assets/tree.png")
    self.image:setFilter("nearest", "nearest")
    self.width = self.image:getWidth() * self.scale
    self.height = self.image:getHeight() * self.scale
end

function Tree:draw()
    love.graphics.draw(self.image, self.x, self.y, self.rotation, self.scale, self.scale)
end

function Tree:update(dt)
    if self.animating then
        self:destroy()
    end
end

function Tree:destroy()

end

function Tree:reset()
    self:newCollider(self.x, self.y)
end

function Tree:newCollider(x, y)
    self.collider = world:newRectangleCollider(x, y, _G.currentMap:getTileWidth() * self.scale, _G.currentMap:getTileHeight() * self.scale)
    self.collider:setType("static")
    self.collider:setObject(self)
    self.collider:setCollisionClass("Tree")
    return self.collider
end