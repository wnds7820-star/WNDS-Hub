-- // WNDS HUB v6.7 - STABLE MASTER LOAD
-- // Author: Raize
-- // No More Red Text! Anti-HTTP 402 Fix

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local playerName = LocalPlayer.DisplayName or LocalPlayer.Name

-- // --- SAFE API CHECKER ---
local function GetExecutor()
    local name = "Mobile Executor"
    local s, r = pcall(function() return identifyexecutor() end)
    if s and r then name = r end
    return name
end

-- // --- STABLE LIBRARY LOAD (GITHUB ONLY) ---
-- Kita pakai link Github Raw agar terhindar dari limit Vercel (Error 402)
local success, WindUI = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/Zaphax/WindUI/main/Library.lua"))()
end)

if not success or not WindUI then 
    warn("WNDS ERROR: Library Gagal Di-load! Cek Internet/Link.")
    return 
end

-- // --- WINDOW INITIALIZATION ---
local Window = WindUI:CreateWindow({
    Title = "WNDS HUB v6.7",
    SubTitle = "by Raize",
    Icon = "rbxassetid://123456789", 
    Transparent = true,
    Default = true
})

-- // --- INSTANT WELCOME NOTIFY ---
WindUI:Notify({
    Title = "WNDS Hub",
    Content = "Welcome back, " .. playerName .. "! (" .. GetExecutor() .. ")",
    Duration = 5
})

-- // --- MODULE BRIDGE ---
-- Memastikan file Tab di GitHub terpanggil tanpa Error
local function LoadTab(file)
    local url = "https://raw.githubusercontent.com/wnds7820-star/MyRobloxSC/refs/heads/main/tabs/" .. file
    local s, content = pcall(function() return game:HttpGet(url) end)
    if s and content then
        local func, err = loadstring(content)
        if func then
            -- Kirim variabel utama ke file Tab agar terhubung satu menu
            getfenv(func).Window = Window
            getfenv(func).WindUI = WindUI
            pcall(func)
        else
            warn("WNDS Error di file " .. file .. ": " .. tostring(err))
        end
    else
        warn("WNDS Gagal mengambil file: " .. file)
    end
end

-- // --- CALLING ALL TABS ---
LoadTab("tab_player.lua")
LoadTab("tab_combat.lua")
LoadTab("tab_visual.lua")

print("WNDS HUB v6.7: LOADED SUCCESSFULLY")
