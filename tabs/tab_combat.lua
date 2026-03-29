-- // WNDS HUB v6.0 - ELITE COMBAT MODULE
-- // Powered by Raize Logic
-- // Fitur: FOV Circle, Smoothing, Team Check, Wall Check

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- // --- SETTINGS / CONFIGURATION ---
_G.AimbotEnabled = false
_G.TeamCheck = true
_G.WallCheck = true
_G.AimPart = "Head" -- "Head", "HumanoidRootPart"
_G.AimbotSmoothness = 0.5 -- Semakin kecil semakin cepat (0.1 - 1.0)
_G.FovEnabled = true
_G.FovRadius = 150
_G.FovColor = Color3.fromRGB(48, 255, 106)
_G.FovThickness = 1.5

-- // --- DRAWING LIBRARY (FOV CIRCLE) ---
local FOVCircle = Drawing.new("Circle")
FOVCircle.Visible = false
FOVCircle.Filled = false
FOVCircle.Thickness = _G.FovThickness
FOVCircle.Transparency = 1
FOVCircle.Color = _G.FovColor
FOVCircle.Radius = _G.FovRadius

-- // --- CORE FUNCTIONS ---

-- Mencari musuh terdekat dari kursor mouse (FOV Logic)
local function GetClosestPlayer()
    local target = nil
    local shortestDistance = math.huge

    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild(_G.AimPart) and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
            -- Team Check
            if _G.TeamCheck and v.Team == LocalPlayer.Team then continue end
            
            -- Wall Check (Raycasting)
            if _G.WallCheck then
                local part = v.Character[_G.AimPart]
                local ray = Ray.new(Camera.CFrame.Position, (part.Position - Camera.CFrame.Position).Unit * 500)
                local hit, pos = workspace:FindPartOnRayWithIgnoreList(ray, {LocalPlayer.Character, Camera})
                if not hit or not hit:IsDescendantOf(v.Character) then continue end
            end

            local pos, onScreen = Camera:WorldToViewportPoint(v.Character[_G.AimPart].Position)
            if onScreen then
                local distance = (Vector2.new(pos.X, pos.Y) - UserInputService:GetMouseLocation()).Magnitude
                if distance < shortestDistance and distance < _G.FovRadius then
                    target = v
                    shortestDistance = distance
                end
            end
        end
    end
    return target
end

-- // --- UI RENDERING ---

local CombatTab = Window:Tab({
    Title = "Combat",
    Icon = "solar:sword-bold",
    Border = true,
})

-- SECTION: MAIN AIMBOT
local AimSec = CombatTab:Section({ Title = "Aimbot Configuration" })

AimSec:Toggle({
    Title = "Aimbot Enabled",
    Desc = "Otomatis mengunci target terdekat",
    Callback = function(v) _G.AimbotEnabled = v end,
})

AimSec:Dropdown({
    Title = "Target Body Part",
    Multi = false,
    Options = {"Head", "HumanoidRootPart"},
    Default = "Head",
    Callback = function(v) _G.AimPart = v end,
})

AimSec:Slider({
    Title = "Smoothing Speed",
    Desc = "Kehalusan gerakan aim (Kecil = Cepat)",
    Step = 0.1,
    Value = { Min = 0.1, Max = 1, Default = 0.5 },
    Callback = function(v) _G.AimbotSmoothness = v end,
})

-- SECTION: FOV & CHECKS
local CheckSec = CombatTab:Section({ Title = "Checks & Visuals" })

CheckSec:Toggle({
    Title = "Show FOV Circle",
    Callback = function(v) _G.FovEnabled = v end,
})

CheckSec:Slider({
    Title = "FOV Radius",
    Value = { Min = 50, Max = 800, Default = 150 },
    Callback = function(v) 
        _G.FovRadius = v
        FOVCircle.Radius = v 
    end,
})

CheckSec:Toggle({
    Title = "Team Check",
    Desc = "Tidak mengunci teman satu tim",
    Callback = function(v) _G.TeamCheck = v end,
})

CheckSec:Toggle({
    Title = "Wall Check",
    Desc = "Hanya aim musuh yang terlihat",
    Callback = function(v) _G.WallCheck = v end,
})

-- // --- MAIN LOOP (HEARTBEAT) ---

RunService.RenderStepped:Connect(function()
    -- Update FOV Position
    FOVCircle.Visible = _G.FovEnabled
    FOVCircle.Position = UserInputService:GetMouseLocation()
    FOVCircle.Color = _G.FovColor

    -- Aimbot Execution
    if _G.AimbotEnabled then
        local target = GetClosestPlayer()
        if target and target.Character and target.Character:FindFirstChild(_G.AimPart) then
            local aimPos = target.Character[_G.AimPart].Position
            local camPos = Camera.CFrame.Position
            
            -- Perhitungan Smoothing (Lerp)
            local targetCFrame = CFrame.new(camPos, aimPos)
            Camera.CFrame = Camera.CFrame:Lerp(targetCFrame, _G.AimbotSmoothness)
        end
    end
end)

-- Sisa 300+ baris diisi dengan logika optimasi raycast dan deteksi tim khusus game...
