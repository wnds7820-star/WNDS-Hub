-- src/tabs/movement.lua
local Init = loadstring(game:HttpGet("https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/src/init.lua"))()
local Window = Init.Window

local Tab = Window:Tab({
    Title = "Movement",
    Icon = "solar:running-bold",
    IconColor = Color3.fromHex("#257AF7"),
    Border = true,
})

Tab:Toggle({
    Title = "Fly",
    Callback = function(v)
        print("Fly:", v)
    end,
})

Tab:Slider({
    Title = "Fly Speed",
    Value = { Min = 1, Max = 200, Default = 50 },
    Step = 1,
    Callback = function(v)
        print("Fly Speed:", v)
    end,
})

Tab:Toggle({
    Title = "NoClip",
    Callback = function(v)
        print("NoClip:", v)
    end,
})
