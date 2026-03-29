--[[
    WNDS HUB PREMIUM v6.5 - OFFICIAL LOADER
    Developer: Raize
    Description: Main entry point for WNDS Hub.
]]

-- // SECURITY & ENVIRONMENT CHECK
if not game:IsLoaded() then
    game.Loaded:Wait()
end

-- // NOTIFICATION SYSTEM (Awal agar user tahu script jalan)
local function Notify(title, msg)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = title,
        Text = msg,
        Duration = 5
    })
end

-- // ANTI-RE-EXECUTION (Mencegah UI numpuk kalau dijalankan berkali-kali)
if _G.WNDS_Loaded then
    Notify("WNDS Hub", "Script sudah berjalan!")
    return
end

-- // INITIALIZING
Notify("WNDS Hub", "Menghubungkan ke GitHub...")

-- // GLOBAL CONFIG & DATA
_G.WNDS_Loaded = true
_G.WNDS_Developer = "Raize"
_G.WNDS_Version = "6.5.0"

-- // THE CORE EXECUTION
local function ExecuteMain()
    local MainURL = "https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/main.lua"
    local success, result = pcall(function()
        return game:HttpGet(MainURL)
    end)

    if success and result then
        local func, err = loadstring(result)
        if func then
            -- Jalankan Main Script
            local mainSuccess, mainError = pcall(func)
            if not mainSuccess then
                warn("[WNDS ERROR]: " .. tostring(mainError))
                _G.WNDS_Loaded = false
            end
        else
            warn("[WNDS ERROR]: Compile Error - " .. tostring(err))
            _G.WNDS_Loaded = false
        end
    else
        warn("[WNDS ERROR]: Gagal mengambil file main.lua dari GitHub.")
        _G.WNDS_Loaded = false
        Notify("Connection Error", "Gagal memuat file utama. Cek koneksi/URL.")
    end
end

-- Jalankan fungsi eksekusi
ExecuteMain()

-- // LOG
print([[
  __      __  _   _  _____    _____ 
  \ \    / / | \ | | |  __ \  / ____|
   \ \  / /  |  \| | | |  | | | (___  
    \ \/ /   | . ` | | |  | |  \___ \ 
     \  /    | |\  | | |__| |  ____) |
      \/     |_| \_| |_____/  |_____/ 
      WNDS HUB PREMIUM LOADED - RAIZE
]])
