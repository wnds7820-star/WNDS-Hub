--[[
    WNDS HUB - COMBAT MODULE v6.7
    Features: Smooth Aimbot (Lerp), FOV Circle, No Master Switch
]]
local CombatTab = _G.WNDS_Window:AddTab({ Title = "Combat", Icon = "target" })
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local Mouse = game.Players.LocalPlayer:GetMouse()

_G.WNDS_Aimbot = false
_G.WNDS_Smoothness = 0.1 -- Nilai Default
_G.WNDS_FOV_Radius = 150

CombatTab:AddParagraph({ Title = "Combat Assistance", Content = "Configure your aimbot smoothness and FOV." })

-- Toggle Langsung Aktif
CombatTab:AddToggle("AimLock", {Title = "Enable Aimbot Lock", Default = false}):OnChanged(function(v)
    _G.WNDS_Aimbot = v
end)

-- Slider Smooth (FIX: Rounding = 2 untuk presisi halus)
CombatTab:AddSlider("SmoothSlider", {
    Title = "Aimbot Smoothness (Lerp)",
    Description = "Higher = Smoother/Slow. Recommended: 0.05 - 0.2",
    Default = 0.1, Min = 0.01, Max = 1, Rounding = 2,
    Callback = function(v) _G.WNDS_Smoothness = v end
})

-- Slider FOV (FIX: Rounding = 1)
CombatTab:AddSlider("FOVSlider", {
    Title = "Aimbot FOV Radius",
    Default = 150, Min = 50, Max = 800, Rounding = 1,
    Callback = function(v) _G.WNDS_FOV_Radius = v end
})

-- Logika Mencari Target Terdekat
local function GetClosestTarget()
    local target = nil
    local shortestDist = _G.WNDS_FOV_Radius
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= game.Players.LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
            local pos, onScreen = Camera:WorldToViewportPoint(p.Character.HumanoidRootPart.Position)
            if onScreen then
                local dist = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(pos.X, pos.Y)).Magnitude
                if dist < shortestDist then
                    shortestDist = dist
                    target = p
                end
            end
        end
    end
    return target
end

-- Render Loop untuk Smooth Aimbot
RunService.RenderStepped:Connect(function()
    if _G.WNDS_Aimbot then
        local target = GetClosestTarget()
        if target then
            local targetCF = CFrame.new(Camera.CFrame.Position, target.Character.HumanoidRootPart.Position)
            -- SMOOTHING ENGINE: Menggunakan LERP agar transisi kamera halus
            Camera.CFrame = Camera.CFrame:Lerp(targetCF, _G.WNDS_Smoothness)
        end
    end
end)

print("[WNDS] Combat Module Loaded - Smooth Aimbot Active.")
