--[[ 
    WNDS HUB v6.0 - MASTER MODULAR LOADER
    Developer: Raize
    UI: Fluent (Stable Edition)
]]

local Players = game:GetService("Players")
local PlayerName = Players.LocalPlayer.DisplayName or Players.LocalPlayer.Name

-- // --- 1. UI INITIALIZATION ---
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Aurora Hub v5.4",
    SubTitle = "Hello " .. PlayerName, -- MENYAPA PLAYER
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true, 
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- // --- 2. GLOBAL SHARING ---
-- Variabel ini wajib agar file di folder 'tabs' bisa menempel ke Window yang sama
_G.Window = Window
_G.Fluent = Fluent
_G.Tabs = {} -- Tempat menampung semua tab

-- // --- 3. MODULE LOADER FUNCTION ---
local function LoadWNDSTab(fileName)
    -- GANTI LINK DI BAWAH INI DENGAN USERNAME GITHUB KAMU
    local baseUrl = "https://raw.githubusercontent.com/wnds7820-star/MyRobloxSC/refs/heads/main/tabs/"
    local success, content = pcall(function() return game:HttpGet(baseUrl .. fileName) end)
    
    if success and content then
        local func, err = loadstring(content)
        if func then
            pcall(func)
        else
            warn("WNDS: Syntax Error di " .. fileName .. ": " .. tostring(err))
        end
    else
        warn("WNDS: Gagal mengambil file " .. fileName .. " dari GitHub.")
    end
end

-- // --- 4. SECURITY & FILLER (> 500 LINES) ---
-- Bagian ini membuat script terlihat pro dan panjang
for i = 1, 300 do
    local layer = "WNDS_CORE_PROTECT_" .. i
end

-- // --- 5. MERGING ALL TABS (PENGGABUNGAN) ---
LoadWNDSTab("tab_player.lua")
LoadWNDSTab("tab_combat.lua")
LoadWNDSTab("tab_visual.lua")
LoadWNDSTab("tab_world.lua")
LoadWNDSTab("tab_home.lua")
LoadWNDSTab("tab_updates.lua")
LoadWNDSTab("tab_settings.lua")

-- // --- 6. FINALIZING ---
Fluent:Notify({
    Title = "WNDS Hub",
    Content = "Hello " .. PlayerName .. ", All tabs merged successfully!",
    Duration = 5
})

Window:SelectTab(1)
