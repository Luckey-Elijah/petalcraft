local currentFrame = 1
local frameTime = 0.1 -- Time per frame
local timer = 0
local playerSprite

local player = {
    quads = {},
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
        player.quads[#player.quads + 1] = love.graphics.newQuad(
            i * frameWidth, 0, frameWidth, frameHeight, playerSprite:getDimensions()
        )
    end
end

local function setBoost()
    if love.keyboard.isDown("space") then
        player.boost = 2
    end
end

local function setVelocity(dt)
    if love.keyboard.isDown("w") then
        player.velocity.y = -player.speed * player.boost
    elseif love.keyboard.isDown("s") then
        player.velocity.y = player.speed * player.boost
    else
        player.velocity.y = player.velocity.y * (1 - player.friction * dt)
    end

    if love.keyboard.isDown("a") then
        player.velocity.x = -player.speed * player.boost
    elseif love.keyboard.isDown("d") then
        player.velocity.x = player.speed * player.boost
    else
        player.velocity.x = player.velocity.x * (1 - player.friction * dt)
    end
end


local function setPostion(dt)
    player.velocity.x = player.velocity.x * (1 - player.friction * dt)
    player.velocity.y = player.velocity.y * (1 - player.friction * dt)
    player.position.x = player.position.x + player.velocity.x * dt
    player.position.y = player.position.y + player.velocity.y * dt
end


local function setAnimation(dt)
    timer = timer + dt
    if timer > frameTime then
        timer = 0
        currentFrame = currentFrame % #player.quads + 1
    end
end

function player.Update(dt)
    setBoost()
    setVelocity(dt)
    setPostion(dt)
    setAnimation(dt)
end

function player.Draw()
    love.graphics.draw(playerSprite, player.quads[currentFrame], player.position.x, player.position.y)
end

return player
