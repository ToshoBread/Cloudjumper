local settings = {
    MINWIDTH = 500,
    MINHEIGHT = 800,
}

function love.conf(z)
    z.version = "11.5"
    z.console = true
    z.gammacorrect = true

    z.window = {
        title = "Cloudjumper",

        width = settings.MINWIDTH,
        height = settings.MINHEIGHT,

        resizable = false,
        minwidth = settings.MINWIDTH,
        minheight = settings.MINHEIGHT,
    }
end
