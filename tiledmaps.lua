
function loadMapOfMaps()
    tiledmaps = {
        {map = nil, name = "nil"},        {map = nil, name = "nil"},         {map = nil, name = "nil"},
        {map = nil, name = "viviMap2"},   {map = nil, name = "viviMap"},     {map = nil, name = "nil"},
        {map = nil, name = "nil"},        {map = nil, name = "nil"},         {map = nil, name = "nil"},
    }
end

function changeCurrentMap(direction)
    local tiledMapsWidth, tiledMapsHeight = 3, 3

    local i = _G.currentMap:getIndex()
    if i ~= nil then
        tiledmaps[i].map = _G.currentMap
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
        if newCurrentMap.name ~= nil then
            _G.currentMap:destroy()
            if newCurrentMap.map ~= nil then
                _G.currentMap = newCurrentMap.map
                _G.currentMap:loadCollisions()
            else
                if newCurrentMap.name ~= "nil" then
                    _G.currentMap = loadTiledMap(newCurrentMap.name)
                    tiledmaps[i].map = _G.currentMap
                    _G.currentMap:load()
                end
            end
        loading:animate()
        end
    end
end

