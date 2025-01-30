require "obj.player"

scene:addState("game")

game = {}

local PLAYER_SPRITE = love.graphics.newImage(res.images.playerSprite)

local player = Player({
    x = VIRTUAL_WIDTH * 0.5 - (PLAYER_SPRITE:getWidth() * 0.5),
    y = VIRTUAL_HEIGHT * 0.8 - (PLAYER_SPRITE:getHeight() * 0.5),
    speed = 5,
    sprite = PLAYER_SPRITE,
})

--* Render Functions
game.update = function()
    player.update()
end

game.draw = function()
    player.draw()
end

return game
