--[[
    WNDS HUB - COMBAT MODULE v6.6
    Added: Smoothness Logic for Aimbot
]]
local CombatTab = _G.WNDS_Window:AddTab({ Title = "Combat", Icon = "target" })
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

_G.WNDS_Aimbot = false
_G.WNDS_Smoothness = 0.1 -- Default Smoothness
_G.WNDS_FOV_Radius = 150

CombatTab:AddParagraph({ Title = "Aimbot Assistance", Content = "Now with Smooth Motion technology." })

CombatTab:AddToggle("AimLock", {Title = "Enable Aimbot", Default = false}):OnChanged(function(v)
    _G.WNDS_Aimbot = v
end)

CombatTab:AddSlider("SmoothSlider", {
    Title = "Aimbot Smoothness",
    Description = "Higher = Smoother/Slower lock",
    Default = 0.1, Min = 0.01, Max = 1, Rounding = 2, -- Menggunakan 2 desimal
    Callback = function(v) _G.WNDS_Smoothness = v end
})

CombatTab:AddSlider("FOVSlider", {
    Title = "Aimbot FOV",
    Default = 150, Min = 50, Max = 800, Rounding = 1,
    Callback = function(v) _G.WNDS_FOV_Radius = v end
})

-- LOGIKA SMOOTH AIMBOT
local function GetClosest()
    local target = nil
    local dist = _G.WNDS_FOV_Radius
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local pos, os = Camera:WorldToViewportPoint(p.Character.HumanoidRootPart.Position)
            if os then
                local mDist = (Vector2.new(game:GetService("Players").LocalPlayer:GetMouse().X, game:GetService("Players").LocalPlayer:GetMouse().Y) - Vector2.new(pos.X, pos.Y)).Magnitude
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
            -- LOGIKA SMOOTHING (Lerp)
            local targetPos = CFrame.new(Camera.CFrame.Position, target.Character.HumanoidRootPart.Position)
            Camera.CFrame = Camera.CFrame:Lerp(targetPos, _G.WNDS_Smoothness)
        end
    end
end)
