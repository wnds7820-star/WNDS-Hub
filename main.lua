-- // WNDS HUB v5.4 - OFFICIAL MODULAR LOADER
-- // Creator: Raize (WNDS)

local function SafeLoad(url)
    local s, content = pcall(function() return game:HttpGet(url) end)
    if s and content then
        local func, err = loadstring(content)
        if func then 
            return func() 
        else 
            warn("WNDS Error loading script: " .. tostring(err)) 
        end
    else
        warn("WNDS Failed to fetch from: " .. url)
    end
end

-- 1. Jalankan Intro Loader (Animasi Awal)
task.spawn(function()
    SafeLoad("https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/loader_intro.lua")
end)

task.wait(4.5)

-- 2. Ambil Data Akun & Server (Platform, Executor, Region)
_G.WNDS_Data = SafeLoad("https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/info_data.lua")

-- 3. Inisialisasi UI & Tab (WindUI Config)
_G.WNDS_UI = SafeLoad("https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/ui_config.lua")

-- 4. Aktifkan Fitur (Combat, Visual, Player)
SafeLoad("https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/functions.lua")

print("WNDS Hub v5.4: All Modules Successfully Injected!")
