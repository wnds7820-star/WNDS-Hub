--[[
    WNDS HUB - COMBAT MODULE v6.6
    Features: Smooth Aimbot, FOV, No Master Switch
]]
local CombatTab = _G.WNDS_Window:AddTab({ Title = "Combat", Icon = "target" })
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local Mouse = game.Players.LocalPlayer:GetMouse()

_G.WNDS_Aimbot = false
_G.WNDS_Smoothness = 0.1
_G.WNDS_FOV_Radius = 150

CombatTab:AddToggle("AimLock", {Title = "Enable Aimbot", Default = false}):OnChanged(function(v)
    _G.WNDS_Aimbot = v
end)

CombatTab:AddSlider("SmoothSlider", {
    Title = "Aimbot Smoothness",
    Default = 0.1, Min = 0.01, Max = 1, Rounding = 2,
    Callback = function(v) _G.WNDS_Smoothness = v end
})

CombatTab:AddSlider("FOVSlider", {
    Title = "Aimbot FOV",
    Default = 150, Min = 50, Max = 800, Rounding = 1,
    Callback = function(v) _G.WNDS_FOV_Radius = v end
})

local function GetClosest()
    local target = nil
    local dist = _G.WNDS_FOV_Radius
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= game.Players.LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local pos, os = Camera:WorldToViewportPoint(p.Character.HumanoidRootPart.Position)
            if os then
                local mDist = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(pos.X, pos.Y)).Magnitude
                if mDist < dist then
                    dist = mDist
                    target = p
                end
            end
        end
    end
    return target
end

RunService.RenderStepped:Connect(function()
    if _G.WNDS_Aimbot then
        local target = GetClosest()
        if target then
            local targetPos = CFrame.new(Camera.CFrame.Position, target.Character.HumanoidRootPart.Position)
            -- Logic Smooth menggunakan Lerp
            Camera.CFrame = Camera.CFrame:Lerp(targetPos, _G.WNDS_Smoothness)
        end
    end
end)
