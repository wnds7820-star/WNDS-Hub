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

-- // WNDS HUB v6.0 - PLAYER MOVEMENT MODULE
-- // Bagian 2: Static Flight System (Independent Movement)

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
    
    -- Pembersihan Body Mover lama
    for _, v in pairs(Root:GetChildren()) do
        if v:IsA("BodyVelocity") or v:IsA("BodyGyro") then v:Destroy() end
    end
    
    -- BodyVelocity: Menjaga posisi agar DIAM (0,0,0) jika tidak ada input
    local BV = Instance.new("BodyVelocity")
    BV.Name = "WNDS_FlyVelocity"
    BV.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    BV.Velocity = Vector3.new(0, 0, 0) -- Default diam
    BV.Parent = Root
    
    -- BodyGyro: Mengunci rotasi karakter agar tetap tegak
    local BG = Instance.new("BodyGyro")
    BG.Name = "WNDS_FlyGyro"
    BG.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    BG.P = 90000
    BG.CFrame = Root.CFrame
    BG.Parent = Root
    
    if Hum then Hum.PlatformStand = true end

    -- LOOPING TERBANG (Independent Input Logic)
    task.spawn(function()
        while _G.FlyEnabled and Character:FindFirstChild("HumanoidRootPart") do
            local MoveDirection = Vector3.new(0, 0, 0)
            local CamCF = Camera.CFrame
            
            -- Sesuai Request kamu:
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then MoveDirection += CamCF.LookVector end -- Maju
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then MoveDirection -= CamCF.LookVector end -- Mundur
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then MoveDirection -= CamCF.RightVector end -- Kiri
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then MoveDirection += CamCF.RightVector end -- Kanan
            if UserInputService:IsKeyDown(Enum.KeyCode.E) then MoveDirection += Vector3.new(0, 1, 0) end -- Naik (E)
            if UserInputService:IsKeyDown(Enum.KeyCode.Q) then MoveDirection -= Vector3.new(0, 1, 0) end -- Turun (Q)
            
            -- Hitung Kecepatan: Jika tidak ada tombol ditekan, kecepatan jadi 0 (Diam)
            if MoveDirection.Magnitude > 0 then
                BV.Velocity = MoveDirection.Unit * _G.FlySpeed
            else
                BV.Velocity = Vector3.new(0, 0, 0) -- Mengunci posisi di udara
            end
            
            -- Karakter tetap menghadap ke depan sesuai kamera
            BG.CFrame = CamCF
            
            RunService.RenderStepped:Wait()
        end
        
        -- Cleanup
        if BV then BV:Destroy() end
        if BG then BG:Destroy() end
        if Hum then Hum.PlatformStand = false end
    end)
end

-- // --- UI ELEMENTS ---

local FlySec = PlayerTab:Section({ Title = "Flight Control" })

FlySec:Toggle({
    Title = "Static Flight (Fly)",
    Desc = "WASD = Bergerak | E = Naik | Q = Turun",
    Callback = function(v)
        _G.FlyEnabled = v
        if v then
            StartFlight()
        else
            -- Pastikan saat OFF karakter langsung jatuh normal
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
    Title = "Fly Speed",
    Value = { Min = 10, Max = 300, Default = 50 },
    Callback = function(v) _G.FlySpeed = v end,
})
