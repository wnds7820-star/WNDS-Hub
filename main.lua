-- // WNDS HUB v5.4 - MODULAR LOADER
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "WNDS HUB v5.4",
    Author = "by Raize",
    Folder = "WNDS_Configs",
    Icon = "solar:folder-2-bold-duotone",
    NewElements = true,
    OpenButton = {
        Title = "WNDS", Enabled = true, Draggable = true, Scale = 0.5,
        Color = ColorSequence.new(Color3.fromHex("#30FF6A"), Color3.fromHex("#e7ff2f")),
    }
})

-- Bagian Penting: Fungsi Load Tab dari GitHub
local function LoadTab(fileName)
    local url = "https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/refs/heads/main/tabs/" .. fileName
    local success, content = pcall(function() return game:HttpGet(url) end)
    if success then
        local func, err = loadstring(content)
        if func then 
            -- Masukkan Window & WindUI ke environment tab agar bisa dipakai di file terpisah
            getfenv(func).Window = Window
            getfenv(func).WindUI = WindUI
            return func() 
        else
            warn("Syntax Error di " .. fileName .. ": " .. err)
        end
    else
        warn("Gagal Load File: " .. fileName)
    end
end

-- Panggil semua file tab (Buat folder bernama 'tabs' di GitHub-mu)
LoadTab("tab_home.lua")
LoadTab("tab_combat.lua")
LoadTab("tab_player.lua")
LoadTab("tab_visual.lua")
LoadTab("tab_settings.lua")

WindUI:Notify({Title = "WNDS Hub", Content = "Semua Module Berhasil Dimuat!", Duration = 5})
