-- // WNDS HUB v6.0 - ADVANCED PLAYER MODULE
-- // Full Module: Movement Bypass & Static Flight System
-- // Created by Raize

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- // --- INTERNAL GLOBAL VARIABLES ---
_G.WalkSpeedValue = 16
_G.JumpPowerValue = 50
_G.MovementEnabled = false 

_G.FlyEnabled = false
_G.FlySpeed = 50

-- // --- CORE MOVEMENT ENGINE (BYPASS) ---
local function ApplyMovement()
    local Character = LocalPlayer.Character
    if Character then
        local Humanoid = Character:FindFirstChildOfClass("Humanoid")
        if Humanoid then
            if _G.MovementEnabled then
                Humanoid.WalkSpeed = _G.WalkSpeedValue
                if Humanoid.UseJumpPower then
                    Humanoid.JumpPower = _G.JumpPowerValue
                else
                    Humanoid.JumpHeight = _G.JumpPowerValue / 7.2
                end
            else
                Humanoid.WalkSpeed = 16
                if Humanoid.UseJumpPower then
                    Humanoid.JumpPower = 50
                else
                    Humanoid.JumpHeight = 7.2
                end
            end
        end
    end
end

-- // --- STATIC FLY ENGINE (W,A,S,D + Q,E) ---
local function StartFlight()
    local Character = LocalPlayer.Character
    if not Character or not Character:FindFirstChild("HumanoidRootPart") then return end
    
    local Root = Character.HumanoidRootPart
    local Hum = Character:FindFirstChildOfClass("Humanoid")
    
    -- Pembersihan Body Mover lama
    for _, v in pairs(Root:GetChildren()) do
        if v.Name == "WNDS_FlyVelocity" or v.Name == "WNDS_FlyGyro" then v:Destroy() end
    end
    
    local BV = Instance.new("BodyVelocity")
    BV.Name = "WNDS_FlyVelocity"
    BV.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    BV.Velocity = Vector3.new(0, 0, 0)
    BV.Parent = Root
    
    local BG = Instance.new("BodyGyro")
    BG.Name = "WNDS_FlyGyro"
    BG.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    BG.P = 90000
    BG.CFrame = Root.CFrame
    BG.Parent = Root
    
    if Hum then Hum.PlatformStand = true end

    task.spawn(function()
        while _G.FlyEnabled and Character:FindFirstChild("HumanoidRootPart") do
            local MoveDirection = Vector3.new(0, 0, 0)
            local CamCF = Camera.CFrame
            
            -- Input Logic (Request Raize)
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then MoveDirection += CamCF.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then MoveDirection -= CamCF.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then MoveDirection -= CamCF.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then MoveDirection += CamCF.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.E) then MoveDirection += Vector3.new(0, 1, 0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.Q) then MoveDirection -= Vector3.new(0, 1, 0) end
            
            if MoveDirection.Magnitude > 0 then
                BV.Velocity = MoveDirection.Unit * _G.FlySpeed
            else
                BV.Velocity = Vector3.new(0, 0, 0)
            end
            
            BG.CFrame = CamCF
            RunService.RenderStepped:Wait()
        end
        
        -- Cleanup
        if BV then BV:Destroy() end
        if BG then BG:Destroy() end
        if Hum then Hum.PlatformStand = false end
    end)
end

-- // --- MAIN LOOP (60 FPS+) ---
RunService.RenderStepped:Connect(function()
    pcall(ApplyMovement)
end)

-- // --- UI RENDERING (Window harus dipanggil di sini) ---
local PlayerTab = Window:Tab({
    Title = "Player",
    Icon = "solar:user-bold",
    Border = true,
})

-- SECTION 1: MOVEMENT
local MoveSec = PlayerTab:Section({ Title = "Movement Modification" })

MoveSec:Toggle({
    Title = "Enable Custom Movement",
    Callback = function(v) _G.MovementEnabled = v end,
})

MoveSec:Slider({
    Title = "WalkSpeed",
    Value = { Min = 16, Max = 500, Default = 16 },
    Callback = function(v) _G.WalkSpeedValue = v end,
})

MoveSec:Slider({
    Title = "JumpPower",
    Value = { Min = 50, Max = 1000, Default = 50 },
    Callback = function(v) _G.JumpPowerValue = v end,
})

-- SECTION 2: FLIGHT
local FlySec = PlayerTab:Section({ Title = "Flight Control" })

FlySec:Toggle({
    Title = "Static Flight (Fly)",
    Desc = "WASD = Move | E = Up | Q = Down",
    Callback = function(v)
        _G.FlyEnabled = v
        if v then StartFlight() end
    end,
})

FlySec:Slider({
    Title = "Fly Speed",
    Value = { Min = 10, Max = 500, Default = 50 },
    Callback = function(v) _G.FlySpeed = v end,
})
