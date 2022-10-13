utils = {

}

function getVDimensions()
    utils.vw = love.graphics.getWidth() / 100
    utils.vh = love.graphics.getHeight() / 100

    return utils.vw, utils.vh
end

function getVW()
    utils.vw = love.graphics.getWidth() / 100

    return utils.vw
end

function getVH()
    utils.vh = love.graphics.getHeight() / 100

    return utils.vh
end

function checkCollision(entity, otherEntity)
    if entity.x < otherEntity.x + otherEntity.width and
        entity.x + entity.width > otherEntity.x and
        entity.y < otherEntity.y + otherEntity.height and
        entity.y + entity.height > otherEntity.y then
        return true
    else
        return false
    end
end

function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end