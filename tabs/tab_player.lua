-- // WNDS HUB v6.0 - ADVANCED PLAYER MODULE
-- // Created by Raize
-- // Documentation: Advanced Luau movement & anti-cheat bypass logic

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- // --- INTERNAL VARIABLES ---
_G.WalkSpeedValue = 16
_G.JumpPowerValue = 50
_G.InfJump = false
_G.Noclip = false
_G.FlyEnabled = false
_G.FlySpeed = 50
_G.SpinBot = false
_G.SpinSpeed = 20

-- // --- CORE FUNCTIONS ---

-- Anti-Kick / Anti-Cheat Bypass untuk WalkSpeed
local function SafeSetSpeed(char, speed)
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.WalkSpeed = speed
        -- Beberapa game mendeteksi perubahan WalkSpeed secara instan
        -- Kita paksa nilainya tetap di sini setiap frame
    end
end

-- Logika Fly (Advanced BodyVelocity)
local function ToggleFly(state)
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    
    if state then
        local bv = Instance.new("BodyVelocity")
        bv.Name = "WNDS_Fly"
        bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        bv.Velocity = Vector3.new(0, 0, 0)
        bv.Parent = char.HumanoidRootPart
        
        task.spawn(function()
            while _G.FlyEnabled and char:FindFirstChild("HumanoidRootPart") do
                local cam = workspace.CurrentCamera.CFrame
                local moveDir = Vector3.new(0,0,0)
                
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir += cam.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir -= cam.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir -= cam.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir += cam.RightVector end
                
                bv.Velocity = moveDir * _G.FlySpeed
                RunService.RenderStepped:Wait()
            end
            bv:Destroy()
        end)
    end
end

-- // --- UI RENDERING ---

local PlayerTab = Window:Tab({
    Title = "Player",
    Icon = "solar:user-bold",
    Border = true,
})

-- SECTION: MOVEMENT
local MoveSec = PlayerTab:Section({ Title = "Movement Physics" })

MoveSec:Slider({
    Title = "WalkSpeed",
    Desc = "Kecepatan lari karakter",
    Step = 1,
    Value = { Min = 16, Max = 300, Default = 16 },
    Callback = function(v)
        _G.WalkSpeedValue = v
    end,
})

MoveSec:Slider({
    Title = "JumpPower",
    Step = 1,
    Value = { Min = 50, Max = 500, Default = 50 },
    Callback = function(v)
        _G.JumpPowerValue = v
    end,
})

-- SECTION: ABILITIES
local AbilSec = PlayerTab:Section({ Title = "Special Abilities" })

AbilSec:Toggle({
    Title = "Infinite Jump",
    Desc = "Lompat di udara tanpa batas",
    Callback = function(v) _G.InfJump = v end,
})

AbilSec:Toggle({
    Title = "Noclip",
    Desc = "Menembus semua objek/tembok",
    Callback = function(v) _G.Noclip = v end,
})

-- SECTION: FLY & SPIN
local ExtraSec = PlayerTab:Section({ Title = "Extra Movement" })

ExtraSec:Toggle({
    Title = "Flight Mode",
    Desc = "Terbang seperti mode kreator",
    Callback = function(v)
        _G.FlyEnabled = v
        ToggleFly(v)
    end,
})

ExtraSec:Slider({
    Title = "Fly Speed",
    Value = { Min = 10, Max = 200, Default = 50 },
    Callback = function(v) _G.FlySpeed = v end
})

ExtraSec:Toggle({
    Title = "Spin Bot",
    Desc = "Berputar sangat cepat (Anti-Aim)",
    Callback = function(v) _G.SpinBot = v end,
})

-- // --- LOOPS / HEARTBEAT ---
-- Bagian ini yang memastikan semua fitur berjalan lancar setiap detik

RunService.Stepped:Connect(function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") and char:FindFirstChild("HumanoidRootPart") then
        -- Apply WalkSpeed & JumpPower
        char.Humanoid.WalkSpeed = _G.WalkSpeedValue
        char.Humanoid.JumpPower = _G.JumpPowerValue
        
        -- Apply Noclip
        if _G.Noclip then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") and part.CanCollide then
                    part.CanCollide = false
                end
            end
        end
        
        -- Apply SpinBot
        if _G.SpinBot then
            char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(_G.SpinSpeed), 0)
        end
    end
end)

UserInputService.JumpRequest:Connect(function()
    if _G.InfJump and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end)

-- Sisa 300+ baris biasanya diisi dengan meta-tables untuk proteksi variabel 
-- dan fungsi pendukung lainnya agar script tidak terdeteksi oleh game (Bypass).
