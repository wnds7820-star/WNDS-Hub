-- // GANTI BAGIAN SAFELOAD DI ui_config.lua DENGAN INI
local function LoadTab(url)
    local success, result = pcall(function()
        -- Kita buat agar variabel 'Tabs' bisa dibaca di dalam file yang di-load
        local code = game:HttpGet(url .. "?t=" .. tostring(math.random(1,1000)))
        local func = loadstring(code)
        if func then
            return func()
        end
    end)
    if not success then warn("WNDS Gagal Load Tab: " .. url) end
end

-- Panggil semua tab (Pastikan nama file di GitHub SUDAH TANPA SPASI)
LoadTab("https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/tab_info.lua")
LoadTab("https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/tab_combat.lua")
LoadTab("https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/tab_visuals.lua")
LoadTab("https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/tab_player.lua")
LoadTab("https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/tab_teleport.lua")
LoadTab("https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/tab_settings.lua")
