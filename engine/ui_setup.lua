-- // WNDS HUB ENGINE - UI SETUP
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local PlayerName = game.Players.LocalPlayer.DisplayName or game.Players.LocalPlayer.Name

local Window = Fluent:CreateWindow({
    Title = "WNDS HUB v6.0",
    SubTitle = "by " .. PlayerName,
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true, 
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- Bagian ini mengirimkan variabel ke Global agar bisa dipanggil file lain
_G.Window = Window
_G.Fluent = Fluent

return Window, Fluent
