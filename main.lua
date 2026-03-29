-- // WNDS HUB v6.6 - MASTER BOOTSTRAPPER (STABLE FIX)
-- // Developed by Raize 
-- // Fix: HTTP 402 Error & IdentifyExecutor Nil

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- // --- 1. SAFE EXECUTOR IDENTIFIER ---
local function GetExecutor()
    local name = "Delta/Mobile"
    -- Menggunakan pcall agar script tidak mati kalau fungsi tidak ada
    local s, r = pcall(function() return identifyexecutor() end)
    if s then name = r end
    return name
end

local execName = GetExecutor()
local playerName = LocalPlayer.DisplayName or LocalPlayer.Name

-- // --- 2. UI LIBRARY INITIALIZATION (STABLE LINK) ---
-- Saya ganti linknya ke GitHub raw agar terhindar dari error HTTP 402 Vercel
local success, WindUI = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/Zaphax/WindUI/main/Library.lua"))()
end)

if not success then
    warn("WNDS: Library Gagal di-load! Pastikan internet stabil.")
    return -- Berhenti agar tidak error ke bawah
end

local Window = WindUI:CreateWindow({
    Title = "WNDS HUB v6.6",
    SubTitle = "by Raize",
    Icon = "rbxassetid://123456789", 
    Transparent = true,
    Default = true
})

-- // --- 3. WELCOME NOTIFICATION ---
WindUI:Notify({
    Title = "WNDS Hub",
    Content = "Welcome back, " .. playerName .. "! Executor: " .. execName,
    Duration = 4
})

-- // --- 4. MODULE LOADER (TAB SYSTEM) ---
local function LoadModule(fileName)
    local baseUrl = "https://raw.githubusercontent.com/wnds7820-star/MyRobloxSC/refs/heads/main/tabs/"
    local s, content = pcall(function() return game:HttpGet(baseUrl .. fileName) end)
    
    if s and content then
        local func, err = loadstring(content)
        if func then
            -- Kirim Window ke module agar Tab muncul di menu yang sama
            getfenv(func).Window = Window 
            getfenv(func).WindUI = WindUI
            pcall(func)
        end
    end
end

-- // --- 5. INITIALIZING ALL TABS ---
-- Pastikan urutan ini benar di GitHub kamu
LoadModule("tab_home.lua")
LoadModule("tab_player.lua")
LoadModule("tab_combat.lua")
LoadModule("tab_visual.lua")

print("WNDS HUB v6.6 Sukses Dimuat!")
