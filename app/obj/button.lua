function Button(init)
    local self = {}

    local x = init.x or 0
    local y = init.y or 0

    local sprite = init.sprite
    local scale = init.scale or 1

    local onClick = init.onClick or function() print("No Click Function!") end

    local onHover = init.onHover or function() print("No Hover Function!") end

    --& Class Methods

    function self.update()
        if self.hover() then
            onHover()
            if love.mouse.isDown(1) then onClick() end
        end
    end

    function self.draw()
        love.graphics.draw(sprite, x, y)
    end

    function self.hover()
        local mouseX, mouseY = love.mouse.getPosition()
        return mouseX >= x and mouseX <= x + sprite:getWidth() and mouseY >= y and
            mouseY <= y + sprite:getHeight()
    end

    return self
end
