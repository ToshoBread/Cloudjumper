require "obj.player"
require "obj.ball"

scene:addState("game")

game = {}

local PLAYER_SPRITE = love.graphics.newImage(res.images.playerSprite)

local player = Player({
    x = VIRTUAL_WIDTH * 0.5 - (PLAYER_SPRITE:getWidth() * 0.5),
    y = VIRTUAL_HEIGHT * 0.95 - (PLAYER_SPRITE:getHeight() * 0.5),
    speed = 2,
    sprite = PLAYER_SPRITE
})

local ball = Ball({
    x = VIRTUAL_WIDTH * 0.5,
    y = VIRTUAL_WIDTH * 0.5,
    acceleration = 4,
    scale = 8
})


--* Render Functions
game.update = function(delta)
    player.update(delta)
    ball.update(delta)
end

game.draw = function()
    ball.draw()
    player.draw()
    love.graphics.setFont(love.graphics.newFont(12))
end

--^ Debug Functions
function game.debug()
    player.debug()
    ball.debug()
end

return game
