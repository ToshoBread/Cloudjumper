require "obj.button"

local LEFT_SELECTOR = love.graphics.newImage(res.images.selectorLeftSprite)
local RIGHT_SELECTOR = love.graphics.newImage(res.images.selectorRightSprite)

function Selector(init)
    local self = {}

    local id = init.id or ""
    local x = init.x or 0
    local y = init.y or 0

    local width = init.width or 0
    local scale = init.scale or 1

    local offset = init.offset or 8
    local values = init.values or {}
    local index = 1

    local currentValue = values[index]

    local selectorFont = love.graphics.newFont(10)
    local valueDisplay = love.graphics.newText(selectorFont, currentValue)


    local buttons = {}

    table.insert(buttons, Button({
        id = id .. "left",
        x = x - offset,
        sprite = LEFT_SELECTOR,
        scale = scale,

        onClick = function()
            index = index - 1
            if index < 1 then index = #values end
        end
    }))

    table.insert(buttons, Button({
        id = id .. "right",
        x = x + width * scale + offset,
        sprite = RIGHT_SELECTOR,
        scale = scale,

        onClick = function()
            index = index + 1
            if index > #values then index = 1 end
        end
    }))

    --& Class Methods

    function self:getY() return y end

    function self:setY(newY) y = newY end

    function self:getValue() return currentValue end

    function self:setValue(newValue) currentValue = newValue end

    function self:getHeight() return valueDisplay:getHeight() end

    --* Render Function

    function self.update(delta)
        valueDisplay:set(currentValue)
        self:setValue(values[index])
        for _, button in ipairs(buttons) do
            button.update()
            button:setY(y)
        end
    end

    function self.draw()
        love.graphics.draw(valueDisplay, x - valueDisplay:getWidth() / 100, y - valueDisplay:getHeight() * 0.25)
        for _, button in ipairs(buttons) do button.draw() end
    end

    return self
end

return Selector
