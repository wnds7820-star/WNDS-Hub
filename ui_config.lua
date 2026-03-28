local Fluent = _G.Fluent -- Mengambil library dari main.lua

-- // 1. DETEKSI PERANGKAT (BIAR GAK KEBESARAN DI HP)
local UserInputService = game:GetService("UserInputService")
local isMobile = (UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled)
local windowSize = isMobile and UDim2.fromOffset(450, 320) or UDim2.fromOffset(580, 460)

-- // 2. BUAT WINDOW
local Window = Fluent:CreateWindow({
    Title = "WNDS Hub v5.4",
    SubTitle = "by Raize",
    TabWidth = isMobile and 125 or 160,
    Size = windowSize,
    Acrylic = true, 
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.RightControl 
})

-- // 3. DEFINISIKAN TAB (Penting: Harus urut!)
local Tabs = {
    Info = Window:AddTab({ Title = "Info", Icon = "info" }),
    Combat = Window:AddTab({ Title = "Combat", Icon = "sword" }),
    Player = Window:AddTab({ Title = "Player", Icon = "user" }),
    Visuals = Window:AddTab({ Title = "Visuals", Icon = "eye" }),
    Teleport = Window:AddTab({ Title = "Teleport", Icon = "map" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

-- // 4. DAFTARKAN KE GLOBAL (Biar file tab_combat dll bisa baca 'Tabs')
_G.WNDS_UI = {
    Window = Window,
    Tabs = Tabs
}

-- // 5. PANGGIL SEMUA MODULE (SafeLoad)
local function SafeLoad(url)
    local success, result = pcall(function()
        return loadstring(game:HttpGet(url))()
    end)
    if not success then
        warn("WNDS Error Loading: " .. url .. " | Error: " .. tostring(result))
    end
end

-- Panggil satu-satu sesuai file di GitHub kamu
SafeLoad("https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/tab_info.lua")
SafeLoad("https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/tab_combat.lua")
SafeLoad("https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/tab_player.lua")
SafeLoad("https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/tab_visuals.lua")
SafeLoad("https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/tab_teleport.lua")
SafeLoad("https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/tab_settings.lua")

-- // 6. FLOATING BUTTON (Hanya untuk Mobile)
-- (Paste kode Floating Button yang kemarin di sini jika ingin ada tombol "W")
