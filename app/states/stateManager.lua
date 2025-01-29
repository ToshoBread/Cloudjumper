function StateManager()
    return {
        state = {
            menu = false,
            pause = false,
            game = true,
            gameOver = false
        },

        changeState = function(self, state)
            self.state.menu = state == "menu"
            self.state.pause = state == "pause"
            self.state.game = state == "game"
            self.state.gameOver = state == "gameOver"
        end,

        getState = function(self)
            for key, value in pairs(self.state) do
                if value then
                    return key
                end
            end
        end
    }
end

return StateManager
