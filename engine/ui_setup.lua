-- // WNDS HUB v6.0 - UI ENGINE SETUP
-- // Powered by Fluent UI (Glassmorphism)

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerName = LocalPlayer.DisplayName or LocalPlayer.Name

-- // --- CREATE MAIN WINDOW ---
local Window = Fluent:CreateWindow({
    Title = "Aurora Hub v5.4",
    SubTitle = "by " .. PlayerName, -- OTOMATIS KE PLAYER YANG RUN
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true, 
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- // --- EXPORT TO GLOBAL ---
-- Kita simpan ke _G agar file di folder 'tabs' bisa memanggil Window ini
_G.Window = Window
_G.Fluent = Fluent
_G.SaveManager = SaveManager
_G.InterfaceManager = InterfaceManager

-- // --- INITIAL NOTIFICATION ---
Fluent:Notify({
    Title = "Aurora Hub",
    Content = "UI Engine Initialized for " .. PlayerName,
    Duration = 3
})

return Window, Fluent
