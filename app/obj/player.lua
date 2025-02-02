function Player(init)
    local self = {}

    local x = init.x or 0
    local y = init.y or 0
    local speed = (init.speed or 1) * 100

    local sprite = init.sprite
    local scale = init.scale or 1

    local hitbox = {}

    --& Class Methods

    function self:move(delta)
        if love.keyboard.isDown("a") then
            x = x - speed * delta
        end
        if love.keyboard.isDown("d") then
            x = x + speed * delta
        end
    end

    function self:collide(delta)
        hitbox.left = x - scale
        hitbox.right = x + (sprite:getWidth() * scale)
        hitbox.top = y - scale
        hitbox.bottom = y + (sprite:getHeight() * scale)

        -- Left Boundary
        if hitbox.left < 0 then x = 0 end
        -- Right Boundary
        if hitbox.right > VIRTUAL_WIDTH then
            x = VIRTUAL_WIDTH - (sprite:getWidth() * scale)
        end
    end

    function self:getX()
        return x
    end

    function self:getY()
        return y
    end

    function self:getHitbox()
        return hitbox.left, hitbox.right, hitbox.top, hitbox.bottom
    end

    function self:getScale()
        return scale
    end

    --* Render Functions

    function self.update(delta)
        self:move(delta)
        self:collide(delta)
    end

    function self.draw()
        love.graphics.draw(sprite, x, y, nil, scale, scale)
    end

    --^ Debug Functions
    function self.debug()
        love.graphics.print(string.format("Player Pos.\nX:%d\tY:%d", x, y), 0, 300)
    end

    return self
end

return Player
