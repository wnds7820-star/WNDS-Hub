-- // WNDS HUB v5.4 - AUTO UPDATE LOADER
local CurrentVersion = "5.4.0" -- Versi yang sedang jalan saat ini
local VersionURL = "https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/version.txt"

local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

-- // LOGIKA CEK UPDATE
local success, LatestVersion = pcall(function() return game:HttpGet(VersionURL) end)
if success then
    LatestVersion = LatestVersion:gsub("%s+", "") -- Bersihkan spasi/enter
    if LatestVersion ~= CurrentVersion then
        WindUI:Notify({
            Title = "Update Available!",
            Content = "New Version: " .. LatestVersion .. "\nYou are using: " .. CurrentVersion .. "\nPlease Restart Script.",
            Duration = 10
        })
    end
end

local Window = WindUI:CreateWindow({
    Title = "WNDS HUB v" .. CurrentVersion,
    Author = "by Raize",
    Folder = "WNDS_Configs",
    Icon = "solar:folder-2-bold-duotone",
    NewElements = true,
    OpenButton = {
        Title = "WNDS", Enabled = true, Draggable = true, Scale = 0.5,
        Color = ColorSequence.new(Color3.fromHex("#30FF6A"), Color3.fromHex("#e7ff2f")),
    }
})

-- Fungsi Load Module (Pastikan tetap ada)
local function LoadModule(fileName)
    local url = "https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/tabs/" .. fileName
    local s, content = pcall(function() return game:HttpGet(url) end)
    if s and not content:find("404: Not Found") then
        local func = loadstring(content)
        if func then
            getfenv(func).Window = Window
            getfenv(func).WindUI = WindUI
            return func()
        end
    end
end

-- // DAFTAR SEMUA TAB (Wajib di sini agar muncul)
LoadModule("tab_home.lua")
LoadModule("tab_updates.lua")
LoadModule("tab_combat.lua")  -- Baru!
LoadModule("tab_farming.lua") -- Baru!
LoadModule("tab_player.lua")
LoadModule("tab_visual.lua")
LoadModule("tab_world.lua")   -- Baru!
LoadModule("tab_misc.lua")
LoadModule("tab_settings.lua")

WindUI:Notify({
    Title = "WNDS Hub", 
    Content = "Welcome back, " .. playerName .. "! Running on " .. (execName or "Unknown Executor"), 
    Duration = 4
