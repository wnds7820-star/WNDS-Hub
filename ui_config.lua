-- // ui_config.lua
local Fluent = _G.Fluent

-- Cek apakah Library sudah ke-load
if not Fluent then
    warn("WNDS Hub: Fluent Library not found in Global!")
    return
end

local UserInputService = game:GetService("UserInputService")
local isMobile = (UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled)
local windowSize = isMobile and UDim2.fromOffset(450, 320) or UDim2.fromOffset(580, 460)

-- // 1. BUAT WINDOW
local Window = Fluent:CreateWindow({
    Title = "WNDS Hub v5.4",
    SubTitle = "by Raize",
    TabWidth = isMobile and 125 or 160,
    Size = windowSize,
    Acrylic = true, 
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.RightControl 
})

-- // 2. DEFINISIKAN TAB
local Tabs = {
    Info = Window:AddTab({ Title = "Info", Icon = "info" }),
    Combat = Window:AddTab({ Title = "Combat", Icon = "sword" }),
    Player = Window:AddTab({ Title = "Player", Icon = "user" }),
    Visuals = Window:AddTab({ Title = "Visuals", Icon = "eye" }),
    Teleport = Window:AddTab({ Title = "Teleport", Icon = "map" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

-- Simpan ke Global agar module lain (tab_combat dll) bisa baca
_G.WNDS_UI = {
    Window = Window,
    Tabs = Tabs
}

-- // 3. FUNGSI SAFELOAD
local function SafeLoad(url)
    local success, result = pcall(function()
        return loadstring(game:HttpGet(url))()
    end)
    if not success then
        warn("WNDS Error: " .. url .. " | " .. tostring(result))
    end
end

-- // 4. PANGGIL MODULES (Pastikan Link RAW!)
SafeLoad("https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/tab_info.lua")
SafeLoad("https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/tab_combat.lua")
SafeLoad("https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/tab_player.lua")
SafeLoad("https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/tab_visuals.lua")
SafeLoad("https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/tab_teleport.lua")
SafeLoad("https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/tab_settings.lua")

-- // 5. FLOATING BUTTON UNTUK MOBILE
if UserInputService.TouchEnabled then
    local VirtualInputManager = game:GetService("VirtualInputManager")
    local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
    local Button = Instance.new("TextButton", ScreenGui)
    local UICorner = Instance.new("UICorner", Button)

    ScreenGui.Name = "WNDS_MobileToggle"
    ScreenGui.ResetOnSpawn = false

    Button.Size = UDim2.new(0, 50, 0, 50)
    Button.Position = UDim2.new(0.1, 0, 0.15, 0)
    Button.BackgroundColor3 = Color3.fromRGB(120, 117, 242)
    Button.Text = "W"
    Button.TextColor3 = Color3.new(1,1,1)
    Button.Draggable = true

    UICorner.CornerRadius = UDim.new(0, 15)

    Button.MouseButton1Click:Connect(function()
        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.RightControl, false, game)
        task.wait(0.05)
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.RightControl, false, game)
    end)
end
