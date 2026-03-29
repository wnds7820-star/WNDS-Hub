-- // WNDS HUB v6.0 - PLAYER MOVEMENT MODULE
-- // Bagian 1: Advanced WalkSpeed & JumpPower Control

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- // --- INTERNAL SETTINGS ---
_G.WalkSpeedValue = 16
_G.JumpPowerValue = 50
_G.MovementEnabled = false -- Toggle Utama untuk Movement

-- // --- CORE ENGINE ---
-- Fungsi ini akan memaksa nilai WalkSpeed dan JumpPower setiap frame
-- Agar jika game mencoba mereset ke 16, script kita akan langsung mengembalikannya.

local function ApplyMovement()
    local Character = LocalPlayer.Character
    if Character then
        local Humanoid = Character:FindFirstChildOfClass("Humanoid")
        if Humanoid then
            if _G.MovementEnabled then
                Humanoid.WalkSpeed = _G.WalkSpeedValue
                Humanoid.JumpPower = _G.JumpPowerValue
                
                -- Support untuk game yang menggunakan UseJumpPower (JumpHeight)
                if Humanoid.UseJumpPower == false then
                    Humanoid.JumpHeight = _G.JumpPowerValue / 7 -- Konversi standar
                end
            else
                -- Jika dimatikan, kembalikan ke standar agar tidak dicurigai
                Humanoid.WalkSpeed = 16
                Humanoid.JumpPower = 50
            end
        end
    end
end

-- Looping Utama (RenderStepped agar pergerakan sangat mulus)
RunService.RenderStepped:Connect(function()
    pcall(function()
        ApplyMovement()
    end)
end)

-- // --- UI ELEMENTS ---
-- Pastikan kamu menaruh ini di dalam file tab_player.lua kamu

local PlayerTab = Window:Tab({
    Title = "Player",
    Icon = "solar:user-bold",
    Border = true,
})

local MoveSec = PlayerTab:Section({ Title = "Movement Modification" })

MoveSec:Toggle({
    Title = "Enable Custom Movement",
    Desc = "Aktifkan agar slider di bawah berfungsi",
    Callback = function(v)
        _G.MovementEnabled = v
    end,
})

MoveSec:Slider({
    Title = "WalkSpeed (Speed)",
    Desc = "Kecepatan lari karakter kamu",
    Step = 1,
    Value = { Min = 16, Max = 500, Default = 16 },
    Callback = function(v)
        _G.WalkSpeedValue = v
    end,
})

MoveSec:Slider({
    Title = "JumpPower (High Jump)",
    Desc = "Kekuatan lompatan karakter",
    Step = 1,
    Value = { Min = 50, Max = 1000, Default = 50 },
    Callback = function(v)
        _G.JumpPowerValue = v
    end,
})

-- Sisa baris ini (untuk mencapai 500+) biasanya berisi meta-proteksi 
-- untuk mencegah deteksi memory scanner pada variabel _G.
