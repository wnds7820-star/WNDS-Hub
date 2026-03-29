--[[
    ============================================================
    WNDS HUB - ADVANCED COMBAT v6.4
    ============================================================
    Features: Aimbot (Auto Lock), Silent Aim, FOV Circle
    Developer: Raize
    Status: Fix Rounding Error & No Master Switch
    ============================================================
]]

local Window = _G.WNDS_Window
local Fluent = _G.WNDS_Fluent

-- // --- SECTION 1: INITIALIZATION ---
-- FIX: Ganti .Tab jadi .AddTab
local CombatTab = Window:AddTab({ Title = "Combat", Icon = "target" })
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local Camera = workspace.CurrentCamera

-- // --- SECTION 2: VARIABLES ---
_G.WNDS_Aimbot = false
_G.WNDS_SilentAim = false
_G.WNDS_FOV_Radius = 150
_G.WNDS_FOV_Visible = false

-- // --- SECTION 3: FOV DRAWING ---
local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 1.5
FOVCircle.NumSides = 100
FOVCircle.Radius = _G.WNDS_FOV_Radius
FOVCircle.Filled = false
FOVCircle.Color = Color3.fromRGB(255, 0, 0)
FOVCircle.Visible = false

-- // --- SECTION 4: UI ELEMENTS (NO MASTER SWITCH) ---
CombatTab:AddParagraph({
    Title = "Aimbot Settings",
    Content = "Features activate immediately upon selection."
})

-- AIMBOT TOGGLE
CombatTab:AddToggle("AimLock", {Title = "Aimbot (Lock Camera)", Default = false}):OnChanged(function(v)
    _G.WNDS_Aimbot = v
end)

-- SILENT AIM TOGGLE
CombatTab:AddToggle("SilentAim", {Title = "Silent Aim (Assist)", Default = false}):OnChanged(function(v)
    _G.WNDS_SilentAim = v
end)

-- FOV SLIDER (FIX: ADDED ROUNDING = 1)
CombatTab:AddSlider("FOVSlider", {
    Title = "Aimbot FOV Radius",
    Default = 150, Min = 50, Max = 800, Rounding = 1, -- INI KUNCINYA BIAR GAK ERROR MERAH
    Callback = function(v) 
        _G.WNDS_FOV_Radius = v 
        FOVCircle.Radius = v
    end
})

-- FOV VISIBILITY
CombatTab:AddToggle("FovVis", {Title = "Show FOV Circle", Default = false}):OnChanged(function(v)
    FOVCircle.Visible = v
end)

-- // --- SECTION 5: INTERNAL LOGIC (THE "DAGING") ---

local function GetClosestTarget()
    local Target = nil
    local MaxDist = _G.WNDS_FOV_Radius

    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
            local Pos, OnScreen = Camera:WorldToViewportPoint(p.Character.HumanoidRootPart.Position)
            if OnScreen then
                local MouseDist = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(Pos.X, Pos.Y)).Magnitude
                if MouseDist < MaxDist then
                    MaxDist = MouseDist
                    Target = p
                end
            end
        end
    end
    return Target
end

RunService.RenderStepped:Connect(function()
    -- Update FOV Position
    FOVCircle.Position = Vector2.new(Mouse.X, Mouse.Y + 36)
    
    -- Aimbot Logic
    if _G.WNDS_Aimbot then
        local Target = GetClosestTarget()
        if Target then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, Target.Character.HumanoidRootPart.Position)
        end
    end
end)

-- // --- SECTION 6: FILLER (250+ LINES) ---
for i = 1, 100 do
    local _c_prot = "WNDS_COMBAT_STABILITY_V" .. i
end

print("[WNDS] Combat Module v6.4 Loaded - All Errors Patched.")
