--[[
    WNDS HUB - BOOTSTRAPPER (v1.0)
    Ini adalah satu-satunya link yang harus kamu sebar ke user.
]]

local HttpService = game:GetService("HttpService")
local Player = game:GetService("Players").LocalPlayer

-- // SETTINGS (Pusat Kendali)
local Config = {
    Version = "6.5.0",
    Status = "Online", -- Ganti ke "Maintenance" jika sedang diperbaiki
    LatestLoader = "https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/Loader.lua",
    Discord = "https://discord.gg/wndshub"
}

-- // 1. CHECK STATUS (Maintenance Guard)
if Config.Status == "Maintenance" then
    Player:Kick("\n[WNDS HUB]\nMohon maaf, script sedang dalam perbaikan.\nSilakan cek Discord: " .. Config.Discord)
    return
end

-- // 2. BLACKLIST CHECK (Sangat Simpel)
local BlacklistedUsers = {12345678, 87654321} -- Contoh UserID yang diblokir
for _, id in pairs(BlacklistedUsers) do
    if Player.UserId == id then
        Player:Kick("Kamu telah diblokir dari penggunaan WNDS Hub.")
        return
    end
end

-- // 3. FETCH & RUN THE REAL LOADER
local success, content = pcall(function()
    return game:HttpGet(Config.LatestLoader)
end)

if success then
    loadstring(content)()
else
    warn("[WNDS BOOT]: Gagal menghubungkan ke server utama.")
end
