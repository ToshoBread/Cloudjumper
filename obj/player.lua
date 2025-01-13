function Player(init)
    local self = {}

    local x = init.x or 0
    local y = init.y or 0
    local width = init.width or 0
    local height = init.height or 0
    local speed = init.speed or 0
    local color = {
        r = init.color.r or 0,
        g = init.color.g or 0,
        b = init.color.b or 0,
        a = init.color.a or 0
    }

    --& Class Methods

    function self.update()
        self.move()
        self.collide()
    end

    function self.draw()
        love.graphics.setColor(color.r, color.g, color.b, color.a)
        love.graphics.rectangle("fill", x, y, width, height)
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
        if x + width > love.graphics.getWidth() then
            x = love.graphics.getWidth() - width
        end
    end

    --* Getters and Setters

    function self.getWidth()
        return width
    end

    return self
end
