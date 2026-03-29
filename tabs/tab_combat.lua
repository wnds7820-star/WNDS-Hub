--[[
    WNDS HUB - COMBAT MODULE (ULTRA HYBRID)
    Features: Smooth Aimbot (Lerp) + Silent Aim (Hook)
    Fix: Added Precise Rounding & FOV Rendering
    Developer: Raize
]]

local CombatTab = _G.WNDS_Window:AddTab({ Title = "Combat", Icon = "crosshair" })
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local Mouse = game.Players.LocalPlayer:GetMouse()
local LocalPlayer = game.Players.LocalPlayer

-- // GLOBAL SETTINGS
_G.WNDS_Aimbot = false
_G.WNDS_SilentAim = false
_G.WNDS_Smoothness = 0.1
_G.WNDS_FOV_Radius = 150
_G.WNDS_ShowFOV = false
_G.WNDS_AimPart = "Head"

-- // UI: AIMBOT SECTION
local AimSec = CombatTab:AddSection("Aimbot Assistance")

AimSec:AddToggle("AimLock", {Title = "Enable Smooth Aimbot", Default = false}):OnChanged(function(v) _G.WNDS_Aimbot = v end)

AimSec:AddSlider("SmoothSlider", {
    Title = "Aimbot Smoothness (Lerp)",
    Description = "Lower = Faster / Higher = Smoother",
    Default = 0.1, Min = 0.01, Max = 1, Rounding = 2,
    Callback = function(v) _G.WNDS_Smoothness = v end
})

-- // UI: SILENT AIM SECTION
local SilentSec = CombatTab:AddSection("Silent Aim (Method: Index)")

SilentSec:AddToggle("SAim", {Title = "Enable Silent Aim", Default = false}):OnChanged(function(v) _G.WNDS_SilentAim = v end)

SilentSec:AddDropdown("AimPart", {
    Title = "Aim Target Part",
    Values = {"Head", "HumanoidRootPart"},
    Default = "Head",
    Callback = function(v) _G.WNDS_AimPart = v end
})

-- // UI: FOV SETTINGS
local FovSec = CombatTab:AddSection("FOV Settings")

FovSec:AddToggle("ShowFOV", {Title = "Show FOV Circle", Default = false}):OnChanged(function(v) _G.WNDS_ShowFOV = v end)

FovSec:AddSlider("FOVSlider", {
    Title = "Aim FOV Radius",
    Default = 150, Min = 50, Max = 800, Rounding = 1,
    Callback = function(v) _G.WNDS_FOV_Radius = v end
})

-- // DRAW FOV CIRCLE (Rendering)
local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 1.5
FOVCircle.Filled = false
FOVCircle.Color = Color3.fromRGB(0, 255, 255)
FOVCircle.Transparency = 0.7

-- // LOGIKA MENCARI TARGET TERDEKAT
local function GetClosestTarget()
    local target = nil
    local shortestDist = _G.WNDS_FOV_Radius
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild(_G.WNDS_AimPart) and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
            local pos, onScreen = Camera:WorldToViewportPoint(p.Character[_G.WNDS_AimPart].Position)
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

-- // RENDER LOOP: SMOOTH AIMBOT & FOV
RunService.RenderStepped:Connect(function()
    -- Update FOV Circle
    FOVCircle.Visible = _G.WNDS_ShowFOV
    FOVCircle.Radius = _G.WNDS_FOV_Radius
    FOVCircle.Position = Vector2.new(Mouse.X, Mouse.Y + 36)

    -- Smooth Aimbot Logic
    if _G.WNDS_Aimbot then
        local target = GetClosestTarget()
        if target then
            local targetCF = CFrame.new(Camera.CFrame.Position, target.Character[_G.WNDS_AimPart].Position)
            Camera.CFrame = Camera.CFrame:Lerp(targetCF, _G.WNDS_Smoothness)
        end
    end
end)

-- // CORE SILENT AIM (METAMETHOD HOOK)
local OldIndex = nil
OldIndex = hookmetamethod(game, "__index", function(Self, Index)
    if not checkcaller() and _G.WNDS_SilentAim and Index == "Hit" then
        local target = GetClosestTarget()
        if target then
            return target.Character[_G.WNDS_AimPart].CFrame
        end
    end
    return OldIndex(Self, Index)
end)

print("[WNDS] Combat Hybrid Loaded - Aimbot & Silent Aim Active.")
