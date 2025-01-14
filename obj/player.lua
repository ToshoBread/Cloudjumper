function Player(init)
    local self = {}

    local x = init.x or 0
    local y = init.y or 0
    local speed = init.speed or 0

    local sprite = init.sprite
    local scale = init.scale or 1

    --& Class Methods

    function self.update()
        self.move()
        self.collide()
    end

    function self.draw()
        love.graphics.draw(sprite, x, y, 0, scale, scale)
    end

    function self.move()
        if love.keyboard.isDown("a") then
            x = x - speed
        end
        if love.keyboard.isDown("d") then
            x = x + speed
        end
    end

    function self.collide()
        -- Left
        if x < 0 then x = 0 end
        -- Right
        if x + (sprite:getWidth() * scale) > love.graphics.getWidth() then
            x = love.graphics.getWidth() - (sprite:getWidth() * scale)
        end
    end

    return self
end
