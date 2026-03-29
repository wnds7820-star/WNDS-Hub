-- src/tabs/combat.lua
local Init = loadstring(game:HttpGet("https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/src/init.lua"))()
local Window = Init.Window

local Tab = Window:Tab({
    Title = "Combat",
    Icon = "solar:sword-bold",
    IconColor = Color3.fromHex("#EF4F1D"),
    Border = true,
})

Tab:Toggle({
    Title = "Aimbot",
    Callback = function(v)
        print("Aimbot:", v)
    end,
})

Tab:Toggle({
    Title = "Kill Aura",
    Callback = function(v)
        print("Kill Aura:", v)
    end,
})
