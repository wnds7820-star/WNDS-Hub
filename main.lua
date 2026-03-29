--[[
    WNDS HUB PREMIUM [STABLE]
    Developer: Raize
    Description: Fixed Debugging Version with Auto-Clear UI
]]

-- // 1. AUTO-CLEAR UI LAMA (Biar Tab Lama Gak Nyangkut)
if _G.WNDS_Window then
    pcall(function() _G.WNDS_Window:Destroy() end)
    _G.WNDS_Window = nil
end

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()

-- // 2. ERROR INTERCEPTOR SYSTEM
local function SafeNotify(title, content, duration)
    Fluent:Notify({
        Title = title or "WNDS System Alert",
        Content = content or "An unexpected error occurred.",
        Duration = duration or 5
    })
end

local Window = Fluent:CreateWindow({
    Title = "WNDS HUB",
    SubTitle = "Hello " .. game.Players.LocalPlayer.DisplayName,
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- Global Variables
_G.WNDS_Window = Window
_G.WNDS_Fluent = Fluent
_G.WNDS_Version = "2.0.0"

-- // 3. ENHANCED MODULE LOADER
local function LoadModule(fileName)
    local url = "https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/tabs/" .. fileName
    local success, content = pcall(function() return game:HttpGet(url) end)
    
    if success then
        local func, err = loadstring(content)
        if func then 
            local moduleSuccess, moduleError = pcall(func)
            if not moduleSuccess then
                SafeNotify("Module Error", "Failed to run " .. fileName)
                warn("[WNDS DEBUG] Runtime error in " .. fileName .. ": " .. tostring(moduleError))
            end
        else 
            SafeNotify("Syntax Error", "Coding error in " .. fileName)
            warn("[WNDS DEBUG] Syntax error in " .. fileName .. ": " .. tostring(err)) 
        end
    else
        SafeNotify("Connection Error", "Could not fetch " .. fileName)
    end
end

-- // 4. DEBUG MODE: NYALAKAN SATU PER SATU DI SINI
-- Hapus tanda -- di depan baris yang ingin kamu tes
LoadModule("tab_home.lua")
LoadModule("tab_player.lua")
LoadModule("tab_combat.lua")
LoadModule("tab_visual.lua")
-- LoadModule("tab_world.lua") 
-- LoadModule("tab_misc.lua")
-- LoadModule("tab_updates.lua")
-- LoadModule("tab_settings.lua") -- FIX: Kurung tutup ganda sudah dihapus

-- Menghubungkan ke Tab pertama (Home) saat startup
Window:SelectTab(1)

-- Notifikasi Sukses
Fluent:Notify({
    Title = "WNDS Hub",
    Content = "Debug Mode Active - Modules Filtered",
    Duration = 3
})

print("[WNDS HUB] Core system initialized. Old UI Cleared.")
