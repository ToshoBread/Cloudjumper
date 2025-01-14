love = require("love")
require("obj/player")
require("obj/button")

GAME_SCALE = 3
love.graphics.setDefaultFilter("nearest", "nearest", 1)
local playBtn = love.graphics.newImage("assets/sprites/play_btn.png")
local paddle = love.graphics.newImage("assets/sprites/cloudPaddle.png")

function love.load()
    button = Button({
        x = love.graphics.getWidth() / 2 - (playBtn:getWidth() * GAME_SCALE) / 2,
        y = love.graphics.getHeight() / 2,

        sprite = playBtn,
        scale = GAME_SCALE,

        onClick = function() print("Button clicked!") end
    })

    player = Player({
        x = love.graphics.getWidth() / 2 - (paddle:getWidth() * GAME_SCALE) / 2,
        y = love.graphics.getHeight() - 75,
        speed = 5,
        sprite = paddle,
        scale = GAME_SCALE
    })
end

function love.update(delta)
    button.update()
    player.update()
end

function love.draw()
    button.draw()
    player.draw()
end
