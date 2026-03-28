local Fluent = _G.Fluent
local UserInputService = game:GetService("UserInputService")
local isMobile = (UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled)

-- // 1. BUAT WINDOW (OTOMATIS SESUAI DEVICE)
local Window = Fluent:CreateWindow({
    Title = "WNDS Hub v5.4",
    SubTitle = "by Raize",
    TabWidth = isMobile and 125 or 160,
    Size = isMobile and UDim2.fromOffset(450, 320) or UDim2.fromOffset(580, 460),
    Acrylic = true, 
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.RightControl 
})

-- // 2. BUAT TAB
local Tabs = {
    Info = Window:AddTab({ Title = "Info", Icon = "info" }),
    Combat = Window:AddTab({ Title = "Combat", Icon = "sword" }),
    Player = Window:AddTab({ Title = "Player", Icon = "user" }),
    Visuals = Window:AddTab({ Title = "Visuals", Icon = "eye" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

-- // 3. ISI FITUR (LENGKAP 10+ PER TAB)

-- --- TAB INFO ---
Tabs.Info:Section({ Title = "User Dashboard" })
Tabs.Info:Paragraph({
    Title = "Welcome, " .. (_G.WNDS_Data and _G.WNDS_Data.DisplayName or game.Players.LocalPlayer.DisplayName),
    Desc = "Status: Premium User\nPlatform: " .. (isMobile and "Mobile" or "PC"),
    Image = _G.WNDS_Data and _G.WNDS_Data.Avatar or "rbxassetid://0",
    ImageSize = 64
})

-- --- TAB COMBAT (10 FITUR) ---
Tabs.Combat:Section({ Title = "Combat Exploits" })
local combat = {"Aimbot", "Silent Aim", "Wallbang", "Auto Clicker", "No Recoil", "No Spread", "Infinite Ammo", "Hitbox Expander", "Kill Aura", "Fast Reload"}
for _, v in pairs(combat) do
    Tabs.Combat:Toggle({ Title = v, Default = false, Callback = function(t) print(v .. ": " .. tostring(t)) end })
end

-- --- TAB PLAYER (10 FITUR) ---
Tabs.Player:Section({ Title = "Movement" })
Tabs.Player:Slider({ Title = "WalkSpeed", Min = 16, Max = 500, Default = 16, Callback = function(v) game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v end })
Tabs.Player:Slider({ Title = "JumpPower", Min = 50, Max = 500, Default = 50, Callback = function(v) game.Players.LocalPlayer.Character.Humanoid.JumpPower = v end })
local plyr = {"Infinite Jump", "Fly Mode", "No Clip", "God Mode", "Anti-Fling", "Spin Bot", "Invisibility", "Swim in Air"}
for _, v in pairs(plyr) do
    Tabs.Player:Toggle({ Title = v, Default = false, Callback = function(t) print(v .. ": " .. tostring(t)) end })
end

-- --- TAB VISUALS (10 FITUR) ---
Tabs.Visuals:Section({ Title = "ESP & World" })
local vis = {"Player ESP", "Box ESP", "Tracer ESP", "Name ESP", "Skeleton ESP", "Full Bright", "No Fog", "Wallhack", "Chams", "Bullet Tracers"}
for _, v in pairs(vis) do
    Tabs.Visuals:Toggle({ Title = v, Default = false, Callback = function(t) print(v .. ": " .. tostring(t)) end })
end

-- --- TAB SETTINGS (10 FITUR) ---
Tabs.Settings:Section({ Title = "System" })
Tabs.Settings:Button({ Title = "Reload Script", Callback = function() Window:Destroy() task.wait(0.5) loadstring(game:HttpGet("https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/main.lua"))() end })
Tabs.Settings:Button({ Title = "Destroy UI", Callback = function() Window:Destroy() end })
local sett = {"Anti-AFK", "Auto Rejoin", "Server Hop", "Low Graphics", "Rejoin Server", "Hide UI", "Show FPS", "Show Ping"}
for _, v in pairs(sett) do
    Tabs.Settings:Toggle({ Title = v, Default = false, Callback = function(t) print(v .. ": " .. tostring(t)) end })
end

-- // 4. TOMBOL MOBILE (HANYA MUNCUL DI HP)
if UserInputService.TouchEnabled then
    local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
    local Button = Instance.new("TextButton", ScreenGui)
    local UICorner = Instance.new("UICorner", Button)
    ScreenGui.Name = "WNDSToggle"; ScreenGui.ResetOnSpawn = false
    Button.Size, Button.Position = UDim2.new(0, 50, 0, 50), UDim2.new(0, 10, 0.5, 0)
    Button.BackgroundColor3, Button.Text = Color3.fromRGB(120, 117, 242), "W"
    Button.TextColor3, Button.Draggable = Color3.new(1,1,1), true
    UICorner.CornerRadius = UDim.new(0, 15)
    Button.MouseButton1Click:Connect(function()
        game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.RightControl, false, game)
        task.wait(0.05)
        game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.RightControl, false, game)
    end)
end

Fluent:Notify({ Title = "WNDS Hub", Content = "Semua fitur berhasil dimuat!", Duration = 5 })
