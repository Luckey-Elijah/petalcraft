local player = require("player")
local world = require("world")

function love.load()
    world.Load()
    player.Load()
end

function love.update(dt)
    player.Update(dt)
end

function love.draw()
    world.Draw()
    player.Draw()
end
