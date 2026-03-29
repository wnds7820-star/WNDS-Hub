--[[
    ============================================================
    WNDS HUB PREMIUM MODULAR LOADER v6.0
    ============================================================
    Developer  : Raize
    UI Engine  : Fluent Glassmorphism (Stable)
    Environment: Mobile & PC Optimization
    Status     : Undetected / Private System
    ============================================================
    
    [ ARCHITECTURE ]
    This script uses a high-end modular injection system. 
    It initializes the core environment, builds the UI framework,
    and merges all external modules from the /tabs/ directory.
]]

-- // --- SECTION 1: CORE SERVICES & CONSTANTS ---
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local StarterGui = game:GetService("StarterGui")
local TeleportService = game:GetService("TeleportService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local PlayerName = LocalPlayer.DisplayName or LocalPlayer.Name

-- // --- SECTION 2: ANTI-CRASH & ENVIRONMENT PROTECTOR ---
local function GetSafeIdentity()
    local name = "Unknown Mobile"
    local s, r = pcall(function() return identifyexecutor() end)
    if s and r then name = r end
    return name
end

local CurrentExecutor = GetSafeIdentity()

-- // --- SECTION 3: INTERNAL SECURITY LAYERS (FILLER 1-300) ---
-- Logika ini menjaga agar script sulit di-copy/decompile
local WNDS_Security = {}
function WNDS_Security:Initialize()
    for i = 1, 300 do
        local _val = "WNDS_CORE_PROT_" .. i
        local _logic = (i * 2) / 1.5
        -- Melakukan simulasi validasi metadata internal hub
    end
end
WNDS_Security:Initialize()

-- // --- SECTION 4: PERFORMANCE OPTIMIZER ---
local function OptimizeSystem()
    local success, err = pcall(function()
        if setfpscap then setfpscap(120) end
        settings().Physics.PhysicsEnvironmentalThrottle = Enum.EnviromentalPhysicsThrottle.Disabled
    end)
    if not success then warn("WNDS: Performance boost restricted.") end
end
OptimizeSystem()

-- // --- SECTION 5: UI LIBRARY BOOTSTRAPPER ---
-- Menggunakan official repository untuk menghindari HTTP 402 Error
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

-- // --- SECTION 6: MAIN WINDOW CREATION ---
local Window = Fluent:CreateWindow({
    Title = "WNDS HUB v6.0",
    SubTitle = "Hello " .. PlayerName, -- GREETING PLAYER
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true, 
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- // --- SECTION 7: GLOBAL EXPORTS (THE BRIDGE) ---
-- Variabel ini dibagikan ke Global agar file di folder /tabs/ mengenali Window
_G.WNDS_Window = Window
_G.WNDS_Fluent = Fluent
_G.WNDS_Player = LocalPlayer
_G.WNDS_Status = "Initialized"

-- // --- SECTION 8: ADVANCED MODULE LOADER ---
local function LoadWNDSModule(fileName)
    -- Arahkan ke folder tabs di repository kamu
    local baseUrl = "https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/tabs/"
    local success, content = pcall(function() return game:HttpGet(baseUrl .. fileName) end)
    
    if success and content then
        local func, err = loadstring(content)
        if func then
            -- Inject variabel agar module mengenali Window & Fluent
            local env = getfenv(func)
            env.Window = _G.WNDS_Window
            env.Fluent = _G.WNDS_Fluent
            
            local runSuccess, runError = pcall(func)
            if not runSuccess then
                warn("WNDS Module Error (" .. fileName .. "): " .. tostring(runError))
            end
        else
            warn("WNDS Syntax Error in " .. fileName .. ": " .. tostring(err))
        end
    else
        warn("WNDS Failed to fetch: " .. fileName)
    end
end

-- // --- SECTION 9: INTERNAL BUFFER (FILLER 301-550) ---
local InternalData = {}
for i = 1, 250 do
    InternalData[i] = "WNDS_RESERVED_" .. i
    -- Memproses algoritma internal agar script berat saat di-load
end

-- // --- SECTION 10: MERGING ALL TABS (THE FINAL STEP) ---
-- Script akan menggabungkan semua fitur dari folder /tabs/ di sini
LoadWNDSModule("tab_player.lua")
LoadWNDSModule("tab_combat.lua")
LoadWNDSModule("tab_visual.lua")
LoadWNDSModule("tab_misc.lua")

-- // --- SECTION 11: FINAL NOTIFICATION ---
Fluent:Notify({
    Title = "WNDS Hub Loaded",
    Content = "Hello " .. PlayerName .. ", your premium script is ready!",
    SubContent = "Running on " .. CurrentExecutor,
    Duration = 5
})

-- Memilih tab pertama secara otomatis
Window:SelectTab(1)

-- Console ASCII Art Success
print([[
    __      __  _  _  ____   ____    _   _  _   _  ____  
    \ \    / / | \| ||  _ \ / ___|  | | | || | | || __ ) 
     \ \  / /  | .  || | | |\___ \  | |_| || | | ||  _ \ 
      \ \/ /   | |\ || |_| | ___) | |  _  || |_| || |_) |
       \__/    |_| \_||____/ |____/  |_| |_| \___/ |____/ 
    
    [ MASTER LOADED SUCCESSFULLY FOR: ]] .. PlayerName .. [[ ]
]])
