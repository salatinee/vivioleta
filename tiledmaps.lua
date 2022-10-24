tiledmaps = {
    "viviMap", "viviMap", "viviMap",
    "viviMap", "viviMap", "viviMap",
    "viviMap", "viviMap", "viviMap",
}

local tiledMapsWidth = 3
local tiledMapsHeight = 3

function changeCurrentMap(direction)
    local i = _G.currentMap:getIndex()
    
    if direction == "up" and math.ceil(i / tiledMapsHeight) > 0 then
        i = i - tiledMapsWidth
    elseif direction == "down" and math.ceil(i / tiledMapsHeight) < tiledMapsHeight then
        i = i + tiledMapsWidth
    elseif direction == "left" and math.fmod(i, tiledMapsWidth) ~= 1 then
        i = i - 1
    elseif direction == "right" and math.fmod(i, tiledMapsWidth) ~= 0 then
        i = i + 1
    end

    local newCurrentMap = tiledmaps[i]
    if newCurrentMap ~= nil then
        _G.currentMap = loadMap(newCurrentMap)
        _G.currentMap:load()
    end
end

