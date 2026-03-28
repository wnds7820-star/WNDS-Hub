-- // WNDS HUB v5.4 - MASTER LOADER
-- // Gunakan link RAW agar Roblox bisa membaca kodenya

-- 0. LOAD LIBRARY UTAMA (Taruh di Global agar bisa dibaca ui_config)
_G.Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local function SafeLoad(url)
    local s, content = pcall(function() return game:HttpGet(url) end)
    if s and content then
        local func, err = loadstring(content)
        if func then return func() else warn("Error: " .. url .. " | " .. tostring(err)) end
    else
        warn("Gagal mengambil file: " .. url)
    end
end

-- 1. Jalankan Intro
task.spawn(function() 
    SafeLoad("https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/loader_intro.lua") 
end)

task.wait(4.5)

-- 2. Ambil Data Akun (Profil, Foto, dll)
_G.WNDS_Data = SafeLoad("https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/info_data.lua")

-- 3. Jalankan UI Config (Membangun Window & Tabs)
-- Sekarang ui_config gak akan error lagi karena Fluent sudah ada di atas
SafeLoad("https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/ui_config.lua")

print("WNDS Hub: Semua modul berhasil ditarik dari link RAW!")
