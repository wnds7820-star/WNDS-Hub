-- // WNDS HUB - COMBAT MODULE (FIXED)
local Tabs = _G.WNDS_UI.Tabs
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

-- Variables untuk status fitur
_G.Aimbot = false
_G.Hitbox = false
_G.HSize = 15
_G.HTrans = 0.7

Tabs.Combat:Section({ Title = "Aim Assistance" })

-- 1. Aimbot Logic
Tabs.Combat:Toggle({
    Title = "Camera Aimbot",
    Callback = function(v) _G.Aimbot = v end,
})

-- Fungsi pencari player terdekat
local function getClosestPlayer()
    local closest, dist = nil, math.huge
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local pos, onScreen = Camera:WorldToViewportPoint(p.Character.HumanoidRootPart.Position)
            if onScreen then
                local mag = (Vector2.new(pos.X, pos.Y) - game:GetService("UserInputService"):GetMouseLocation()).Magnitude
                if mag < dist then dist = mag; closest = p end
            end
        end
    end
    return closest
end

-- Looping Aimbot
RunService.RenderStepped:Connect(function()
    if _G.Aimbot then
        local target = getClosestPlayer()
        if target then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Character.HumanoidRootPart.Position)
        end
    end
end)

Tabs.Combat:Section({ Title = "Hitbox Expander" })

-- 2. Hitbox Logic
Tabs.Combat:Toggle({
    Title = "Enable Hitbox",
    Callback = function(v) 
        _G.Hitbox = v 
        if not v then -- Reset kalo dimatikan
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    p.Character.HumanoidRootPart.Size = Vector3.new(2, 2, 1)
                    p.Character.HumanoidRootPart.Transparency = 0
                end
            end
        end
    end,
})

Tabs.Combat:Slider({
    Title = "Hitbox Size",
    Step = 1, Value = {Min = 2, Max = 100, Default = 15},
    Callback = function(v) _G.HSize = v end,
})

-- Looping Hitbox
RunService.RenderStepped:Connect(function()
    if _G.Hitbox then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = p.Character.HumanoidRootPart
                hrp.Size = Vector3.new(_G.HSize, _G.HSize, _G.HSize)
                hrp.Transparency = _G.HTrans
                hrp.CanCollide = false
            end
        end
    end
end)
