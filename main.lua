love = require("love")
require("obj/player")
require("obj/button")

function love.load()
    button = Button({
        x = (love.graphics.getWidth() / 2) - (150 / 2),
        y = love.graphics.getHeight() / 2,
        width = 150,
        height = 40,
        color = { r = 1, g = 0, b = 1, a = 1 },

        text = "Play",
        font = love.graphics.newFont(24),
        textColor = { r = 0, g = 0, b = 0, a = 1 },

        onClick = function() print("Button clicked!") end,

        onHover = function()
            if button.hover() then
                button.setColor({ r = 0, g = 1 })
            else
                button.setColor({ r = 1, g = 0 })
            end
        end
    })

    player = Player({
        x = love.graphics.getWidth() / 2 - 50,
        y = love.graphics.getHeight() - 75,
        width = 100,
        height = 20,
        speed = 5,
        color = { r = 1, g = 0, b = 1, a = 1 }
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
