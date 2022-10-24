Tree = {}
setmetatable(Tree, { __index = Entity })

local treeImage = love.graphics.newImage("assets/tree.png")
treeImage:setFilter("nearest", "nearest")

function Tree:new()
    local newTree = Entity:new()
    self.scale = 1.5
    self.rotation = 0
    self.image = treeImage
    self.width = treeImage:getWidth() * self.scale
    self.height = treeImage:getHeight() * self.scale
    setmetatable(newTree, self)
    self.__index = self
    return newTree
end

function Tree:load()

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

function Tree:newCollider(x, y)
    self.collider = world:newRectangleCollider(x, y, _G.currentMap:getTileWidth() * self.scale, _G.currentMap:getTileHeight() * self.scale)
    self.collider:setType("static")
    self.collider:setObject(self)
    self.collider:setCollisionClass("Tree")
end