love = require "love"
push = require "lib/push"
dir = require "dir"

function love.load()
    WINDOW_WIDTH, WINDOW_HEIGHT = love.window.getDesktopDimensions()
    WINDOW_WIDTH, WINDOW_HEIGHT = WINDOW_WIDTH * 0.5, WINDOW_HEIGHT * 0.5
    VIRTUAL_WIDTH, VIRTUAL_HEIGHT = 125, 225

    love.graphics.setDefaultFilter("nearest", "nearest") --? Removes Antialiasing

    local playBtn = love.graphics.newImage(dir.playBtnSprite)
    local paddle = love.graphics.newImage(dir.playerSprite)

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true
    })

    button = Button({
        x = VIRTUAL_WIDTH * 0.5 - playBtn:getWidth() * 0.5,
        y = VIRTUAL_HEIGHT * 0.5,
        sprite = playBtn,
        onClick = function() print("Button clicked!") end
    })

    player = Player({
        x = VIRTUAL_WIDTH * 0.5 - paddle:getWidth() * 0.5,
        y = VIRTUAL_HEIGHT - 25,
        speed = 5,
        sprite = paddle,
    })
end

function love.update(delta)
    button.update()
    player.update()
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.draw()
    push:start()

    button.draw()
    player.draw()

    push:finish()
end
