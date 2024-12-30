local world = require("world")
local player = {
    name = "mad man",
    health = 100,
    sprite = nil,
    quads = {},
    position = { x = 100, y = 100 },
    movement = {
        speed = 200,
        angle = { x = 0, y = 0 },
        friction = 10,
    },
}

local frame = { current = 1, time = 0.1, timer = 0 }

local function asBody()
    local body = love.physics.newBody(world.physicsWorld, player.position.x, player.position.y, "dynamic")
    local shape = love.physics.newRectangleShape(32, 32)
    local fixture = love.physics.newFixture(body, shape)
    return body
end

function player.Load()
    local sprite = love.graphics.newImage("assets/images/radish-man.png")
    player.sprite = sprite

    local frameWidth, frameHeight = 32, 32
    for i = 0, (sprite:getWidth() / frameWidth) - 1 do
        player.quads[#player.quads + 1] = love.graphics.newQuad(
            i * frameWidth, 0, frameWidth, frameHeight, sprite:getDimensions()
        )
    end
end

local function setVelocity(dt)
    local mv = player.movement
    if love.keyboard.isDown("w") then
        mv.angle.y = -mv.speed
    elseif love.keyboard.isDown("s") then
        mv.angle.y = mv.speed
    else
        mv.angle.y = mv.angle.y * (1 - mv.friction * dt)
    end

    if love.keyboard.isDown("a") then
        mv.angle.x = -mv.speed
    elseif love.keyboard.isDown("d") then
        mv.angle.x = mv.speed
    else
        mv.angle.x = mv.angle.x * (1 - mv.friction * dt)
    end
end


local function setPostion(dt)
    local mv = player.movement
    local ps = player.position

    mv.angle.x = mv.angle.x * (1 - mv.friction * dt)
    mv.angle.y = mv.angle.y * (1 - mv.friction * dt)
    ps.x = ps.x + mv.angle.x * dt
    ps.y = ps.y + mv.angle.y * dt
end


local function setAnimation(dt)
    frame.timer = frame.timer + dt
    if frame.timer > frame.time then
        frame.timer = 0
        frame.current = frame.current % #player.quads + 1
    end
end

function player.Update(dt)
    setVelocity(dt)
    setPostion(dt)
    setAnimation(dt)
    asBody()
end

function player.Draw()
    love.graphics.draw(player.sprite, player.quads[frame.current], player.position.x, player.position.y)
    love.graphics.print(player.name, player.position.x, player.position.y + 40)
end

return player
