Tree = {}
setmetatable(Tree, { __index = Entity })

local treeImage = love.graphics.newImage("assets/tree.png")
treeImage:setFilter("nearest", "nearest")

function Tree:new()
    local newTree = Entity:new()
    self.scale = 1
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
    love.graphics.draw(self.image, self.x, self.y, 0, self.scale, self.scale)
end

function Tree:newCollider(x, y)
    self.collider = world:newRectangleCollider(x, y, self.width, self.height)
    self.collider:setType("static")
end