require "obj.button"

scene:addState("pause")

pause = {}

local EXIT_BTN_SPRITE = love.graphics.newImage(res.images.exitBtnSprite)
local MARGIN = 0.5

local buttons = {
    returnBtn = Button({
        x = VIRTUAL_WIDTH * 0.5 - (EXIT_BTN_SPRITE:getWidth() * 0.5),
        y = VIRTUAL_HEIGHT * MARGIN - (EXIT_BTN_SPRITE:getHeight() * 0.5),
        sprite = EXIT_BTN_SPRITE,

        onClick = function() scene:changeState("menu") end
    })
}

--* Render Functions

pause.update = function()
    for _, button in pairs(buttons) do
        button.update()
    end
end

pause.draw = function()
    for _, button in pairs(buttons) do
        button.draw()
    end
end

return pause
