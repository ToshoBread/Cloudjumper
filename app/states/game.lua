require "obj.player"
require "obj.ball"

scene:addState("game")

game = {}

--#region --? Variables
local PLAYER_SPRITE = love.graphics.newImage(res.images.playerSprite)

local ballSensorDistance = 0
local ballAcceleration = 100
local playerSpeed = 1.25

local player1Score = 0
local player2Score = 0
local SCORE_OFFSET = 12

local scoreFont = love.graphics.newFont(21)
local player1ScoreDisplay = love.graphics.newText(scoreFont, player1Score)
local player2ScoreDisplay = love.graphics.newText(scoreFont, player2Score)
--#endregion

local ball = Ball({
    x = VIRTUAL_WIDTH * 0.5,
    y = VIRTUAL_WIDTH * 0.5,
    acceleration = ballAcceleration,
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

--#region --~ State functions

local function checkCollision(a, b)
    local aLeft, aRight, aTop, aBottom = a:getHitbox()
    local bLeft, bRight, bTop, bBottom = b:getHitbox()
    return aLeft < bRight
        and aRight > bLeft
        and aTop < bBottom
        and aBottom > bTop
end

local function checkVelocityCollision(a, b)
    local aVelX, _ = a:getVelocity()
    local bVelX, _ = b:getVelocity()

    return (aVelX > 0 and bVelX < 0)
        or (aVelX < 0 and bVelX > 0)
end

local function checkCornerCollision(a, b)
    local CORNER = 3
    local aLeft, aRight, _, _ = a:getHitbox()
    local bLeft, bRight, _, _ = b:getHitbox()

    return (aRight > bLeft and aRight < bLeft + CORNER)
        or (aLeft < bRight and aLeft > bRight - CORNER)
end

local function paddleBounce(delta)
    local ballVelX, ballVelY = ball:getVelocity()

    if checkCollision(ball, player1) or checkCollision(ball, player2) then
        if -- Checks if the ball hits a moving paddle
            checkVelocityCollision(ball, player1) or checkVelocityCollision(ball, player2)
            -- Checks if the ball hits a paddle's corner
            or checkCornerCollision(ball, player1) or checkCornerCollision(ball, player2)
        then
            -- if either are true, reverse the ball's X velocity
            ballVelX = -ballVelX
        end

        -- Set the ball's Y just outside the hitbox of either paddle to avoid clipping
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

    if ballY > ballSensorDistance then
        player2:setVelocity(0, 0)
    elseif ballX < player2X - 8 then
        player2:setVelocity(-1, 0)
    elseif ballX > player2X + player2:getWidth() + 8 then
        player2:setVelocity(1, 0)
    end
end

local function scoreIncrement(delta)
    local _, _, ballTop, ballBottom = ball:getHitbox()

    if ballBottom < -16 then -- Upper bounds
        player2Score = player2Score + 1
        player2ScoreDisplay:set(player2Score)
        ball:resetBall()
    elseif ballTop > VIRTUAL_HEIGHT + 16 then -- Lower bounds
        player1Score = player1Score + 1
        player1ScoreDisplay:set(player1Score)
        ball:resetBall()
    end
end
--#endregion

--* Render Functions

function game.update(delta)
    ball.update(delta)
    player1.update(delta)
    player2.update(delta)

    paddleBounce(delta)
    scoreIncrement(delta)

    ball:setAcceleration(ball:getAcceleration() * gamerules:getBallSpeedMultiplier())
    player1:setSpeed(player1:getSpeed() * gamerules:getPaddleSpeedMultipler())
    player2:setSpeed(player2:getSpeed() * gamerules:getPaddleSpeedMultipler())

    ballSensorDistance = VIRTUAL_HEIGHT * 0.5
    util:switch(gamerules:getDifficulty()) {
        easy = function() ballSensorDistance = VIRTUAL_HEIGHT * 0.4 end,
        moderate = function() ballSensorDistance = VIRTUAL_HEIGHT * 0.5 end,
        hard = function() ballSensorDistance = VIRTUAL_HEIGHT * 0.8 end
    }

    player1:control(delta)
    if gamerules:getPlayersNumberState() then
        autoPilot(delta)
    else
        player2:control(delta)
    end
end

function game.draw()
    ball.draw()
    player1.draw()
    player2.draw()

    love.graphics.setColor(255, 255, 255, 0.8)
    love.graphics.line(0, VIRTUAL_HEIGHT * 0.5, VIRTUAL_WIDTH, VIRTUAL_HEIGHT * 0.5)
    love.graphics.setFont(FONT)
    love.graphics.draw(player1ScoreDisplay, (VIRTUAL_WIDTH * 0.5) - (player1ScoreDisplay:getWidth() * 0.5),
        (VIRTUAL_HEIGHT * 0.5) - FONT_SIZE - SCORE_OFFSET)
    love.graphics.draw(player2ScoreDisplay, (VIRTUAL_WIDTH * 0.5) - (player2ScoreDisplay:getWidth() * 0.5),
        (VIRTUAL_HEIGHT * 0.5) + SCORE_OFFSET)

    if debugMode then
        love.graphics.setColor(0, 0, 0)
        love.graphics.line(0, ballSensorDistance, VIRTUAL_WIDTH, ballSensorDistance)
        love.graphics.setColor(255, 255, 255)
    end
end

--^ Debug Functions
function game.keypressed(key)
    if key == "return" then
        scene:changeState("lose")
    end
end

function game.debug()
    player1.debug()
    ball.debug()

    love.graphics.setFont(FONT)
    local mode = gamerules:getPlayersNumberState() and "Singleplayer" or "Multiplayer"
    love.graphics.print("Mode: " .. mode, 0, 225)
    love.graphics.print(string.format("Difficulty: %s\nSensorY: %d", gamerules:getDifficulty(), ballSensorDistance), 0,
        250)
    love.graphics.print("Ball Speed: " .. gamerules:getBallSpeedMultiplier() .. "x", 0, 300)
    love.graphics.print("Ball Speed: " .. gamerules:getPaddleSpeedMultipler() .. "x", 0, 325)
end

return game
