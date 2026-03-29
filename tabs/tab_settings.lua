-- // WNDS HUB v6.5 - SYSTEM & CONFIG
-- // Developer: Raize

local Window = _G.WNDS_Window
local Fluent = _G.WNDS_Fluent
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local SettingsTab = Window:AddTab({ Title = "Settings", Icon = "settings" })

-- // SECTION: CONFIGURATION (Using Fluent SaveManager)
local ConfigSec = SettingsTab:AddSection("Configuration Manager")

-- Tombol Save/Load Otomatis
ConfigSec:AddButton({
    Title = "Save Current Config",
    Description = "Simpan semua settingan ke folder executor",
    Callback = function()
        SaveManager:Save(SaveManager.CurrentConfig)
        Fluent:Notify({Title = "Config", Content = "Settings Saved!"})
    end
})

ConfigSec:AddButton({
    Title = "Load Last Config",
    Description = "Muat settingan terakhir",
    Callback = function()
        SaveManager:Load(SaveManager.CurrentConfig)
        Fluent:Notify({Title = "Config", Content = "Settings Loaded!"})
    end
})

-- // SECTION: SCRIPT MANAGEMENT
local ManageSec = SettingsTab:AddSection("Script Management")

ManageSec:AddButton({
    Title = "Reload WNDS Hub",
    Description = "Muat ulang script (Gunakan jika ada update GitHub)",
    Callback = function()
        Window:Destroy()
        task.wait(0.5)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/main.lua"))()
    end
})

ManageSec:AddButton({
    Title = "Executor Tester v2",
    Description = "Cek kompatibilitas executor kamu",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/GmilerlolYT/ExecutorTester/refs/heads/main/Hi"))()
    end
})

-- // SECTION: UI CUSTOMIZATION
local UiSec = SettingsTab:AddSection("User Interface")

-- Fitur Ganti Tema Otomatis dari Fluent
InterfaceManager:SetFolder("WNDS_HUB")
InterfaceManager:BuildInterfaceSection(SettingsTab)

UiSec:AddButton({
    Title = "Unload Script",
    Description = "Hapus UI dan hentikan script",
    Callback = function() 
        Window:Destroy() 
    end
})

-- // --- INITIALIZE SAVE MANAGER ---
SaveManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
SaveManager:SetFolder("WNDS_HUB/" .. game.PlaceId)
SaveManager:BuildConfigSection(SettingsTab)

print("[WNDS HUB] Settings tab successfully loaded.")
