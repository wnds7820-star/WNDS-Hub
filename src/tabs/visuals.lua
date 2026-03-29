-- src/tabs/visuals.lua
local Init = loadstring(game:HttpGet("https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/src/init.lua"))()
local Window = Init.Window

local Tab = Window:Tab({
    Title = "Visuals",
    Icon = "solar:eye-bold",
    IconColor = Color3.fromHex("#ECA201"),
    Border = true,
})

Tab:Toggle({
    Title = "ESP",
    Callback = function(v)
        print("ESP:", v)
    end,
})

Tab:Toggle({
    Title = "Fullbright",
    Callback = function(v)
        print("Fullbright:", v)
    end,
})

Tab:Toggle({
    Title = "No Fog",
    Callback = function(v)
        print("No Fog:", v)
    end,
})
