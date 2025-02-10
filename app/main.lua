love = require "love"
push = require "lib.public.push"
res = require "res.dir"
vector = require "lib.public.vector"
scene = require "states.stateManager"

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest") --? Removes Antialiasing

    WINDOW_WIDTH, WINDOW_HEIGHT = love.window.getDesktopDimensions()
    WINDOW_WIDTH, WINDOW_HEIGHT = WINDOW_WIDTH * 0.8, WINDOW_HEIGHT * 0.8
    VIRTUAL_WIDTH, VIRTUAL_HEIGHT = 211, 224
    OFFSCREEN = -100

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true
    })

    scene:requireStates()

    CURSOR_SIZE = 5
    drawCursor = function() love.graphics.circle("fill", mouseX, mouseY, CURSOR_SIZE) end
    cursorParticles = love.graphics.newParticleSystem(love.graphics.newImage(res.images.particle), 25)
    cursorParticles:setParticleLifetime(1, 2.5)
    cursorParticles:setLinearAcceleration(-0.5, -0.5, 0.5, 0.5)
    local opaqueToTransparent = function() return 1, 1, 1, 1, 1, 1, 1, 0 end
    cursorParticles:setColors(opaqueToTransparent())
    cursorParticles:setRotation(1, 360)
    cursorParticles:setSizes(0.5, 1, 1.2)
    cursorParticles:setSizeVariation(1)
    cursorParticles:getEmitterLifetime(-1)
    emitCursorParticles = function() cursorParticles:emit(1) end

    FONT_SIZE = 20
    FONT = love.graphics.newFont(FONT_SIZE)

    debugMode = false
end

function love.resize(w, h) push:resize(w, h) end

function love.update(delta)
    mouseX, mouseY = push:toGame(love.mouse.getPosition())
    mouseX, mouseY = mouseX or OFFSCREEN, mouseY or OFFSCREEN

    local mouseVisibility = mouseX == OFFSCREEN and true or false
    love.mouse.setVisible(mouseVisibility)

    cursorParticles:setPosition(mouseX, mouseY)
    cursorParticles:update(delta)

    if scene.state.menu then
        menu.update(delta)
        emitCursorParticles()
    elseif scene.state.pregame then
        pregame.update(delta)
        emitCursorParticles()
    elseif scene.state.game then
        game.update(delta)
        cursorParticles:reset()
    elseif scene.state.pause then
        pause.update(delta)
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

    if key == "`" then
        debugMode = not debugMode
    end
end

function love.draw()
    love.graphics.setFont(FONT)

    --^ Debug Mode
    if debugMode then
        love.graphics.print("State: " .. scene:getState(), 0, 0)
        love.graphics.print(string.format("Mouse Pos.\nX:%d\tY:%d", mouseX, mouseY), 0, 50)
        if scene.state.game or scene.state.pause then
            game.debug()
        end
    end
    --^----------------------------

    push:start()
    -- Draw here
    love.graphics.setColor(0.41, 0.53, 0.97)
    love.graphics.rectangle("fill", 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)

    love.graphics.setColor(255, 255, 255)
    love.graphics.draw(cursorParticles)

    if scene.state.menu then
        menu.draw()
        drawCursor()
    elseif scene.state.pregame then
        pregame.draw()
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

    if debugMode then
        love.graphics.setColor(255, 255, 255, 0.8)
        love.graphics.line(VIRTUAL_WIDTH * 0.5, 0, VIRTUAL_WIDTH * 0.5, VIRTUAL_HEIGHT)
        love.graphics.line(0, VIRTUAL_HEIGHT * 0.5, VIRTUAL_WIDTH, VIRTUAL_HEIGHT * 0.5)
    end
    push:finish()
end
