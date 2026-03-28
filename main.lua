-- // WNDS HUB v5.4 - WIND UI EDITION
-- // Developer: Raize (WNDS)

local WindUI = loadstring(game:HttpGet("https://treehouse.overdrive.id/WindUI/main.lua"))()
local Window = WindUI:CreateWindow({
    Title = "WNDS Hub v5.4",
    Icon = "rbxassetid://10723343321", -- Icon Gear/Settings
    Author = "by Raize",
    Folder = "WNDS_Configs" -- Tempat simpan config otomatis
})

-- // NOTIFICATION
WindUI:Notify({
    Title = "WNDS Hub Loaded",
    Content = "Welcome back, " .. game.Players.LocalPlayer.DisplayName .. "!",
    Duration = 5
})

-- // --- TAB: INFO ---
local TabInfo = Window:AddTab({ Title = "Info", Icon = "info" })

TabInfo:AddParagraph({
    Title = "User Dashboard",
    Desc = "Status: Premium User\nDevice: " .. (game:GetService("UserInputService").TouchEnabled and "Mobile" or "PC")
})

TabInfo:AddButton({
    Title = "Join Discord",
    Desc = "Copy Discord link to clipboard",
    Callback = function()
        setclipboard("https://discord.gg/wndshub")
    end
})

-- // --- TAB: COMBAT ---
local TabCombat = Window:AddTab({ Title = "Combat", Icon = "sword" })

TabCombat:AddToggle({
    Title = "Silent Aim",
    Desc = "Automatically targets closest player",
    Default = false,
    Callback = function(v) _G.SilentAim = v end
})

TabCombat:AddSlider({
    Title = "Aimbot FOV",
    Min = 50, Max = 800, Default = 100,
    Callback = function(v) _G.FOV = v end
})

local combatFeatures = {"No Recoil", "No Spread", "Infinite Ammo", "Kill Aura", "Hitbox Expander"}
for _, name in pairs(combatFeatures) do
    TabCombat:AddToggle({ Title = name, Default = false, Callback = function(s) print(name .. ": " .. tostring(s)) end })
end

-- // --- TAB: PLAYER ---
local TabPlayer = Window:AddTab({ Title = "Player", Icon = "user" })

TabPlayer:AddSlider({
    Title = "WalkSpeed",
    Min = 16, Max = 500, Default = 16,
    Callback = function(v) game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v end
})

TabPlayer:AddSlider({
    Title = "JumpPower",
    Min = 50, Max = 500, Default = 50,
    Callback = function(v) game.Players.LocalPlayer.Character.Humanoid.JumpPower = v end
})

local playerMods = {"Infinite Jump", "Fly Mode", "Noclip", "God Mode", "Anti-Fling", "Spin Bot"}
for _, name in pairs(playerMods) do
    TabPlayer:AddToggle({ Title = name, Default = false, Callback = function(s) print(name .. ": " .. tostring(s)) end })
end

-- // --- TAB: VISUALS ---
local TabVisual = Window:AddTab({ Title = "Visuals", Icon = "eye" })

TabVisual:AddToggle({
    Title = "Player ESP",
    Default = false,
    Callback = function(v) _G.ESP = v end
})

TabVisual:AddToggle({
    Title = "Chams (Wallhack)",
    Default = false,
    Callback = function(v) _G.Chams = v end
})

TabVisual:AddToggle({
    Title = "Full Bright",
    Default = false,
    Callback = function(v) game.Lighting.Brightness = v and 2 or 1 end
})

-- // --- TAB: SETTINGS ---
local TabSettings = Window:AddTab({ Title = "Settings", Icon = "settings" })

TabSettings:AddButton({
    Title = "Reload Script",
    Callback = function()
        Window:Close()
        task.wait(0.5)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/main.lua"))()
    end
})

TabSettings:AddToggle({
    Title = "Anti-AFK",
    Default = true,
    Callback = function(v) print("Anti-AFK: " .. tostring(v)) end
})

-- // KEYBIND UNTUK BUKA/TUTUP (PC)
Window:SetKeybind(Enum.KeyCode.RightControl)

-- // FLOATING BUTTON (MOBILE)
if game:GetService("UserInputService").TouchEnabled then
    local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
    local Button = Instance.new("ImageButton", ScreenGui)
    local UICorner = Instance.new("UICorner", Button)
    
    Button.Size = UDim2.new(0, 50, 0, 50)
    Button.Position = UDim2.new(0, 10, 0.5, 0)
    Button.Image = "rbxassetid://10723343321" -- Icon Gear
    Button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    UICorner.CornerRadius = UDim.new(0, 15)
    
    Button.MouseButton1Click:Connect(function()
        Window:Toggle()
    end)
end
