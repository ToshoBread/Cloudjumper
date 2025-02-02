local vector = require "lib.public.vector"

function Ball(init)
    local self = {}

    local x = init.x or 0
    local y = init.y or 0
    local velocity = vector.new(0, 0)
    local acceleration = init.acceleration or 1

    local hitbox = {}

    local scale = init.scale or 1

    --& Class Methods

    function self:move(delta)
        local deltAcceleration = acceleration * delta
        if debugMode then
            if love.keyboard.isDown("up") then
                velocity.y = velocity.y - deltAcceleration
            end
            if love.keyboard.isDown("down") then
                velocity.y = velocity.y + deltAcceleration
            end
            if love.keyboard.isDown("left") then
                velocity.x = velocity.x - deltAcceleration
            end
            if love.keyboard.isDown("right") then
                velocity.x = velocity.x + deltAcceleration
            end
        end
        x, y = x + velocity.x, y + velocity.y
    end

    function self:collide(delta)
        hitbox.left = x - scale
        hitbox.right = x + scale
        hitbox.top = y - scale
        hitbox.bottom = y + scale
        -- Left Boundary
        if hitbox.left < 0 then
            -- x = 0
            velocity.x = -velocity.x
        end
        -- Right Boundary
        if hitbox.right > VIRTUAL_WIDTH then
            -- x = VIRTUAL_WIDTH
            velocity.x = -velocity.x
        end
        -- Top Boundary
        if hitbox.top < 0 then
            -- y = 0
            velocity.y = -velocity.y
        end
        -- Bottom Boundary
        if hitbox.bottom > VIRTUAL_HEIGHT + 50 then
            -- y = VIRTUAL_HEIGHT
            velocity.y = -velocity.y
        end
    end

    function self:getPosition()
        return x, y
    end

    function self:getHitbox()
        return hitbox.left, hitbox.right, hitbox.top, hitbox.bottom
    end

    --* Render Functions

    function self.update(delta, player1)
        self:move(delta)
        self:collide(delta)
    end

    function self.draw()
        love.graphics.setColor(255, 255, 255)
        love.graphics.circle("fill", x, y, scale)
    end

    --^ Debug Functions
    function self.debug()
        love.graphics.print(
            string.format("Ball Coor.\nX:%d\tY:%d\nVelX:%d\tVelY:%d\nAcceleration:%d",
                x, y, velocity.x, velocity.y, acceleration), 0, 125)
    end

    return self
end

return Ball
