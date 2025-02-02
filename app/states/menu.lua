require "obj.button"

scene:mainState("menu")

menu = {}

local PLAY_BTN_SPRITE = love.graphics.newImage(res.images.playBtnSprite)
local SETTINGS_BTN_SPRITE = love.graphics.newImage(res.images.settingsBtnSprite)
local EXIT_BTN_SPRITE = love.graphics.newImage(res.images.exitBtnSprite)

local buttons = {}

table.insert(buttons, 1, Button({
    id = "play",
    x = VIRTUAL_WIDTH * 0.5 - (PLAY_BTN_SPRITE:getWidth() * 0.5),
    sprite = PLAY_BTN_SPRITE,


    onClick = function() scene:changeState("game") end
}))

table.insert(buttons, 2, Button({
    id = "settings",
    x = VIRTUAL_WIDTH * 0.5 - (SETTINGS_BTN_SPRITE:getWidth() * 0.5),
    sprite = SETTINGS_BTN_SPRITE,

    onClick = function() print("Settings") end
}))

table.insert(buttons, 3, Button({
    id = "exit",
    x = VIRTUAL_WIDTH * 0.5 - (EXIT_BTN_SPRITE:getWidth() * 0.5),
    sprite = EXIT_BTN_SPRITE,

    onClick = function() love.event.quit() end
}))

--* Render Functions

function menu.update()
    for _, button in pairs(buttons) do button.update() end
end

local TOP = 0.7
local MARGIN = 15
function menu.draw()
    local totalHeight = MARGIN
    local averageButtonHeight = 0
    local offset = 0

    for _, button in ipairs(buttons) do
        averageButtonHeight = averageButtonHeight + button:getSprite():getHeight()
    end

    averageButtonHeight = averageButtonHeight / #buttons
    totalHeight = (averageButtonHeight + MARGIN) * #buttons

    for _, button in ipairs(buttons) do
        button:setY(VIRTUAL_HEIGHT * TOP - (totalHeight * 0.5) + offset)
        button.draw()

        offset = offset + (averageButtonHeight + MARGIN)
    end
end

return menu
