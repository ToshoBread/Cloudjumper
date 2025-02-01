function Player(init)
    local self = {}

    local x = init.x or 0
    local y = init.y or 0
    local speed = init.speed or 1

    local sprite = init.sprite
    local scale = init.scale or 1

    --& Class Methods

    function self:move()
        if love.keyboard.isDown("a") then
            x = x - speed
        end
        if love.keyboard.isDown("d") then
            x = x + speed
        end
    end

    function self:collide()
        -- Left
        if x < 0 then x = 0 end
        -- Right
        if x + (sprite:getWidth() * scale) > VIRTUAL_WIDTH then
            x = VIRTUAL_WIDTH - (sprite:getWidth() * scale)
        end
    end

    --* Render Functions

    function self.update()
        self:move()
        self:collide()
    end

    function self.draw()
        love.graphics.draw(sprite, x, y, nil, scale, scale)
    end

    return self
end

return Player
