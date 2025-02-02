local STATES_PATH = "states."

StateManager = {}
state = {}

function StateManager:requireStates()
    local files = love.filesystem.getDirectoryItems(STATES_PATH)
    for _, file in ipairs(files) do
        if file:match("%.lua$") then
            require(STATES_PATH .. file:sub(1, -5))     -- Remove the .lua extension
        end
    end
end

function StateManager:changeState(nextState)
    for key in pairs(self.state) do
        self.state[key] = key == nextState
    end

    print("\nChanging to: " .. self:getState())
end

function StateManager:addState(newState)
    self.state[newState] = false
end

function StateManager:mainState(newState)
    self:addState(newState)
    self.state[newState] = true
end

function StateManager:getState()
    for state, active in pairs(self.state) do
        if active then return state end
    end
end

return StateManager
