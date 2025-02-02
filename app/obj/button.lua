local RIGHT_MOUSE_BUTTON = 1

function Button(init)
    local self = {}

    local id = init.id or ""
    local x = init.x or 0
    local y = init.y or 0

    local sprite = init.sprite
    local scale = init.scale or 1

    local onClick = init.onClick or function() end

    local onHover = init.onHover or function() print("No Hover Function!") end

    local unHover = init.unHover or function() print("No Unhover Function!") end

    --& Class Methods

    function self:hover()
        local mouseX, mouseY = push:toGame(love.mouse.getPosition())
        mouseX, mouseY = mouseX or 0, mouseY or 0
        return mouseX >= x and mouseX <= x + sprite:getWidth() and mouseY >= y and
            mouseY <= y + sprite:getHeight()
    end

    function self:click() return love.mouse.isDown(RIGHT_MOUSE_BUTTON) end

    function self:getID() return id end

    function self:getPosition() return x, y end

    function self:getSprite() return sprite end

    function self:getY() return y end

    function self:setY(newY) y = newY end

    --* Render Functions

    local hovered = false
    local clicked = false

    function self.update()
        if self:hover() then
            if not hovered then
                hovered = true
                onHover()
            end
            if self:click() then
                if not clicked then
                    clicked = true
                    onClick()
                end
            else
                clicked = false
            end
        elseif hovered then
            hovered = false
            unHover()
        end
    end

    function self.draw()
        love.graphics.draw(sprite, x, y, 0, scale, scale)
    end

    return self
end

return Button
