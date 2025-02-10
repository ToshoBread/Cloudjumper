function Ball(init)
    local self = {}

    local x = init.x or 0
    local y = init.y or 0
    local velocity = vector.new(0, 0)
    local acceleration = init.acceleration or 1

    local scale = init.scale or 1

    local hitbox = {}
    hitbox.left = x - scale
    hitbox.right = x + scale
    hitbox.bottom = y + scale

    --& Class Methods

    local function move(delta)
        local deltAcceleration = acceleration * delta

        x = x + velocity.x * deltAcceleration * delta
        y = y + velocity.y * deltAcceleration * delta
    end

    local function updateHitbox()
        hitbox.left = x - scale
        hitbox.right = x + scale
        hitbox.top = y - scale
        hitbox.bottom = y + scale
    end

    local function collideWithBounds(delta)
        -- Left Boundary
        if hitbox.left < 0 then
            x = 0 + scale
            velocity.x = -velocity.x
        end
        -- Right Boundary
        if hitbox.right > VIRTUAL_WIDTH then
            x = VIRTUAL_WIDTH - scale
            velocity.x = -velocity.x
        end
    end

    local function randomVelocity(m, n)
        random = math.random(math.random(m, n), math.random(m, n))
        if random < -10 or random > 10 then return random end
        return randomVelocity(math.random(m, n), math.random(m, n))
    end

    function self:resetBall()
        x, y = init.x, init.y
        velocity.x = randomVelocity(-50, 50)
        velocity.y = randomVelocity(-50, 50)
    end

    function self:setX(newX) x = newX end

    function self:getY() return y end

    function self:setY(newY) y = newY end

    function self:getHeight() return scale end

    function self:getPosition() return x, y end

    function self:getHitbox() return hitbox.left, hitbox.right, hitbox.top, hitbox.bottom end

    function self:getVelocity() return velocity.x, velocity.y end

    function self:setVelocity(newVelX, newVelY) velocity.x, velocity.y = newVelX, newVelY end

    --* Render Functions

    function self.update(delta)
        move(delta)
        updateHitbox()
        collideWithBounds(delta)

        if love.keyboard.isDown("r") or (velocity == vector.new(0, 0)) then
            self:resetBall()
        end
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
