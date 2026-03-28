-- .ftgs hub | Main Loader
print("Loading .ftgs hub...")

local success, WindUI = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
end)

if not success or not WindUI then
    error("❌ Gagal memuat WindUI!")
end

-- Fungsi untuk load module dari repo
local function loadModule(path)
    local url = "https://raw.githubusercontent.com/YOURUSERNAME/ftgs-hub/main/" .. path
    local success, code = pcall(game.HttpGet, game, url)
    if not success then
        error("❌ Gagal load: " .. path)
    end
    return loadstring(code)()
end

-- Load init dulu (untuk buat Window)
local Init = loadModule("src/init.lua")
local Window = Init.Window

-- Load semua tab
loadModule("src/tabs/overview.lua")
loadModule("src/tabs/player.lua")
loadModule("src/tabs/movement.lua")
loadModule("src/tabs/visuals.lua")
loadModule("src/tabs/combat.lua")
loadModule("src/tabs/misc.lua")

print("✅ .ftgs hub berhasil dimuat! (Mobile/PC Adaptive)")
