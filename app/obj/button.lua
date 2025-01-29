local RIGHT_MOUSE_BUTTON = 1

function Button(init)
    local self = {}

    local x = init.x or 0
    local y = init.y or 0

    local sprite = init.sprite
    local scale = init.scale or 1

    local onClick = init.onClick or function() print("No Click Function!") end

    local onHover = init.onHover or function() print("No Hover Function!") end

    local unHover = init.unHover or function() print("No Unhover Function!") end

    --& Class Methods

    function self:hover()
        local mouseX, mouseY = push:toGame(love.mouse.getPosition())
        mouseX, mouseY = mouseX or 0, mouseY or 0
        return mouseX >= x and mouseX <= x + sprite:getWidth() and mouseY >= y and
            mouseY <= y + sprite:getHeight()
    end

    --* Render Functions

    local hovered = false
    local clicked = false

    function self.update()
        if self:hover() then
            if not hovered then
                hovered = true
                onHover()
            end
            if love.mouse.isDown(RIGHT_MOUSE_BUTTON) then
                if not clicked then
                    clicked = true
                    onClick()
                end
            else
                clicked = false
            end
        else
            if hovered then
                hovered = false
                unHover()
            end
        end
    end

    function self.draw()
        love.graphics.draw(sprite, x, y, 0, scale, scale)
    end

    return self
end

return Button
