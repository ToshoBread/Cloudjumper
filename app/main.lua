love = require "love"
push = require "lib.public.push"
res = require "res.dir"
scene = require "states.stateManager"

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest") --? Removes Antialiasing

    WINDOW_WIDTH, WINDOW_HEIGHT = love.window.getDesktopDimensions()
    WINDOW_WIDTH, WINDOW_HEIGHT = WINDOW_WIDTH * 0.5, WINDOW_HEIGHT * 0.5
    VIRTUAL_WIDTH, VIRTUAL_HEIGHT = 185, 224
    OFFSCREEN = -100

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true
    })

    scene:requireStates()

    CURSOR_SIZE = 5
    drawCursor = function() love.graphics.circle("fill", mouseX, mouseY, CURSOR_SIZE) end
    cursorParticles = love.graphics.newParticleSystem(love.graphics.newImage(res.images.particle), 25)
    cursorParticles:setParticleLifetime(1, 2)
    cursorParticles:setLinearAcceleration(-0.5, -0.5, 0.5, 0.5)
    cursorParticles:setRotation(0, 360)
    cursorParticles:setSizes(0.5, 1, 1.2)
    cursorParticles:setSizeVariation(1)
    emitCursorParticles = function() cursorParticles:emit(1) end
    cursorParticles:getEmitterLifetime(-1)

    local FONT_SIZE = 20
    FONT = love.graphics.newFont(FONT_SIZE)
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.update(delta)
    mouseX, mouseY = push:toGame(love.mouse.getPosition())
    mouseX, mouseY = mouseX or OFFSCREEN, mouseY or OFFSCREEN

    local mouseVisibility = mouseX == OFFSCREEN and true or false
    love.mouse.setVisible(mouseVisibility)

    cursorParticles:setPosition(mouseX, mouseY)
    cursorParticles:update(delta)

    if scene.state.menu then
        menu.update()
        emitCursorParticles()
    elseif scene.state.game then
        game.update()
        cursorParticles:reset()
    elseif scene.state.pause then
        pause.update()
        emitCursorParticles()
    end
end

function love.keypressed(key)
    if key == "escape" then
        if scene.state.game then
            scene:changeState("pause")
        elseif scene.state.pause then
            scene:changeState("game")
        end
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
    love.graphics.setColor(0.41, 0.53, 0.97)
    love.graphics.rectangle("fill", 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)

    love.graphics.setColor(255, 255, 255)
    love.graphics.draw(cursorParticles)

    if scene.state.menu then
        menu.draw()
        drawCursor()
    elseif scene.state.game or scene.state.pause then
        game.draw()
        if scene.state.pause then
            pause.draw()
            drawCursor()
        end
    elseif scene.state.lose then
        lose.draw()
    end
    push:finish()
end
