require "obj.selector"

scene:addState("pregame")

pregame = {}

local selectors = {}

table.insert(selectors, Selector({
    id = "players",
    x = (VIRTUAL_WIDTH * 0.5) * 0.8,
    width = 36,

    offset = 18,

    values = { "1 Player", "2 Players" },
}))

--* Render Functions

function pregame.update(delta)
    for _, selector in pairs(selectors) do selector.update() end
end

local TOP = 30
local MARGIN = 15
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
        selector.draw()

        offset = offset + (averageSelectorHeight + MARGIN)
    end
end

return pregame
