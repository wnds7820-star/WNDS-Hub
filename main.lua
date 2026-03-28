-- 1. Tentukan pangkalan link RAW kamu di sini (PASTIKAN ADA "/" DI AKHIR)
local base_url = "https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/"

-- 2. Fungsi SafeLoad akan otomatis menggabungkan base_url dengan nama filenya
local function SafeLoad(file)
    local s, content = pcall(function() 
        return game:HttpGet(base_url .. file) 
    end)
    
    if s and content then
        local func, err = loadstring(content)
        if func then 
            return func() 
        else 
            warn("WNDS Error: Gagal membaca kode di " .. file .. " | " .. tostring(err))
        end
    else
        warn("WNDS Error: File tidak ditemukan di link RAW: " .. file)
    end
end

-- 3. Proses Loading (Semua ini otomatis ketarik dari link RAW)
task.spawn(function() SafeLoad("loader_intro.lua") end)
task.wait(4.5)

_G.WNDS_Data = SafeLoad("info_data.lua")
_G.WNDS_UI = SafeLoad("ui_config.lua")

-- Memanggil file fitur per tab dari link RAW
SafeLoad("tab_combat.lua")
SafeLoad("tab_visuals.lua")
SafeLoad("tab_player.lua")
SafeLoad("tab_teleport.lua")
SafeLoad("tab_settings.lua")

print("WNDS Hub: Berhasil dijalankan menggunakan jalur RAW!")
