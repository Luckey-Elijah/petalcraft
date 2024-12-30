local player = {}
local quads = {}
local currentFrame = 1
local frameTime = 0.1 -- Time per frame
local timer = 0
local playerSprite

local data = {
    position = { x = 100, y = 100 },
    speed = 200,
    width = 32,
    height = 32,
    velocity = { x = 0, y = 0 },
    friction = 10,
    boost = 1,
}

function player.Load()
    playerSprite = love.graphics.newImage("assets/images/radish-man.png")
    local frameWidth, frameHeight = 32, 32
    for i = 0, (playerSprite:getWidth() / frameWidth) - 1 do
        quads[#quads + 1] = love.graphics.newQuad(
            i * frameWidth, 0, frameWidth, frameHeight, playerSprite:getDimensions()
        )
    end
end

local function setBoost()
    if love.keyboard.isDown("space") then
        data.boost = 2
    end
end

local function setVelocity(dt)
    if love.keyboard.isDown("w") then
        data.velocity.y = -data.speed * data.boost
    elseif love.keyboard.isDown("s") then
        data.velocity.y = data.speed * data.boost
    else
        data.velocity.y = data.velocity.y * (1 - data.friction * dt)
    end

    if love.keyboard.isDown("a") then
        data.velocity.x = -data.speed * data.boost
    elseif love.keyboard.isDown("d") then
        data.velocity.x = data.speed * data.boost
    else
        data.velocity.x = data.velocity.x * (1 - data.friction * dt)
    end
end


local function setPostion(dt)
    data.velocity.x = data.velocity.x * (1 - data.friction * dt)
    data.velocity.y = data.velocity.y * (1 - data.friction * dt)
    data.position.x = data.position.x + data.velocity.x * dt
    data.position.y = data.position.y + data.velocity.y * dt
end


local function setAnimation(dt)
    timer = timer + dt
    if timer > frameTime then
        timer = 0
        currentFrame = currentFrame % #quads + 1
    end
end

function player.Update(dt)
    setBoost()
    setVelocity(dt)
    setPostion(dt)
    setAnimation(dt)
end

function player.Draw()
    love.graphics.draw(playerSprite, quads[currentFrame], data.position.x, data.position.y)
end

return player
