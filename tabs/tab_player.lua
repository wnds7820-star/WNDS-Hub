-- // WNDS HUB v6.0 - PLAYER MOVEMENT MODULE
-- // Bagian 1: Advanced WalkSpeed & JumpPower Control
-- // Dikembangkan oleh Raize untuk WNDS Hub

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- // --- INTERNAL SETTINGS ---
-- Variabel global agar bisa diakses oleh sistem lain (seperti Config Save/Load)
_G.WalkSpeedValue = 16
_G.JumpPowerValue = 50
_G.MovementEnabled = false 

-- // --- CORE MOVEMENT ENGINE ---
-- Fungsi utama yang menangani sinkronisasi fisik karakter

local function ApplyMovementLogic()
    local Character = LocalPlayer.Character
    if Character then
        local Humanoid = Character:FindFirstChildOfClass("Humanoid")
        if Humanoid then
            -- Jika Toggle Aktif, kunci nilai ke slider
            if _G.MovementEnabled then
                -- Menangani WalkSpeed (Kecepatan Lari)
                if Humanoid.WalkSpeed ~= _G.WalkSpeedValue then
                    Humanoid.WalkSpeed = _G.WalkSpeedValue
                end
                
                -- Menangani Lompatan (JumpPower / JumpHeight)
                -- Logika ini mendeteksi sistem lompatan yang dipakai game secara otomatis
                if Humanoid.UseJumpPower then
                    if Humanoid.JumpPower ~= _G.JumpPowerValue then
                        Humanoid.JumpPower = _G.JumpPowerValue
                    end
                else
                    -- Konversi JumpPower ke JumpHeight (Matematika Dasar Roblox)
                    -- Rumus: Height = (Power^2) / (2 * Gravity)
                    -- Kita pakai estimasi rata-rata agar slider terasa natural
                    local TargetHeight = _G.JumpPowerValue / 7.2
                    if Humanoid.JumpHeight ~= TargetHeight then
                        Humanoid.JumpHeight = TargetHeight
                    end
                end
            else
                -- Jika Toggle Mati, kembalikan ke standar (16 dan 50)
                if Humanoid.WalkSpeed ~= 16 then Humanoid.WalkSpeed = 16 end
                if Humanoid.UseJumpPower then
                    if Humanoid.JumpPower ~= 50 then Humanoid.JumpPower = 50 end
                else
                    if Humanoid.JumpHeight ~= 7.2 then Humanoid.JumpHeight = 7.2 end
                end
            end
        end
    end
end

-- // --- ANTI-RESET HANDLER ---
-- Menggunakan RenderStepped (60fps+) agar bypass tetap terjaga setiap frame
-- Ini mencegah game-game seperti Blox Fruits atau Bedwars mereset kecepatanmu

RunService.RenderStepped:Connect(function()
    local Success, Error = pcall(function()
        ApplyMovementLogic()
    end)
    -- Jika terjadi error (misal karakter mati), fungsi akan otomatis berhenti sejenak
end)

-- // --- UI RENDERING (WindUI) ---
-- Bagian ini yang membuat tampilan menu di dalam tab Player

local PlayerTab = Window:Tab({
    Title = "Player",
    Icon = "solar:user-bold",
    Border = true,
})

local MoveSec = PlayerTab:Section({ Title = "Movement Modification" })

MoveSec:Toggle({
    Title = "Enable Custom Movement",
    Desc = "Aktifkan bypass agar kecepatan lari & lompat terkunci",
    Callback = function(v)
        _G.MovementEnabled = v
        
        -- Notifikasi instan saat diaktifkan
        if v then
            WindUI:Notify({
                Title = "WNDS Movement",
                Content = "Bypass Enabled: " .. _G.WalkSpeedValue .. " WS",
                Duration = 2
            })
        end
    end,
})

MoveSec:Slider({
    Title = "WalkSpeed (Speed)",
    Desc = "Kecepatan lari karakter (Default: 16)",
    Step = 1,
    Value = { Min = 16, Max = 500, Default = 16 },
    Callback = function(v)
        _G.WalkSpeedValue = v
    end,
})

MoveSec:Slider({
    Title = "JumpPower (High Jump)",
    Desc = "Kekuatan lompatan karakter (Default: 50)",
    Step = 1,
    Value = { Min = 50, Max = 1000, Default = 50 },
    Callback = function(v)
        _G.JumpPowerValue = v
    end,
})

-- Logika 500+ baris ke bawah biasanya mencakup proteksi Metatable
-- Agar script lain tidak bisa membaca perubahan WalkSpeed kita (Anti-Detection)
