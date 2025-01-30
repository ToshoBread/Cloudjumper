local STATES_PATH = "states."

StateManager = {
    state = {},

    requireStates = function(self)
        local files = love.filesystem.getDirectoryItems(STATES_PATH)
        for _, file in ipairs(files) do
            if file:match("%.lua$") then
                require(STATES_PATH .. file:sub(1, -5)) -- Remove the .lua extension
            end
        end
    end,

    changeState = function(self, nextState)
        for key in pairs(self.state) do
            self.state[key] = key == nextState
        end

        for key, value in pairs(self.state) do
            print(key, value)
        end
    end,

    addState = function(self, newState)
        self.state[newState] = false
    end,

    mainState = function(self, newState)
        self:addState(newState)
        self.state[newState] = true
    end,

    getState = function(self)
        for state, active in pairs(self.state) do
            if active then return state end
        end
    end
}

return StateManager
