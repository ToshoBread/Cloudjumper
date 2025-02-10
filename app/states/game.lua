require "obj.player"
require "obj.ball"

scene:addState("game")

game = {}

local PLAYER_SPRITE = love.graphics.newImage(res.images.playerSprite)

local singleplayer = true
local playerSpeed = 1.25

local ball = Ball({
    x = VIRTUAL_WIDTH * 0.5,
    y = VIRTUAL_WIDTH * 0.5,
    acceleration = 100,
    scale = 6
})

local player1 = Player({
    x = VIRTUAL_WIDTH * 0.5 - (PLAYER_SPRITE:getWidth() * 0.5),
    y = VIRTUAL_HEIGHT * 0.95 - (PLAYER_SPRITE:getHeight() * 0.5),
    speed = playerSpeed,
    sprite = PLAYER_SPRITE,
    keybinds = { left = "a", right = "d" }
})

local player2 = Player({
    x = VIRTUAL_WIDTH * 0.5 - (PLAYER_SPRITE:getWidth() * 0.5),
    y = VIRTUAL_HEIGHT * 0.05 - (PLAYER_SPRITE:getHeight() * 0.5),
    speed = playerSpeed,
    sprite = PLAYER_SPRITE,
    keybinds = { left = "left", right = "right" }
})

local function checkCollision(a, b)
    local aLeft, aRight, aTop, aBottom = a:getHitbox()
    local bLeft, bRight, bTop, bBottom = b:getHitbox()
    return aLeft < bRight
        and aRight > bLeft
        and aTop < bBottom
        and aBottom > bTop
end

local function paddleBounce(delta)
    local ballVelX, ballVelY = ball:getVector()
    local player1VelX, _ = player1:getVelocity()
    local player2VelX, _ = player2:getVelocity()
    if checkCollision(ball, player1) or checkCollision(ball, player2) then
        if ((ballVelX > 0 and player1VelX < 0) or (ballVelX < 0 and player1VelX > 0))
            or ((ballVelX > 0 and player2VelX < 0) or (ballVelX < 0 and player2VelX > 0)) then
            ballVelX = -ballVelX
        end

        if ballVelY > 0 then
            ball:setY(player1:getY() - ball:getHeight())
            ball:setVelocity(ballVelX, -ballVelY - 5)
        else
            ball:setY(player2:getY() + player2:getHeight() + ball:getHeight())
            ball:setVelocity(ballVelX, -ballVelY + 5)
        end
    end
end

local function autoPilot(delta)
    local ballX, ballY = ball:getPosition()
    local player2X = player2:getX()
    local player2VelX, _ = player2:getVelocity()

    if ballY > VIRTUAL_HEIGHT * 0.5 then
        player2:setVelocity(0, 0)
    elseif ballX < player2X - 8 then
        player2:setVelocity(-1, 0)
    elseif ballX > player2X + player2:getWidth() + 8 then
        player2:setVelocity(1, 0)
    end
end

--* Render Functions

function game.update(delta)
    ball.update(delta)
    player1.update(delta)
    player2.update(delta)

    paddleBounce(delta)

    player1:control(delta)
    if singleplayer then
        autoPilot(delta)
    else
        player2:control(delta)
    end
end

function game.draw()
    ball.draw()
    player1.draw()
    player2.draw()
end

--^ Debug Functions
function game.debug()
    player1.debug()
    ball.debug()

    if love.keyboard.isDown("p") then singleplayer = not singleplayer end
    love.graphics.setFont(FONT)
    local mode = singleplayer and "Singleplayer" or "Multiplayer"
    love.graphics.print("Mode: " .. mode, 0, 250)
end

return game
