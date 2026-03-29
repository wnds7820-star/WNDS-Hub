-- // WNDS HUB v5.4 - FIX LOAD ERROR
-- // Developer: Raize

local WindUI = nil

-- Loop untuk memastikan library beneran ke-load (Anti-Nil)
local success, result = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/refs/heads/main/Source.lua"))()
end)

if success and result then
    WindUI = result
else
    warn("❌ [WNDS]: Gagal mengambil Library UI! Cek koneksi.")
    return
end

-- Tunggu sebentar biar library siap di memory
task.wait(0.5)

-- // START CREATING WINDOW
local Window = WindUI:CreateWindow({
    Title = "WNDS Hub v5.4",
    Icon = "rbxassetid://10723343321",
    Author = "by Raize",
    Folder = "WNDS_Configs"
})

-- // --- TAB: INFO ---
local TabInfo = Window:AddTab({ Title = "Info", Icon = "info" })
TabInfo:AddParagraph({
    Title = "User Profile",
    Desc = "Welcome back, " .. game.Players.LocalPlayer.DisplayName
})

-- // --- TAB: COMBAT ---
local TabCombat = Window:AddTab({ Title = "Combat", Icon = "sword" })
TabCombat:AddToggle({
    Title = "Silent Aim",
    Default = false,
    Callback = function(v) _G.SilentAim = v end
})

-- // --- TAB: PLAYER ---
local TabPlayer = Window:AddTab({ Title = "Player", Icon = "user" })
TabPlayer:AddSlider({
    Title = "WalkSpeed",
    Min = 16, Max = 500, Default = 16,
    Callback = function(v) 
        pcall(function() game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v end) 
    end
})

-- // --- TAB: SETTINGS ---
local TabSettings = Window:AddTab({ Title = "Settings", Icon = "settings" })
TabSettings:AddButton({
    Title = "Rejoin Server",
    Callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
    end
})

-- // NOTIFIKASI SUKSES
WindUI:Notify({
    Title = "WNDS Hub",
    Content = "Script Ready to Use!",
    Duration = 3
})

print("✅ [WNDS]: Window Created Successfully!")
