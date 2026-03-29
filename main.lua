--[[
    WNDS HUB PREMIUM v6.5
    Developer: Raize
]]
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "WNDS HUB v6.5",
    SubTitle = "Hello " .. game.Players.LocalPlayer.DisplayName,
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- Global Variable agar bisa diakses oleh file tab eksternal
_G.WNDS_Window = Window
_G.WNDS_Fluent = Fluent

local function LoadModule(fileName)
    local url = "https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/tabs/" .. fileName
    local success, content = pcall(function() return game:HttpGet(url) end)
    if success then
        local func, err = loadstring(content)
        if func then 
            pcall(func) 
        else 
            warn("Error loading " .. fileName .. ": " .. err) 
        end
    else
        warn("Failed to fetch " .. fileName)
    end
end

-- Memanggil semua tab secara berurutan (Termasuk file baru yang kamu minta)
LoadModule("tab_home.lua")
LoadModule("tab_player.lua")
LoadModule("tab_combat.lua")
LoadModule("tab_visual.lua")
LoadModule("tab_world.lua")    -- Baru
LoadModule("tab_misc.lua")
LoadModule("tab_updates.lua")  -- Baru
LoadModule("tab_settings.lua") -- Baru

Window:SelectTab(1)

Fluent:Notify({
    Title = "WNDS Hub",
    Content = "Premium v6.5 Berhasil Dimuat!",
    Duration = 5
})
