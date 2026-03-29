--[[
    WNDS HUB PREMIUM [STABLE]
    Developer: Raize
    Description: Main UI Logic with Error Interceptor System
]]

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()

-- // 1. ERROR INTERCEPTOR SYSTEM (Fungsi Baru)
-- Menangkap error dan menampilkannya sebagai Notifikasi UI daripada teks merah di konsol
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

-- // 2. ENHANCED MODULE LOADER (Dengan Interceptor)
local function LoadModule(fileName)
    local url = "https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/tabs/" .. fileName
    
    -- Ambil Content dari GitHub
    local success, content = pcall(function() return game:HttpGet(url) end)
    
    if success then
        local func, err = loadstring(content)
        if func then 
            -- Jalankan fungsi modul dengan pcall untuk menangkap runtime error
            local moduleSuccess, moduleError = pcall(func)
            if not moduleSuccess then
                -- Muncul Notif jika script di dalam file tab ada yang salah
                SafeNotify("Module Error", "Failed to run " .. fileName .. ": " .. tostring(moduleError):sub(1, 40) .. "...")
                warn("[WNDS DEBUG] Runtime error in " .. fileName .. ": " .. tostring(moduleError))
            end
        else 
            -- Muncul Notif jika ada salah ketik (syntax error) di file tab
            SafeNotify("Syntax Error", "Coding error in " .. fileName)
            warn("[WNDS DEBUG] Syntax error in " .. fileName .. ": " .. tostring(err)) 
        end
    else
        -- Muncul Notif jika link GitHub mati atau salah nama file
        SafeNotify("Connection Error", "Could not fetch " .. fileName .. " from GitHub.")
        warn("[WNDS DEBUG] Failed to fetch module: " .. fileName)
    end
end

-- // LOADING ALL TABS IN ORDER
LoadModule("tab_home.lua")
LoadModule("tab_player.lua")
LoadModule("tab_combat.lua")
LoadModule("tab_visual.lua")
LoadModule("tab_world.lua")    
LoadModule("tab_misc.lua")     
LoadModule("tab_updates.lua")  
LoadModule("tab_settings.lua") 

-- Menghubungkan ke Tab pertama (Home) saat startup
Window:SelectTab(1)

-- Notifikasi Sukses Startup
Fluent:Notify({
    Title = "WNDS Hub",
    Content = "Premium Successfully Loaded!",
    SubTitle = "Welcome, " .. game.Players.LocalPlayer.Name,
    Duration = 5
})

-- Log ke Console untuk Developer
print("[WNDS HUB] Core system v2.0.0 initialized by Raize.")
