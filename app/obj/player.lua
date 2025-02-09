function Player(init)
    local self = {}

    local x = init.x or 0
    local y = init.y or 0
    local speed = (init.speed or 1) * 100
    local velocity = vector.new(0, 0)

    local sprite = init.sprite
    local scale = init.scale or 1

    local keybinds = init.keybinds or { left = "a", right = "d" }

    local hitbox = {
        left = x,
        right = x + (sprite:getWidth() * scale),
        top = y,
        bottom = y + (sprite:getHeight() * scale)
    }

    --& Class Methods

    local function move(delta)
        if love.keyboard.isDown(keybinds.left) then
            -- x = x - speed * delta
            velocity.x = -1
        elseif love.keyboard.isDown(keybinds.right) then
            -- x = x + speed * delta
            velocity.x = 1
        else
            velocity.x = 0
        end

        x = x + (velocity.x * speed) * delta
    end

    local function updateHitbox()
        hitbox.left = x
        hitbox.right = x + (sprite:getWidth() * scale)
        hitbox.top = y
        hitbox.bottom = y + (sprite:getHeight() * scale)
    end

    local function collide(delta)
        -- Left Boundary
        if hitbox.left < 0 then x = 0 end
        -- Right Boundary
        if hitbox.right > VIRTUAL_WIDTH then
            x = VIRTUAL_WIDTH - (sprite:getWidth() * scale)
        end
    end

    function self:getX() return x end

    function self:getY() return y end

    function self:getVelocity() return velocity.x, velocity.y end

    function self:getSprite() return sprite end

    function self:getWidth() return self:getSprite():getWidth() * scale end

    function self:getHeight() return self:getSprite():getHeight() * scale end

    function self:getHitbox() return hitbox.left, hitbox.right, hitbox.top, hitbox.bottom end

    function self:getScale() return scale end

    --* Render Functions

    function self.update(delta)
        move(delta)
        updateHitbox()
        collide(delta)
    end

    function self.draw()
        love.graphics.draw(sprite, x, y, nil, scale, scale)
    end

    --^ Debug Functions
    function self.debug()
        love.graphics.print(string.format("Player Pos.\nX:%d\tY:%d", x, y), 0, 300)
        love.graphics.print(string.format("Player Hitbox\nRight:%d\tBottom:%d", hitbox.right, hitbox.bottom), 0, 350)
    end

    return self
end

return Player
