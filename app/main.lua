love = require "love"
push = require "lib.public.push"
res = require "res.dir"
scene = require "states.stateManager"


function love.load()
    WINDOW_WIDTH, WINDOW_HEIGHT = love.window.getDesktopDimensions()
    WINDOW_WIDTH, WINDOW_HEIGHT = WINDOW_WIDTH * 0.5, WINDOW_HEIGHT * 0.5
    VIRTUAL_WIDTH, VIRTUAL_HEIGHT = 125, 225

    love.graphics.setDefaultFilter("nearest", "nearest") --? Removes Antialiasing

    local FONT_SIZE = 18
    FONT = love.graphics.newFont(FONT_SIZE)

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true
    })

    scene:requireStates()
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.update(delta)
    if scene.state.menu then
        menu.update()
    elseif scene.state.game then
        game.update()
    end
end

function love.keypressed(key)
    if scene.state.game and key == "escape" then
        scene:changeState("pause")
    end

    if scene.state.game and key == "backspace" then
        scene:changeState("lose")
    end

    if scene.state.lose and key == "return" then
        scene:changeState("game")
    end
end

function love.draw()
    love.graphics.setFont(FONT)
    love.graphics.print("State: " .. scene:getState(), 0, 0)

    push:start()
    -- Draw here
    if scene.state.menu then
        menu.draw()
    elseif scene.state.game then
        game.draw()
    elseif scene.state.lose then
        lose.draw()
    elseif scene.state.pause then
        pause.draw()
    end
    push:finish()
end
