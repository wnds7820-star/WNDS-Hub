--[[
    ============================================================
    WNDS HUB - PLAYER MODULE v6.0
    ============================================================
    Features: Speed, Jump, Fly, Noclip, Infinite Jump
    Developer: Raize
    ============================================================
]]

local Window = _G.WNDS_Window
local Fluent = _G.WNDS_Fluent

-- // --- SECTION 1: INITIALIZATION ---
local PlayerTab = Window:AddTab({ Title = "Player", Icon = "user" })
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- // --- SECTION 2: PLAYER VARIABLES ---
_G.WNDS_WalkSpeed = 16
_G.WNDS_JumpPower = 50
_G.WNDS_InfJump = false
_G.WNDS_Noclip = false
_G.WNDS_FlyEnabled = false
_G.WNDS_FlySpeed = 50

-- // --- SECTION 3: UI ELEMENTS (LONG & DETAILED) ---
PlayerTab:AddParagraph({
    Title = "Character Physics",
    Content = "Adjust your movement speed and jump height safely."
})

local ToggleSpeed = PlayerTab:AddToggle("SpeedToggle", {Title = "Enable Speed & Jump Power", Default = false})

PlayerTab:AddSlider("WalkSpeedSlider", {
    Title = "WalkSpeed",
    Description = "Default speed is 16",
    Default = 16, Min = 16, Max = 500, Rounding = 1, -- FIX ROUNDING ERROR
    Callback = function(Value) _G.WNDS_WalkSpeed = Value end
})

PlayerTab:AddSlider("JumpPowerSlider", {
    Title = "JumpPower",
    Description = "Default power is 50",
    Default = 50, Min = 50, Max = 1000, Rounding = 1, -- FIX ROUNDING ERROR
    Callback = function(Value) _G.WNDS_JumpPower = Value end
})

PlayerTab:AddParagraph({
    Title = "Advanced Exploration",
    Content = "Special movement features for map exploration."
})

local ToggleInfJump = PlayerTab:AddToggle("InfJumpToggle", {Title = "Infinite Jump", Default = false})
ToggleInfJump:OnChanged(function() _G.WNDS_InfJump = ToggleInfJump.Value end)

local ToggleNoclip = PlayerTab:AddToggle("NoclipToggle", {Title = "Noclip (Wall Hack)", Default = false})
ToggleNoclip:OnChanged(function() _G.WNDS_Noclip = ToggleNoclip.Value end)

local ToggleFly = PlayerTab:AddToggle("FlyToggle", {Title = "Flight Mode (WASD+QE)", Default = false})

PlayerTab:AddSlider("FlySpeedSlider", {
    Title = "Flight Speed",
    Default = 50, Min = 10, Max = 300, Rounding = 1,
    Callback = function(Value) _G.WNDS_FlySpeed = Value end
})

-- // --- SECTION 4: INTERNAL LOGIC (THE "DAGING" CODING) ---

-- 1. WalkSpeed & JumpPower Loop
RunService.Stepped:Connect(function()
    pcall(function()
        if ToggleSpeed.Value and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            local Hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            Hum.WalkSpeed = _G.WNDS_WalkSpeed
            if Hum.UseJumpPower then 
                Hum.JumpPower = _G.WNDS_JumpPower 
            else 
                Hum.JumpHeight = _G.WNDS_JumpPower / 7.2 
            end
        end
    end)
end)

-- 2. Infinite Jump Logic
UserInputService.JumpRequest:Connect(function()
    if _G.WNDS_InfJump then
        LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end)

-- 3. Noclip Logic
RunService.Stepped:Connect
