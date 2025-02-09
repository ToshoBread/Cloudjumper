require "obj.player"
require "obj.ball"

scene:addState("game")

game = {}

local PLAYER_SPRITE = love.graphics.newImage(res.images.playerSprite)

local player = Player({
    x = VIRTUAL_WIDTH * 0.5 - (PLAYER_SPRITE:getWidth() * 0.5),
    y = VIRTUAL_HEIGHT * 0.95 - (PLAYER_SPRITE:getHeight() * 0.5),
    speed = 1.5,
    sprite = PLAYER_SPRITE,
})

local ball = Ball({
    x = VIRTUAL_WIDTH * 0.5,
    y = VIRTUAL_WIDTH * 0.5,
    acceleration = 100,
    scale = 6
})

local function checkCollision(a, b)
    local aLeft, aRight, aTop, aBottom = a:getHitbox()
    local bLeft, bRight, bTop, bBottom = b:getHitbox()
    return aLeft < bRight
        and aRight > bLeft
        and aTop < bBottom
        and aBottom > bTop
end

--* Render Functions

function game.update(delta)
    player.update(delta)
    ball.update(delta)

    local ballVelX, ballVelY = ball:getVector()
    local playerVelX, playerVelY = player:getVelocity()
    if checkCollision(ball, player) then
        if ballVelY > 0 then
            ball:setY(player:getY() - ball:getHeight())
        else
            ball:setY(player:getY() + player:getHeight() + ball:getHeight())
        end

        if (ballVelX > 0 and playerVelX < 0) or (ballVelX < 0 and playerVelX > 0) then
            ballVelX = -ballVelX
        end

        ball:setVelocity(ballVelX, -ballVelY)
    end
end

function game.draw()
    ball.draw()
    player.draw()
    love.graphics.setColor(0, 0, 0)
end

--^ Debug Functions
function game.debug()
    player.debug()
    ball.debug()
end

return game
