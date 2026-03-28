local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
local Window = WindUI:CreateWindow({
    Title = "WNDS Hub",
    Icon = "solar:ghost-bold",
    OpenButton = { Enabled = true, Draggable = true }
})

local Tabs = {
    Info = Window:Tab({ Title = "Info", Icon = "solar:info-square-bold" }),
    Combat = Window:Tab({ Title = "Combat", Icon = "solar:target-bold" }),
    Visuals = Window:Tab({ Title = "Visuals", Icon = "solar:eye-bold" }),
    Player = Window:Tab({ Title = "Player", Icon = "solar:user-bold" }),
    Teleport = Window:Tab({ Title = "Teleport", Icon = "solar:map-arrow-bold" }),
    Settings = Window:Tab({ Title = "Settings", Icon = "solar:settings-bold" })
}

-- Isi Tab Info
Tabs.Info:Section({ Title = "User Info" })
Tabs.Info:Paragraph({
    Title = "Welcome, " .. game.Players.LocalPlayer.DisplayName,
    Desc = "Executor: " .. _G.WNDS_Data.Executor .. "\nPlatform: " .. _G.WNDS_Data.Platform .. "\nRegion: " .. _G.WNDS_Data.Region
})

Tabs.Info:Button({
    Title = "Server Hop",
    Callback = function() loadstring(game:HttpGet('https://raw.githubusercontent.com/Cesare0328/my-scripts/refs/heads/main/CachedServerhop.lua'))() end
})

return {Window = Window, Tabs = Tabs, WindUI = WindUI}
