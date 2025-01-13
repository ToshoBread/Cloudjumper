function Button(init)
    local self = {}

    local x = init.x or 0
    local y = init.y or 0
    local width = init.width or 0
    local height = init.height or 0

    local color = {
        r = init.color.r or 0,
        g = init.color.g or 0,
        b = init.color.b or 0,
        a = init.color.a or 0
    }

    local text = init.text or ""
    local font = init.font or love.graphics.newFont()
    local textColor = {
        r = init.textColor.r or 0,
        g = init.textColor.g or 0,
        b = init.textColor.b or 0,
        a = init.textColor.a or 0
    }

    local onClick = init.onClick or function() print("No Click Function!") end

    local onHover = init.onHover or function()
        print("No Hover Function!")
        love.timer.sleep(1)
    end

    --& Class Methods

    function self.update()
        onHover()
        if love.mouse.isDown(1) then onClick() end
    end

    function self.draw()
        love.graphics.setColor(color.r, color.g, color.b, color.a)
        love.graphics.rectangle("fill", x, y, width, height)
        love.graphics.setColor(textColor.r, textColor.g, textColor.b, textColor.a)
        love.graphics.setFont(font)
        love.graphics.print(text, x + width / 2 - font:getWidth(text) / 2,
            y + height / 2 - font:getHeight() / 2)
    end

    function self.hover()
        local mx, my = love.mouse.getPosition()
        return mx >= x and mx <= x + width and my >= y and my <= y + height and true or false
    end

    --* Getters and Setters

    function self.setColor(newColor)
        color.r = newColor.r or color.r
        color.g = newColor.g or color.g
        color.b = newColor.b or color.b
        color.a = newColor.a or color.a
    end

    return self
end
