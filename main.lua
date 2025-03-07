local lick = require("lick")
local gridSize = 50
local rect = { x = 100, y = 100, width = 50, height = 50, dragging = false }
local snapSpeed = 10
lick.reset = true -- reload love.load every time you save

local function drawGrid()
    love.graphics.setColor(0.8, 0.8, 0.8)
    for x = 0, love.graphics.getWidth(), gridSize do
        love.graphics.line(x, 0, x, love.graphics.getHeight())
    end
    for y = 0, love.graphics.getHeight(), gridSize do
        love.graphics.line(0, y, love.graphics.getWidth(), y)
    end
end

function love.load()
    love.graphics.setBackgroundColor(1, 1, 1)
end

function love.update(dt)
    if rect.dragging then
        local mouseX, mouseY = love.mouse.getPosition()

        rect.x = mouseX - rect.width / 2
        rect.y = mouseY - rect.height / 2
    else
        local targetX = math.floor((rect.x + (rect.width / 2)) / gridSize) * gridSize
        local targetY = math.floor((rect.y + (rect.height / 2)) / gridSize) * gridSize
        rect.x = rect.x + (targetX - rect.x) * snapSpeed * dt
        rect.y = rect.y + (targetY - rect.y) * snapSpeed * dt
    end
end

function love.mousepressed(x, y, button, istouch, presses)
    if button == 1 and x > rect.x and x < rect.x + rect.width and y > rect.y and y < rect.y + rect.height then
        rect.dragging = true
    end
end

function love.mousereleased(x, y, button, istouch, presses)
    if button == 1 then
        rect.dragging = false
    end
end

function love.draw()
    drawGrid()

    if rect.dragging then
        love.graphics.setColor(0.5, 0.5, 1, 0.8)
    else
        love.graphics.setColor(0, 0, 1)
    end

    love.graphics.rectangle("fill", rect.x + 4, rect.y + 4, rect.width - 8, rect.height - 8)
end
