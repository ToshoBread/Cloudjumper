scene:addState("lose")

lose = {}
local message = "You Lose"

--* Render Functions

lose.draw = function()
    love.graphics.setFont(FONT)
    love.graphics.print(message, VIRTUAL_WIDTH * 0.5 * 0.5, VIRTUAL_HEIGHT * 0.5)
end

return lose
