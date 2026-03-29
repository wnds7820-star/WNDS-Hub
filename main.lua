-- // WNDS HUB v6.6 - MASTER BOOTSTRAPPER
-- // Developed by Raize 
-- // Logic: Anti-Crash, Auto-Identify, Instant Load

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- // --- 1. SAFE EXECUTOR IDENTIFIER ---
-- Fungsi ini mencegah error 'attempt to call a nil value'
local function GetExecutor()
    local name = "Unknown Executor"
    local version = ""
    
    if identifyexecutor then 
        local success, result, ver = pcall(identifyexecutor)
        if success then name = result; version = ver or "" end
    elseif getexecutorname then
        local success, result = pcall(getexecutorname)
        if success then name = result end
    else
        name = "Delta/Mobile" -- Cadangan jika fungsi API tidak ada
    end
    return name, version
end

local execName, execVer = GetExecutor()
local playerName = LocalPlayer.DisplayName or LocalPlayer.Name

-- // --- 2. UI LIBRARY INITIALIZATION ---
local WindUI = loadstring(game:HttpGet("https://tree-hub.vercel.app/api/UI/WindUI"))()

local Window = WindUI:CreateWindow({
    Title = "WNDS HUB v6.6",
    SubTitle = "by Raize",
    Icon = "rbxassetid://123456789", -- Ganti dengan ID Asset Icon kamu
    Transparent = true,
    MinimizeKey = Enum.KeyCode.RightControl, -- Untuk PC
    Default = true
})

-- // --- 3. WELCOME NOTIFICATION ---
WindUI:Notify({
    Title = "WNDS Hub",
    Content = "Welcome back, " .. playerName .. "! Running on " .. execName,
    Duration = 5
})

-- // --- 4. MODULE LOADER (TAB SYSTEM) ---
-- Fungsi pembantu agar script lebih rapi saat memanggil tab dari GitHub
local function LoadModule(fileName)
    local baseUrl = "https://raw.githubusercontent.com/wnds7820-star/MyRobloxSC/refs/heads/main/tabs/"
    local success, content = pcall(function()
        return game:HttpGet(baseUrl .. fileName)
    end)
    
    if success and content then
        local func, err = loadstring(content)
        if func then
            -- Jalankan script tab dan kirimkan variabel 'Window' agar bisa dipakai di sana
            getfenv(func).Window = Window 
            getfenv(func).WindUI = WindUI
            pcall(func)
        else
            warn("Error compiling module " .. fileName .. ": " .. tostring(err))
        end
    else
        warn("Failed to load module: " .. fileName)
    end
end

-- // --- 5. INITIALIZING ALL TABS ---
-- Urutan pemanggilan Tab (Pastikan file-file ini ada di GitHub kamu)
LoadModule("tab_home.lua")
LoadModule("tab_player.lua")
LoadModule("tab_combat.lua")
LoadModule("tab_visual.lua")
LoadModule("tab_misc.lua")

-- // --- 6. GLOBAL CLEANUP ---
-- Menjaga agar script tetap berjalan meskipun ada error kecil di background
local function ProtectEnvironment()
    setfpscap(120) -- Opsional: Meningkatkan performa jika executor support
end

pcall(ProtectEnvironment)

print("WNDS HUB v6.6 Loaded for User: " .. LocalPlayer.Name)
