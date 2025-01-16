directory = {}

--! Resources
directory.res = "res/"

directory.sprites = directory.res .. "img/"

directory.playerSprite = directory.sprites .. "cloudPaddle.png"
directory.playBtnSprite = directory.sprites .. "playBtn.png"

--? Objects
directory.obj = "obj/"

directory.playerObj = directory.obj .. "player"
directory.buttonObj = directory.obj .. "button"

for _, value in pairs(directory) do
    if value:match("%obj/%a+") then
        require(value)
    end
end

return directory
