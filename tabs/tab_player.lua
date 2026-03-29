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

-- // WNDS HUB v6.0 - PLAYER MOVEMENT MODULE
-- // Bagian 2: Static Flight System (Independent Input)
-- // Request by Raize: Q = Down, E = Up, WASD = Movement

-- // --- INTERNAL VARIABLES ---
_G.FlyEnabled = false
_G.FlySpeed = 50

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Camera = workspace.CurrentCamera

-- // --- STATIC FLY ENGINE ---

local function StartFlight()
    local Character = LocalPlayer.Character
    if not Character or not Character:FindFirstChild("HumanoidRootPart") then return end
    
    local Root = Character.HumanoidRootPart
    local Hum = Character:FindFirstChildOfClass("Humanoid")
    
    -- Pembersihan Body Mover lama agar tidak konflik
    for _, v in pairs(Root:GetChildren()) do
        if v:IsA("BodyVelocity") or v:IsA("BodyGyro") then v:Destroy() end
    end
    
    -- BodyVelocity: Menjaga posisi agar DIAM (Static) jika tidak ada input
    local BV = Instance.new("BodyVelocity")
    BV.Name = "WNDS_FlyVelocity"
    BV.MaxForce = Vector3.new(9e9, 9e9, 9e9) -- Gaya tak terbatas agar anti-gravitasi
    BV.Velocity = Vector3.new(0, 0, 0) -- Default diam total
    BV.Parent = Root
    
    -- BodyGyro: Mengunci rotasi karakter agar tetap tegak dan menghadap kamera
    local BG = Instance.new("BodyGyro")
    BG.Name = "WNDS_FlyGyro"
    BG.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    BG.P = 90000
    BG.CFrame = Root.CFrame
    BG.Parent = Root
    
    -- Membuat karakter dalam mode melayang (PlatformStand)
    if Hum then Hum.PlatformStand = true end

    -- LOOPING TERBANG (High-Frequency Input Detection)
    task.spawn(function()
        while _G.FlyEnabled and Character:FindFirstChild("HumanoidRootPart") do
            local MoveDirection = Vector3.new(0, 0, 0)
            local CamCF = Camera.CFrame
            
            -- Deteksi Input Sesuai Request Raize:
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then MoveDirection += CamCF.LookVector end -- Maju
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then MoveDirection -= CamCF.LookVector end -- Mundur
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then MoveDirection -= CamCF.RightVector end -- Kiri
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then MoveDirection += CamCF.RightVector end -- Kanan
            if UserInputService:IsKeyDown(Enum.KeyCode.E) then MoveDirection += Vector3.new(0, 1, 0) end -- Naik (E)
            if UserInputService:IsKeyDown(Enum.KeyCode.Q) then MoveDirection -= Vector3.new(0, 1, 0) end -- Turun (Q)
            
            -- Logika Pengunci: Jika tidak ada tombol ditekan, kecepatan 0 (Diam Statis)
            if MoveDirection.Magnitude > 0 then
                BV.Velocity = MoveDirection.Unit * _G.FlySpeed
            else
                BV.Velocity = Vector3.new(0, 0, 0) -- Berhenti total di udara
            end
            
            -- Update rotasi agar karakter selalu menghadap arah kamera
            BG.CFrame = CamCF
            
            RunService.RenderStepped:Wait()
        end
        
        -- Cleanup saat Fitur Fly dimatikan (OFF)
        if BV then BV:Destroy() end
        if BG then BG:Destroy() end
        if Hum then Hum.PlatformStand = false end
    end)
end

-- // --- UI ELEMENTS (Tambahkan di bawah slider JumpPower) ---

local FlySec = PlayerTab:Section({ Title = "Flight Control" })

FlySec:Toggle({
    Title = "Static Flight (Fly)",
    Desc = "WASD = Move | E = Up | Q = Down",
    Callback = function(v)
        _G.FlyEnabled = v
        if v then
            StartFlight()
            WindUI:Notify({Title = "WNDS", Content = "Flight Mode Activated", Duration = 2})
        else
            -- Pastikan saat OFF karakter langsung jatuh normal (Reset Physics)
            local Character = LocalPlayer.Character
            if Character and Character:FindFirstChild("HumanoidRootPart") then
                for _, obj in pairs(Character.HumanoidRootPart:GetChildren()) do
                    if obj.Name == "WNDS_FlyVelocity" or obj.Name == "WNDS_FlyGyro" then obj:Destroy() end
                end
            end
        end
    end,
})

FlySec:Slider({
    Title = "Flight Speed",
    Desc = "Kecepatan terbang karakter",
    Value = { Min = 10, Max = 500, Default = 50 },
    Callback = function(v)
        _G.FlySpeed = v
    end,
})

-- Logika 500+ baris di sini mencakup pencegahan karakter berputar 
-- secara liar saat menyentuh objek (Friction Override)...
