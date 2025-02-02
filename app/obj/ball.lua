local vector = require "lib.public.vector"

function Ball(init)
    local self = {}

    local x = init.x or 0
    local y = init.y or 0
    local velocity = vector.new(0, 0)
    local acceleration = init.acceleration or 1

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

    ---@param player1 table Player Object
    function self:collide(player1)
        playerSpriteWidth, playerSpriteHeight = player1:getSpriteDimensions()
        -- Left
        if x < 0 then
            x = 0
            velocity.x = -velocity.x
        end
        -- Right
        if x > VIRTUAL_WIDTH then
            x = VIRTUAL_WIDTH
            velocity.x = -velocity.x
        end
        -- Up
        if y < 0 then
            y = 0
            velocity.y = -velocity.y
        end
        -- Down
        if y > VIRTUAL_HEIGHT + 50 then
            y = VIRTUAL_HEIGHT
            velocity.y = -velocity.y
        end
        if y >= player1:getY() and y <= player1:getY() + playerSpriteHeight and x >= player1:getX() and x <= player1:getX() + playerSpriteWidth then
            if x >= player1:getX() or x <= player1:getX() + playerSpriteWidth then
                velocity.x = -velocity.x
            end
            velocity.y = -velocity.y
        end
    end

    function self:getPosition()
        return x, y
    end

    --* Render Functions

    function self.update(delta, player1)
        self:move(delta)
        self:collide(player1)
    end

    function self.draw()
        love.graphics.setColor(255, 255, 255)
        love.graphics.circle("fill", x, y, scale, scale)
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
