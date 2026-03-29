-- src/tabs/misc.lua
local Init = loadstring(game:HttpGet("https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/src/init.lua"))()
local Window = Init.Window

local Tab = Window:Tab({
    Title = "Misc",
    Icon = "solar:settings-bold",
    IconColor = Color3.fromHex("#7775F2"),
    Border = true,
})

Tab:Button({
    Title = "Rejoin Server",
    Callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
    end,
})

Tab:Toggle({
    Title = "Anti AFK",
    Callback = function(v)
        print("Anti AFK:", v)
    end,
})
