--[[
    WNDS HUB PREMIUM v2.0.0
    Developer: Raize
    Description: Main UI Logic for the new v2.0 Framework
]]

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "WNDS HUB v2.0.0", -- Versi Baru sesuai alur 1.0 -> 2.0
    SubTitle = "Hello " .. game.Players.LocalPlayer.DisplayName,
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- Global Variables agar file di folder /tabs/ bisa mengenali Window ini
_G.WNDS_Window = Window
_G.WNDS_Fluent = Fluent
_G.WNDS_Version = "2.0.0"

local function LoadModule(fileName)
    local url = "https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/tabs/" .. fileName
    local success, content = pcall(function() return game:HttpGet(url) end)
    
    if success then
        local func, err = loadstring(content)
        if func then 
            local moduleSuccess, moduleError = pcall(func)
            if not moduleSuccess then
                warn("Runtime error in " .. fileName .. ": " .. tostring(moduleError))
            end
        else 
            warn("Syntax error in " .. fileName .. ": " .. tostring(err)) 
        end
    else
        warn("Failed to fetch module from GitHub: " .. fileName)
    end
end

-- // LOADING ALL TABS IN ORDER
LoadModule("tab_home.lua")
LoadModule("tab_player.lua")
LoadModule("tab_combat.lua")
LoadModule("tab_visual.lua")
LoadModule("tab_world.lua")    -- New: FPS Booster & Lighting
LoadModule("tab_misc.lua")     -- New: Anti-AFK & Server Tools
LoadModule("tab_updates.lua")  -- New: Version History 1.0 to 2.0
LoadModule("tab_settings.lua") -- New: Config System

-- Menghubungkan ke Tab pertama (Home) saat startup
Window:SelectTab(1)

-- Notifikasi Sukses dengan Versi Baru
Fluent:Notify({
    Title = "WNDS Hub",
    Content = "Premium v2.0.0 Successfully Loaded!",
    Duration = 5
})

-- Log ke Console untuk Developer
print("[WNDS HUB] Core system v2.0.0 initialized by Raize.")
