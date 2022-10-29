playerCamera = {}

function playerCamera:load()
    self.cam = camera(player:getPositionScaled())
    self.cam.smoother = camera.smooth.damped(6)
    self.timer = 0
    self.maxTimer = 0.25
    self.reseting = false
end

function playerCamera:update(dt)
    self:lookAtPlayer()
    self:stopAtBorders()
    if self.reseting then
        self.timer = self.timer + dt
        if self.timer > self.maxTimer then
            self.reseting = false
            self.timer = 0
            self.cam.smoother = camera.smooth.damped(6)
        end
    end
end

function playerCamera:resetPosition()
    if not self.reseting then
        self.reseting = true
        self.cam.smoother = camera.smooth.damped(0)
        self.cam = camera(player:getPositionScaled())
    end
end

function playerCamera:lookAtPlayer()
    local x, y = player:getPositionScaled()
    dx, dy = x - self.cam.x, y - self.cam.y
    if math.abs(dx) > 5 or math.abs(dy) > 5 then
        newX, newY = self.cam.smoother(dx, dy)
        self.cam:move(newX, newY)
    end
end

function playerCamera:stopAtBorders()
    local w, h = love.graphics.getWidth(), love.graphics.getHeight()
    local mapW, mapH = _G.currentMap:getWidth() * scale, _G.currentMap:getHeight() * scale
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