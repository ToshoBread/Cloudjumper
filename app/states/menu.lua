function Menu()
    local self = {}

    function self.load()
        local playBtn = love.graphics.newImage(dir.playBtnSprite)

        button = Button({
            x = VIRTUAL_WIDTH * 0.5 - playBtn:getWidth() * 0.5,
            y = VIRTUAL_HEIGHT * 0.5,
            sprite = playBtn,
            onClick = function() print("Button clicked!") end
        })
    end

    function self.update()
        button.update()
    end

    function self.draw()
        button.draw()
    end

    return self
end
