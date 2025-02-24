require "obj.button"
require "obj.selector"

scene:addState("pregame")

pregame = {}

local PLAY_BTN_SPRITE = love.graphics.newImage(res.images.playBtnSprite)

local selectors = {}

local selectorPosX = VIRTUAL_WIDTH * 0.6
local selectorWidth = 36
local selectorOffset = 18

local showDifficulty = true

table.insert(selectors, Selector({
    id = "players",
    label = "Number of Players",
    x = selectorPosX,
    width = selectorWidth,
    offset = selectorOffset,
    values = { "1 Player", "2 Players" }
}))

table.insert(selectors, Selector({
    id = "difficulty",
    label = "Difficulty Level",
    x = selectorPosX,
    width = selectorWidth,
    offset = selectorOffset,
    values = { "Easy", "Moderate", "Hard" }
}))

table.insert(selectors, Selector({
    id = "ballSpeedMultiplier",
    label = "Ball Speed",
    x = selectorPosX,
    width = 6,
    offset = selectorOffset,
    values = { "1x", "2x", "3x", "4x" }
}))

table.insert(selectors, Selector({
    id = "paddleSpeedMultiplier",
    label = "Paddle Speed",
    x = selectorPosX,
    width = 6,
    offset = selectorOffset,
    values = { "1x", "2x", "3x", "4x" }
}))

local startBtn = Button({
    id = "start",
    x = VIRTUAL_WIDTH * 0.5 - (PLAY_BTN_SPRITE:getWidth() * 0.5),
    y = VIRTUAL_HEIGHT * 0.85,
    sprite = PLAY_BTN_SPRITE,

    onClick = function() scene:changeState("game") end
})

--* Render Functions

function pregame.update(delta)
    for _, selector in ipairs(selectors) do selector.update() end

    if selectors[1]:getValue() == "2 Players" then
        showDifficulty = false
    else
        showDifficulty = true
    end

    startBtn.update(delta)
end

function pregame.keypressed(key)

end

local TOP = 50
local MARGIN = 16
function pregame.draw()
    local totalHeight = MARGIN
    local averageSelectorHeight = 0
    local offset = 0

    for _, selector in ipairs(selectors) do
        averageSelectorHeight = averageSelectorHeight + selector:getHeight()
    end

    averageSelectorHeight = averageSelectorHeight / #selectors
    totalHeight = (averageSelectorHeight + MARGIN) * #selectors

    for _, selector in ipairs(selectors) do
        selector:setY(VIRTUAL_HEIGHT * (TOP / 100) - (totalHeight * 0.5) + offset)

        -- Displays all selectors except the diffculty selector
        if selector:getId() ~= "difficulty" then
            selector.draw()
            offset = offset + (averageSelectorHeight + MARGIN)
        end

        -- Display the difficulty selector only if singleplayer is chosen
        if selector:getId() == "difficulty" then
            if showDifficulty then
                selector.draw()
                offset = offset + (averageSelectorHeight + MARGIN)
            end

            gamerules:setDifficulty(string.lower(selector:getValue()))
        end

        if selector:getId() == "players" then
            if selector:getValue() == "1 Player" then
                gamerules:setToSingleplayer()
            else
                gamerules:setToMultiplayer()
            end
        end

        if selector:getId() == "ballSpeedMultiplier" then
            gamerules:setBallSpeedMultiplier(tonumber(string.sub(selector:getValue(), 1, 1)))
        end

        if selector:getId() == "paddleSpeedMultiplier" then
            gamerules:setPaddleSpeedMultiplier(tonumber(string.sub(selector:getValue(), 1, 1)))
        end
    end

    startBtn.draw()
end

return pregame
