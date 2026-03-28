-- // ui_config.lua (VERSI ANTI-ERROR)

-- 1. FUNGSI MENUNGGU LIBRARY (Biar gak NIL lagi)
local function GetLibrary()
    local lib = _G.Fluent or loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
    _G.Fluent = lib
    return lib
end

local Fluent = GetLibrary()

-- 2. DETEKSI PERANGKAT
local UserInputService = game:GetService("UserInputService")
local isMobile = (UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled)
local windowSize = isMobile and UDim2.fromOffset(450, 320) or UDim2.fromOffset(580, 460)

-- 3. BUAT WINDOW (Pastikan Fluent gak nil)
if Fluent then
    local Window = Fluent:CreateWindow({
        Title = "WNDS Hub v5.4",
        SubTitle = "by Raize",
        TabWidth = isMobile and 125 or 160,
        Size = windowSize,
        Acrylic = true, 
        Theme = "Dark",
        MinimizeKey = Enum.KeyCode.RightControl 
    })

    -- 4. DEFINISIKAN TAB
    local Tabs = {
        Info = Window:AddTab({ Title = "Info", Icon = "info" }),
        Combat = Window:AddTab({ Title = "Combat", Icon = "sword" }),
        Player = Window:AddTab({ Title = "Player", Icon = "user" }),
        Visuals = Window:AddTab({ Title = "Visuals", Icon = "eye" }),
        Teleport = Window:AddTab({ Title = "Teleport", Icon = "map" }),
        Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
    }

    -- Daftarkan ke Global agar file lain (tab_combat dll) bisa baca
    _G.WNDS_UI = { Window = Window, Tabs = Tabs }

    -- 5. FUNGSI SAFELOAD MODULES
    local function SafeLoad(url)
        local success, result = pcall(function()
            return loadstring(game:HttpGet(url))()
        end)
        if not success then warn("Gagal Load: " .. url) end
    end

    -- Panggil semua tab (Pastikan link RAW sudah benar)
    SafeLoad("https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/tab_info.lua")
    SafeLoad("https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/tab_combat.lua")
    SafeLoad("https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/tab_player.lua")
    SafeLoad("https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/tab_visuals.lua")
    SafeLoad("https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/tab_teleport.lua")
    SafeLoad("https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/tab_settings.lua")

    -- 6. FLOATING BUTTON KHUSUS MOBILE
    if UserInputService.TouchEnabled then
        local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
        local Button = Instance.new("TextButton", ScreenGui)
        local UICorner = Instance.new("UICorner", Button)
        ScreenGui.ResetOnSpawn = false
        Button.Size, Button.Position = UDim2.new(0, 50, 0, 50), UDim2.new(0.1, 0, 0.15, 0)
        Button.BackgroundColor3, Button.Text = Color3.fromRGB(120, 117, 242), "W"
        Button.TextColor3, Button.Draggable = Color3.new(1,1,1), true
        UICorner.CornerRadius = UDim.new(0, 15)
        Button.MouseButton1Click:Connect(function()
            game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.RightControl, false, game)
            task.wait(0.05)
            game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.RightControl, false, game)
        end)
    end
else
    warn("Gagal memuat Library Fluent!")
end
