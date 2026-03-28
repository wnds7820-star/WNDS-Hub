-- // WNDS HUB v5.4 - MASTER LOADER
-- // Gunakan link RAW agar Roblox bisa membaca kodenya

local function SafeLoad(url)
    local s, content = pcall(function() return game:HttpGet(url) end)
    if s and content then
        local func, err = loadstring(content)
        if func then return func() else warn("Error: " .. url .. " | " .. tostring(err)) end
    else
        warn("Gagal mengambil file (Pastikan link RAW benar): " .. url)
    end
end

-- 1. Jalankan Intro (Pake link RAW)
task.spawn(function() 
    SafeLoad("https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/loader_intro.lua") 
end)

task.wait(4.5)

-- 2. Ambil Data & UI (Pake link RAW)
_G.WNDS_Data = SafeLoad("https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/info_data.lua")
_G.WNDS_UI = SafeLoad("https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/ui_config.lua")

-- 3. Panggil Semua Tab (Semuanya pake link RAW)
SafeLoad("https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/tab_combat.lua")
SafeLoad("https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/tab_visuals.lua")
SafeLoad("https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/tab_player.lua")
SafeLoad("https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/tab_teleport.lua")
SafeLoad("https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/tab_settings.lua")

print("WNDS Hub: Semua modul berhasil ditarik dari link RAW!")
