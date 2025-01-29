function love.load()
    love = require "love"
    push = require "lib/public/push"
    res = require "res/dir"
    stateManager = require "states/stateManager"

    game = StateManager()
    require "obj/button"

    WINDOW_WIDTH, WINDOW_HEIGHT = love.window.getDesktopDimensions()
    WINDOW_WIDTH, WINDOW_HEIGHT = WINDOW_WIDTH * 0.5, WINDOW_HEIGHT * 0.5
    VIRTUAL_WIDTH, VIRTUAL_HEIGHT = 125, 225

    love.graphics.setDefaultFilter("nearest", "nearest") --? Removes Antialiasing

    font = love.graphics.newFont(18)

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true
    })

    playBtnSprite = love.graphics.newImage(res.images.buttonSprite)
    playBtn = Button({
        x = VIRTUAL_WIDTH * 0.5 - (playBtnSprite:getWidth() * 0.5),
        y = VIRTUAL_HEIGHT * 0.5 - (playBtnSprite:getHeight() * 0.5),
        sprite = playBtnSprite,

        onClick = function()
            if game.state.game then
                game:changeState("menu")
            else
                game:changeState("game")
            end
        end
    })
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.update(delta)
    playBtn.update()
end

function love.draw()
    love.graphics.setFont(font)
    love.graphics.print("State: " .. game:getState(), 0, 0)

    push:start()
    playBtn.draw()
    push:finish()
end
