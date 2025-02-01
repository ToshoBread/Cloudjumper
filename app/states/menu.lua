require "obj.button"

scene:mainState("menu")

menu = {}

local PLAY_BTN_SPRITE = love.graphics.newImage(res.images.playBtnSprite)
local SETTINGS_BTN_SPRITE = love.graphics.newImage(res.images.settingsBtnSprite)
local EXIT_BTN_SPRITE = love.graphics.newImage(res.images.exitBtnSprite)
local MARGIN = 0.4
local OFFSET = 25

local buttons = {
    playBtn = Button({
        x = VIRTUAL_WIDTH * 0.5 - (PLAY_BTN_SPRITE:getWidth() * 0.5),
        y = VIRTUAL_HEIGHT * MARGIN - (PLAY_BTN_SPRITE:getHeight() * 0.5),
        sprite = PLAY_BTN_SPRITE,

        onClick = function() scene:changeState("game") end
    }),

    settingsBtn = Button({
        x = VIRTUAL_WIDTH * 0.5 - (SETTINGS_BTN_SPRITE:getWidth() * 0.5),
        y = VIRTUAL_HEIGHT * MARGIN - (SETTINGS_BTN_SPRITE:getHeight() * 0.5) + OFFSET,
        sprite = SETTINGS_BTN_SPRITE,

        onClick = function() print("Settings") end
    }),

    exitBtn = Button({
        x = VIRTUAL_WIDTH * 0.5 - (EXIT_BTN_SPRITE:getWidth() * 0.5),
        y = VIRTUAL_HEIGHT * MARGIN - (EXIT_BTN_SPRITE:getHeight() * 0.5) + OFFSET * 2,
        sprite = EXIT_BTN_SPRITE,

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
