-- simple fade in and out, not actually loading anything
loading = {
    animating = false,
    loops = 0,
    intensity = -6,
    pause = 0.05,
}

function loading:update(dt)
    if self.animating then
        if dt >= self.pause then
            return
        end
        _G.alpha = _G.alpha + self.intensity * dt
        if _G.alpha < -0.5 or _G.alpha > 1 then
            self.loops = self.loops + 1
            if self.loops == 1 then
                sleep(self.pause)
            end
            if self.loops == 2 then
                self.animating = false
                self.loops = 0
                _G.alpha = 1
            end
            self.intensity = -self.intensity
        end
    end

    return self.animating
end

function loading:animate()
    self.animating = true
end