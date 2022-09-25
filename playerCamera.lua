playerCamera = {}

function playerCamera:load()
    self.cam = camera(player:getDimensions())
end

function playerCamera:update(dt)
    self:lookAtPlayer()
    self:stopAtBorders()
end

function playerCamera:lookAtPlayer()
    self.cam:lookAt(player:getDimensions())
end

function playerCamera:stopAtBorders()
    local w, h = love.graphics.getWidth(), love.graphics.getHeight()
    local mapW, mapH = map.currentMap.width * map.currentMap.tilewidth * scale, map.currentMap.height * map.currentMap.tileheight * scale
    if self.cam.x < w/2 then
        self.cam.x = w/2
    end

    if self.cam.y < h/2 then
        self.cam.y = h/2
    end

    if self.cam.x > mapW - w/2 then
        self.cam.x = mapW - w/2
    end

    if self.cam.y > mapH - h/2 then
        self.cam.y = mapH - h/2
    end
end

function playerCamera:attach()
    self.cam:attach()
end

function playerCamera:detach()
    self.cam:detach()
end