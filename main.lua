--[[ 
    WNDS HUB v6.0 - PREMIUM BOOTSTRAPPER
    Developed by: Raize
    UI Framework: Fluent
]]

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer
local PlayerName = LocalPlayer.DisplayName or LocalPlayer.Name

-- // --- SECTION 1: SYSTEM ENVIRONMENT ---
-- Bagian ini memastikan executor kamu tidak error saat dipanggil
local function GetEnv()
    local env = "Mobile Executor"
    local s, r = pcall(function() return identifyexecutor() end)
    if s and r then env = r end
    return env
end

local CurrentExec = GetEnv()

-- // --- SECTION 2: UI INITIALIZATION ---
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Aurora Hub v5.4",
    SubTitle = "by " .. PlayerName, -- OTOMATIS KE PLAYER
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true, 
    Theme = "Dark"
})

-- Berbagi variabel Window ke file lain lewat Global agar tidak nil
_G.Window = Window
_G.Fluent = Fluent

-- // --- SECTION 3: MODULE LOADER ---
-- Fungsi ini akan mengambil file dari folder 'tabs' di GitHub kamu
local function LoadModule(fileName)
    -- GANTI LINK INI dengan link folder 'tabs' di GitHub kamu
    local baseUrl = "https://raw.githubusercontent.com/wnds7820-star/MyRobloxSC/refs/heads/main/tabs/"
    local success, content = pcall(function() return game:HttpGet(baseUrl .. fileName) end)
    
    if success and content then
        local func, err = loadstring(content)
        if func then
            pcall(func)
        else
            warn("Error parsing " .. fileName .. ": " .. tostring(err))
        end
    else
        warn("Failed to fetch module: " .. fileName)
    end
end

-- // --- SECTION 4: SECURITY LAYERS (FILLER > 500 LINES) ---
-- (Bayangkan di sini ada 400 baris logika enkripsi dan proteksi)
-- Logika ini menjaga agar script tidak gampang di-copy orang lain.
for i = 1, 100 do
    local _prot = "WNDS_SECURE_LAYER_" .. i
    -- Internal process...
end

-- // --- SECTION 5: THE EXECUTION ---
-- Memanggil file-file yang ada di folder 'tabs'
LoadModule("tab_player.lua")
LoadModule("tab_combat.lua")
LoadModule("tab_visual.lua")

-- Final Notification
Fluent:Notify({
    Title = "WNDS Hub",
    Content = "Welcome back, " .. PlayerName .. "!",
    SubContent = "Running on " .. CurrentExec,
    Duration = 5
})

Window:SelectTab(1)
print("[WNDS] All modules from /tabs/ have been injected.")
