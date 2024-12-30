local world = {}

function world.Load()
    love.physics.setMeter(64)                              -- Define the size of a meter in pixels
    world.physicsWorld = love.physics.newWorld(0, 0, true) -- Create a new physics world with no gravity

    world.objects = {}
    for i = 1, 10 do
        local shapeType = math.random(1, 2) == 1 and "circle" or "square"
        local size = math.random(20, 50)
        local x = math.random(size, love.graphics.getWidth() - size)
        local y = math.random(size, love.graphics.getHeight() - size)

        local body = love.physics.newBody(world.physicsWorld, x, y, "static")
        local shape
        if shapeType == "circle" then
            shape = love.physics.newCircleShape(size)
        else
            shape = love.physics.newRectangleShape(size, size)
        end
        local fixture = love.physics.newFixture(body, shape)

        table.insert(world.objects, { type = shapeType, size = size, body = body, shape = shape, fixture = fixture })
    end
end

function world.Draw()
    for _, obj in ipairs(world.objects) do
        local x, y = obj.body:getPosition()
        if obj.type == "circle" then
            love.graphics.circle("fill", x, y, obj.size)
        else
            love.graphics.rectangle("fill", x - obj.size / 2, y - obj.size / 2, obj.size, obj.size)
        end
    end
end

return world
