local Fluent = _G.Fluent
local UserInputService = game:GetService("UserInputService")
local isMobile = (UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled)

-- // 1. BUAT WINDOW
local Window = Fluent:CreateWindow({
    Title = "WNDS Hub v5.4",
    SubTitle = "by Raize",
    TabWidth = isMobile and 125 or 160,
    Size = isMobile and UDim2.fromOffset(450, 320) or UDim2.fromOffset(580, 460),
    Acrylic = true, 
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.RightControl 
})

-- // 2. DEFINISIKAN SEMUA TAB
local Tabs = {
    Info = Window:AddTab({ Title = "Info", Icon = "info" }),
    Combat = Window:AddTab({ Title = "Combat", Icon = "sword" }),
    Player = Window:AddTab({ Title = "Player", Icon = "user" }),
    Visuals = Window:AddTab({ Title = "Visuals", Icon = "eye" }),
    Teleport = Window:AddTab({ Title = "Teleport", Icon = "map" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

-- Simpan ke Global agar file tab_... bisa baca 'Tabs'
_G.WNDS_UI = { Window = Window, Tabs = Tabs }

-- // 3. FUNGSI AMAN UNTUK PANGGIL FILE (SafeLoad)
local function SafeLoad(url)
    local success, result = pcall(function()
        return loadstring(game:HttpGet(url))()
    end)
    if not success then warn("WNDS Gagal Load: " .. url) end
end

-- // 4. TEMPAT PANGGIL SEMUA ISI TAB (SUDAH SAYA RAPIKAN)
-- Info dipanggil pertama supaya langsung muncul pas script dibuka
SafeLoad("https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/tab_info.lua") 

-- Sisanya dipanggil berurutan
SafeLoad("https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/tab_info.lua") 
SafeLoad("https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/tab_combat.lua")
SafeLoad("https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/tab_visuals.lua")
SafeLoad("https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/tab_player.lua")
SafeLoad("https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/tab_teleport.lua")
SafeLoad("https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/tab_settings.lua")

-- // 5. TOMBOL MOBILE (Floating Button)
if UserInputService.TouchEnabled then
    local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
    local Button = Instance.new("TextButton", ScreenGui)
    local UICorner = Instance.new("UICorner", Button)
    ScreenGui.Name = "WNDSToggle"
    ScreenGui.ResetOnSpawn = false
    Button.Size = UDim2.new(0, 50, 0, 50)
    Button.Position = UDim2.new(0, 10, 0.5, 0)
    Button.BackgroundColor3 = Color3.fromRGB(120, 117, 242)
    Button.Text = "W"
    Button.TextColor3 = Color3.new(1,1,1)
    Button.Draggable = true
    UICorner.CornerRadius = UDim.new(0, 15)
    Button.MouseButton1Click:Connect(function()
        game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.RightControl, false, game)
        task.wait(0.05)
        game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.RightControl, false, game)
    end)
end
