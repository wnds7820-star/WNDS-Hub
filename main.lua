-- // WNDS HUB v5.4 - FIXED MODULAR LOADER
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

-- Fungsi Load Module yang Aman
local function LoadModule(fileName)
    -- Pastikan link ini mengarah ke folder 'tabs' di GitHub-mu
    local url = "https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/tabs/" .. fileName
    
    local success, content = pcall(function() return game:HttpGet(url) end)
    
    -- Cek apakah yang di-download itu beneran kode atau pesan error 404
    if success and not content:find("404: Not Found") then
        local func, err = loadstring(content)
        if func then
            getfenv(func).Window = Window
            getfenv(func).WindUI = WindUI
            return func()
        else
            warn("❌ Syntax Error di " .. fileName .. ": " .. err)
        end
    else
        warn("⚠️ File " .. fileName .. " tidak ditemukan di GitHub (404).")
    end
end

-- Panggil Tab secara berurutan
LoadModule("tab_home.lua")
LoadModule("tab_combat.lua")
LoadModule("tab_player.lua")
LoadModule("tab_visual.lua")
LoadModule("tab_settings.lua")
LoadModule("tab_misc.lua")

WindUI:Notify({Title = "WNDS Hub", Content = "Modular System Ready!", Duration = 3})
