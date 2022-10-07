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