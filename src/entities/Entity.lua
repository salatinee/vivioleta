Entity = {}

function Entity:new()
    local newEntity = {}
    setmetatable(newEntity, self)
    self.__index = self
    return newEntity
end

function Entity:getPosition()
    return self.x, self.y
end

function Entity:setPosition(x, y)
    self.x = x
    self.y = y
end

function Entity:getDimensions()
    return self.width, self.height
end

function Entity:setDimensions(width, height)
    self.width = width
    self.height = height
end

function Entity:newCollider(x, y)
    -- probably should be overriden since this is too generic
    self.collider = Collider:addRectangle(x, y, self.width, self.height)
end

function Entity:load()
    -- must be overriden
end

function Entity:update(dt)
    -- must be overriden
end

function Entity:draw()
    -- must be overriden
end