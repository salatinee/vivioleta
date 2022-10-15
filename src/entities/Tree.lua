Tree = {}

function Tree:new()
    local newTree = {}
    setmetatable(newTree, self)
    self.__index = self
    return newTree
end

function Tree:load()
    
end