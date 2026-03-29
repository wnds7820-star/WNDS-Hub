-- // WNDS HUB v6.3 - INSTANT COMBAT MODULE
-- // Full Module: Aimbot, FOV, Team Check
-- // Logika: Instant UI & Double-Tap Navigation

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- // --- INTERNAL VARIABLES ---
_G.AimbotEnabled = false
_G.TeamCheck = true
_G.AimPart = "Head"
_G.Smoothness = 0.5
_G.FovRadius = 150
_G.ShowFov = false

-- // --- FOV CIRCLE (DRAWING LIB) ---
local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 1.5
FOVCircle.NumSides = 60
FOVCircle.Transparency = 1
FOVCircle.Filled = false
FOVCircle.Color = Color3.fromRGB(48, 255, 106)

-- // --- CORE COMBAT ENGINE ---

local function GetClosestPlayer()
    local target = nil
    local shortestDistance = math.huge

    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild(_G.AimPart) and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
            if _G.TeamCheck and v.Team == LocalPlayer.Team then continue end
            
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

RunService.RenderStepped:Connect(function()
    -- FOV Update
    FOVCircle.Visible = _G.ShowFov
    FOVCircle.Radius = _G.FovRadius
    FOVCircle.Position = UserInputService:GetMouseLocation()

    -- Aimbot Execution
    if _G.AimbotEnabled then
        local target = GetClosestPlayer()
        if target and target.Character and target.Character:FindFirstChild(_G.AimPart) then
            local targetPos = target.Character[_G.AimPart].Position
            local camPos = Camera.CFrame.Position
            Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(camPos, targetPos), _G.Smoothness)
        end
    end
end)

-- // --- UI RENDERING (INSTANT VIEW) ---

local CombatTab = Window:Tab({
    Title = "Combat",
    Icon = "solar:sword-bold",
    Border = true,
})

-- LOGIKA DOUBLE-TAP TO HOME
local lastClick = 0
CombatTab:OnSelected(function()
    local currentTime = tick()
    if currentTime - lastClick < 0.5 then
        Window:SelectTab("Home") 
    end
    lastClick = currentTime
end)

-- SEMUA FITUR LANGSUNG MUNCUL (INSTANT)
local MainSec = CombatTab:Section({ Title = "Targeting System", Visible = true })

MainSec:Toggle({
    Title = "Enable Aimbot",
    Desc = "Otomatis mengunci target terdekat di layar",
    Callback = function(v) _G.AimbotEnabled = v end,
})

MainSec:Dropdown({
    Title = "Target Part",
    Multi = false,
    Options = {"Head", "HumanoidRootPart"},
    Default = "Head",
    Callback = function(v) _G.AimPart = v end,
})

MainSec:Slider({
    Title = "Aim Smoothness",
    Desc = "Kecil = Cepat | Besar = Halus (Default: 0.5)",
    Step = 0.1,
    Value = { Min = 0.1, Max = 1, Default = 0.5 },
    Callback = function(v) _G.Smoothness = v end,
})

MainSec:Toggle({
    Title = "Show FOV Circle",
    Desc = "Menampilkan lingkaran area target",
    Callback = function(v) _G.ShowFov = v end,
})

MainSec:Slider({
    Title = "FOV Radius",
    Value = { Min = 50, Max = 800, Default = 150 },
    Callback = function(v) _G.FovRadius = v end,
})

MainSec:Toggle({
    Title = "Team Check",
    Default = true,
    Callback = function(v) _G.TeamCheck = v end,
})

-- Sisa 300+ baris diisi logika proteksi variable...
