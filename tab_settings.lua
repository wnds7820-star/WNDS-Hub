-- // WNDS HUB - SETTINGS MODULE (RELOAD UPDATE)
local Tabs = _G.WNDS_UI.Tabs
local Window = _G.WNDS_UI.Window

Tabs.Settings:Section({ Title = "System Control" })

-- Fitur Reload Script
Tabs.Settings:Button({
    Title = "Reload WNDS Hub",
    Desc = "Memuat ulang skrip dari GitHub (Gunakan setelah Update)",
    Callback = function()
        -- Hapus UI lama agar tidak menumpuk
        Window:Destroy()
        
        -- Jalankan kembali Loader utama (main.lua) menggunakan link RAW
        loadstring(game:HttpGet("https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/main.lua"))()
        
        -- Beri notifikasi kecil (opsional)
        print("WNDS Hub: Reloading...")
    end,
})

Tabs.Settings:Section({ Title = "Hub Management" })

Tabs.Settings:Button({
    Title = "Rejoin Server",
    Callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
    end,
})

Tabs.Settings:Button({
    Title = "Destroy UI",
    Callback = function() Window:Destroy() end,
})
