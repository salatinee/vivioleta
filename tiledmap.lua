function loadTiledMap(path)
    local map = require(path)

    map.quads = loadQuads(map.tilesets)
    map.images = loadImages(map.tilesets)

    function map:draw()
        for i, layer in pairs(self.layers) do
            if layer.type == "tilelayer" then
                for y = 0, layer.height - 1 do
                    for x = 0, layer.width - 1 do
                        local index = x + y * layer.width + 1
                        local tid = layer.data[index]

                        if tid ~= 0 then
                            local quad = self.quads[tid]
                            local tilesetIndex = getTilesetIndexFromTID(self.tilesets, tid)
                            local xx = x * map.tilesets[tilesetIndex].tilewidth
                            local yy = y * map.tilesets[tilesetIndex].tileheight

                            love.graphics.draw(
                                self.images[tilesetIndex],
                                quad,
                                xx,
                                yy
                            )
                        end
                    end
                end
            end
        end
    end 

    return map
end

function getTilesetIndexFromTID(tilesets, tid)
    for i, tileset in ipairs(tilesets) do
        if tid >= tileset.firstgid and tid <= tileset.firstgid + tileset.tilecount - 1 then
            return i
        end
    end
end

function loadImages(tilesets)
    local images = {}
    for i, tileset in ipairs(tilesets) do
        local image = love.graphics.newImage(tileset.image)
        images[i] = image
    end

    return images
end

function loadQuads(tilesets)
    local quads = {}
    for _, tileset in pairs(tilesets) do
        for y = 0, (tileset.imageheight / tileset.tileheight) - 1 do
            for x = 0, (tileset.imagewidth / tileset.tilewidth) - 1 do
                local quad = love.graphics.newQuad(
                    x * tileset.tilewidth,
                    y * tileset.tileheight,
                    tileset.tilewidth,
                    tileset.tileheight,
                    tileset.imagewidth,
                    tileset.imageheight
                )
                table.insert(quads, quad)
            end
        end
    end

    return quads
end