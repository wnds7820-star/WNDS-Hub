--[[
    ============================================================
    WNDS HUB - COMBAT MODULE v6.0
    ============================================================
    Features: Aimbot, Silent Aim, Hitbox Expander, FOV
    Developer: Raize
    ============================================================
]]

local Window = _G.WNDS_Window
local Fluent = _G.WNDS_Fluent

-- // --- SECTION 1: INITIALIZATION ---
local CombatTab = Window:AddTab({ Title = "Combat", Icon = "target" })
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local Camera = workspace.CurrentCamera

-- // --- SECTION 2: COMBAT VARIABLES ---
_G.WNDS_AimbotEnabled = false
_G.WNDS_SilentAim = false
_G.WNDS_HitboxEnabled = false
_G.WNDS_HitboxSize = 2
_G.WNDS_FOV_Visible = false
_G.WNDS_FOV_Radius = 150

-- // --- SECTION 3: FOV CIRCLE DRAWING ---
local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 1
FOVCircle.NumSides = 100
FOVCircle.Radius = _G.WNDS_FOV_Radius
FOVCircle.Filled = false
FOVCircle.Visible = false
FOVCircle.Color = Color3.fromRGB(255, 255, 255)

-- // --- SECTION 4: UI ELEMENTS ---
CombatTab:AddParagraph({
    Title = "Combat Assistance",
    Content = "Enhance your accuracy and reach in battles."
})

local ToggleAimbot = CombatTab:AddToggle("AimbotToggle", {Title = "Enable Aimbot (Lock)", Default = false})
ToggleAimbot:OnChanged(function() _G.WNDS_AimbotEnabled = ToggleAimbot.Value end)

local ToggleSilent = CombatTab:AddToggle("SilentAimToggle", {Title = "Silent Aim (Assist)", Default = false})
ToggleSilent:OnChanged(function() _G.WNDS_SilentAim = ToggleSilent.Value end)

CombatTab:AddSlider("FOV_Slider", {
    Title = "Field of View Radius",
    Default = 150, Min = 50, Max = 800, Rounding = 1,
    Callback = function(v) 
        _G.WNDS_FOV_Radius = v 
        FOVCircle.Radius = v
    end
})

CombatTab:AddToggle("ShowFOV", {Title = "Show FOV Circle", Default = false}):OnChanged(function(v)
    FOVCircle.
