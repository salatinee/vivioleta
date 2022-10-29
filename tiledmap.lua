function loadTiledMap(path)
    local map = require(path)

    function map:load()

        self.quads = loadQuads(self.tilesets)
        self.images = loadImages(self.tilesets)
        self.animatedTiles = loadAnimatedTiles(self.tilesets)
        self.width = self.width * self.tilewidth
        self.height = self.height * self.tileheight
        self.name = self.properties.name
        self.frame = 0
        self.timer = 0.0
        self.maxTimer = 0.1

        for i, tiledmap in ipairs(tiledmaps) do
            if self.properties.name == tiledmap.name then
                self.index = i
                break
            end
        end

        self.collisions = {}
        if not world:isCollisionClass("NPC") then
            world:addCollisionClass("NPC")
            world:addCollisionClass("Collision")
            world:addCollisionClass("Tree")
            world:addCollisionClass("Player")
            world:addCollisionClass("PlayerInteraction", {ignores = {"All",}})
        end

        self:loadCollisions()
    end

    function map:update(dt)
        if self.timer > self.maxTimer then
            self.frame = self.frame + 1
            self.timer = 0.0
        end

        self.timer = self.timer + dt
    end

    function map:getTileWidth()
        return self.tilewidth
    end

    function map:getTileHeight()
        return self.tileheight
    end

    function map:getWidth()
        return self.width
    end

    function map:getHeight()
        return self.height
    end

    function map:getDimensions()
        return self:getWidth(), self:getHeight()
    end

    function map:getIndex()
        return self.index
    end

    function map:getCollisions()
        return self.collisions
    end

    function map:destroy()
        for i, collision in ipairs(self.collisions) do
            if collision ~= nil then
                collision:destroy()
                table.remove(self.collisions, i)
            end    
        end
    end

    function map:loadCollisions()
        for _, layer in ipairs(self.layers) do
            if layer.name == "Collisions" then
                for _, obj in pairs(layer.objects) do
                    local collider = world:newRectangleCollider(obj.x, obj.y, obj.width, obj.height)
                    collider:setType("static")
                    table.insert(self.collisions, collider)
                    collider:setCollisionClass("Collision")
                end
            end

            if layer.name == "Trees" then
                for _, obj in pairs(layer.objects) do
                    local tree = Tree:new()
                    tree:setPosition(obj.x, obj.y)
                    tree:newCollider(obj.x, obj.y)
                    entities:addEntity(tree)
                    table.insert(self.collisions, tree)
                end
            end
        end
    end

    function map:draw()
        for i, layer in pairs(self.layers) do
            if layer.type == "tilelayer" then
                for y = 0, layer.height - 1 do
                    for x = 0, layer.width - 1 do
                        local index = x + y * layer.width + 1
                        local tid = layer.data[index]

                        if tid ~= 0 then
                            if self.animatedTiles[tid] ~= nil then
                                
                                local animation = self.animatedTiles[tid].animation
                                local numFrames = #animation
                                index = self.frame % numFrames + 1
                                tid = tid + animation[index].tileid
                            end

                            local quad = self.quads[tid]
                            local tilesetIndex = getTilesetIndexFromTID(self.tilesets, tid)
                            local xx = x * self.tilesets[tilesetIndex].tilewidth
                            local yy = y * self.tilesets[tilesetIndex].tileheight
                            

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

function loadAnimatedTiles(tilesets)
    local animatedTiles = {}
    for i, tileset in ipairs(tilesets) do
        if tileset.tiles[1] then
            for i, tile in ipairs(tileset.tiles) do
                animatedTiles[tileset.firstgid + tile.id] = tile
            end 
        end
    end

    return animatedTiles
end

function getTilesetIndexFromTID(tilesets, tid)
    for i, tileset in ipairs(tilesets) do
        if tid >= tileset.firstgid and tid <= tileset.firstgid + tileset.tilecount - 1 then
            return i
        end
    end
end

function getTilesetFirstGIDFromTID(tilesets, tid)
    for i, tileset in ipairs(tilesets) do
        if tid >= tileset.firstgid and tid <= tileset.firstgid + tileset.tilecount - 1 then
            return tileset.firstgid
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