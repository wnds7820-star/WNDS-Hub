-- // WNDS HUB v5.4
-- // Developer: Raize

local WindUI = nil
local Success = false

-- Daftar Link Alternatif (Kalau satu mati, pakai yang lain)
local Links = {
    "https://raw.githubusercontent.com/Footagesus/WindUI/refs/heads/main/Source.lua",
    "https://treehouse.overdrive.id/WindUI/main.lua" -- Mirror Link
}

print("🚀 [WNDS]: Menghubungkan ke Library UI...")

-- Mencoba memuat library dari daftar link
for _, url in pairs(Links) do
    if not Success then
        local s, res = pcall(function()
            return loadstring(game:HttpGet(url))()
        end)
        if s and res then
            WindUI = res
            Success = true
            print("✅ [WNDS]: Berhasil terhubung melalui: " .. url)
        end
    end
end

if not Success or not WindUI then
    warn("❌ [WNDS]: Semua jalur koneksi terblokir! Gunakan VPN atau ganti DNS.")
    return
end

-- // MULAI BUAT MENU (Jalankan hanya jika WindUI ada)
local Window = WindUI:CreateWindow({
    Title = "WNDS Hub v5.4",
    Icon = "rbxassetid://10723343321",
    Author = "by Raize",
    Folder = "WNDS_Configs"
})

-- TAB INFO
local TabInfo = Window:AddTab({ Title = "Info", Icon = "info" })
TabInfo:AddParagraph({ Title = "Dashboard", Desc = "User: " .. game.Players.LocalPlayer.Name })

-- TAB PLAYER
local TabPlayer = Window:AddTab({ Title = "Player", Icon = "user" })
TabPlayer:AddSlider({
    Title = "Speed",
    Min = 16, Max = 300, Default = 16,
    Callback = function(v) game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v end
})

-- NOTIFIKASI
WindUI:Notify({ Title = "WNDS Hub", Content = "Script Ready!", Duration = 3 })
