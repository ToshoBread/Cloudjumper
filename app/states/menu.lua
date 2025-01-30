require "obj.button"

scene:mainState("menu")

menu = {}

local PLAY_BTN_SPRITE = love.graphics.newImage(res.images.buttonSprite)
local MARGIN = 20

local buttons = {
    playBtn = Button({
        x = VIRTUAL_WIDTH * 0.5 - (PLAY_BTN_SPRITE:getWidth() * 0.5),
        y = VIRTUAL_HEIGHT * 0.5 - (PLAY_BTN_SPRITE:getHeight() * 0.5),
        sprite = PLAY_BTN_SPRITE,

        onClick = function()
            if scene.state.game then
                scene:changeState("menu")
            else
                scene:changeState("game")
            end
        end
    }),

    settingsBtn = Button({
        x = VIRTUAL_WIDTH * 0.5 - (PLAY_BTN_SPRITE:getWidth() * 0.5),
        y = VIRTUAL_HEIGHT * 0.5 - (PLAY_BTN_SPRITE:getHeight() * 0.5) + MARGIN,
        sprite = PLAY_BTN_SPRITE,

        onClick = function() print("Settings") end
    }),

    exitBtn = Button({
        x = VIRTUAL_WIDTH * 0.5 - (PLAY_BTN_SPRITE:getWidth() * 0.5),
        y = VIRTUAL_HEIGHT * 0.5 - (PLAY_BTN_SPRITE:getHeight() * 0.5) + MARGIN * 2,
        sprite = PLAY_BTN_SPRITE,

        onClick = function() love.event.quit() end
    })
}

--* Render Functions

menu.update = function()
    for _, button in pairs(buttons) do
        button.update()
    end
end

menu.draw = function()
    for _, button in pairs(buttons) do
        button.draw()
    end
end

return menu
