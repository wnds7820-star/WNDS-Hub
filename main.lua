-- // WNDS HUB v5.4 - STEP 1: UI TEST
-- // Fokus: Cuma buat munculin menu!

local WindUI = nil

-- Kita coba ambil Library lewat link yang paling stabil
local success, result = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/refs/heads/main/Source.lua"))()
end)

if success and result then
    WindUI = result
    print("✅ [WNDS]: Library Berhasil Diambil!")
else
    warn("❌ [WNDS]: Gagal ambil Library. Masalah koneksi/DNS.")
    return
end

-- Bikin Window Sederhana
local Window = WindUI:CreateWindow({
    Title = "WNDS Hub v5.4",
    Icon = "rbxassetid://10723343321",
    Author = "by Raize",
    Folder = "WNDS_Test"
})

-- Tambah satu tab buat ngetes
local TabTest = Window:AddTab({ Title = "Test Tab", Icon = "check" })

TabTest:AddButton({
    Title = "Klik Aku",
    Desc = "Kalau muncul notif, berarti UI aman!",
    Callback = function()
        WindUI:Notify({
            Title = "Sukses!",
            Content = "UI WNDS Berhasil Muncul, Raize!",
            Duration = 3
        })
    end
})

print("✅ [WNDS]: Window harusnya muncul sekarang!")
