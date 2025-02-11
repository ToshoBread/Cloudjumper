gamerules = {}

local singleplayer = true
local difficulty = "easy"
local ballSpeedMultiplier = 1
local paddleSpeedMultiplier = 1

function gamerules:getPlayersNumberState() return singleplayer end

function gamerules:setToSingleplayer() singleplayer = true end

function gamerules:setToMultiplayer() singleplayer = false end

function gamerules:getDifficulty() return difficulty end

function gamerules:setDifficulty(newDifficulty) difficulty = newDifficulty end

function gamerules:getBallSpeedMultiplier() return ballSpeedMultiplier end

function gamerules:setBallSpeedMultiplier(newBallSpeedMultiplier) ballSpeedMultiplier = newBallSpeedMultiplier end

function gamerules:getPaddleSpeedMultipler() return paddleSpeedMultiplier end

function gamerules:setPaddleSpeedMultiplier(newPaddleSpeedMultiplier) paddleSpeedMultiplier = newPaddleSpeedMultiplier end

return gamerules
