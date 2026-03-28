-- // WNDS HUB v5.4 - OPERATIONAL FEATURES (CORE)
-- // Creator: Raize (WNDS)

-- Ambil data penting dari Global Variables
local Window = _G.WNDS_UI.Window
local Tabs = _G.WNDS_UI.Tabs
local WindUI = _G.WNDS_UI.WindUI

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera

-- Global Feature States (Buat nyimpen status fitur on/off)
_G.InfJump = false
_G.Aimbot = false
_G.ESP = false
_G.Hitbox = false
_G.HitboxSize = 2
_G.Fly = false
_G.FlySpeed = 50

-- ==============================================
-- // TAB: COMBAT (Fitur PvP)
-- ==============================================
Tabs.Combat:Section({ Title = "Aim Assistance" })

Tabs.Combat:Toggle({
    Title = "Camera Aimbot (Closest)",
    Value = _G.Aimbot,
    Callback = function(v) _G.Aimbot = v end,
})

-- Logika Aimbot (Loop)
task.spawn(function()
    while task.wait() do
        if _G.Aimbot and LocalPlayer.Character then
            local closest = nil
            local dist = math.huge
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChild("Humanoid").Health > 0 then
                    local hrp = p.Character.HumanoidRootPart
                    local pos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
                    if onScreen then
                        local mag = (Vector2.new(pos.X, pos.Y) - UIS:GetMouseLocation()).Magnitude
                        if mag < dist then dist = mag; closest = p end
                    end
                end
            end
            if closest then
                Camera.CFrame = CFrame.new(Camera.CFrame.Position, closest.Character.HumanoidRootPart.Position)
            end
        end
    end
end)

Tabs.Combat:Section({ Title = "Hitbox" })

Tabs.Combat:Toggle({
    Title = "Enable Hitbox Expander",
    Value = _G.Hitbox,
    Callback = function(v) 
        _G.Hitbox = v 
        if not v then
            -- Reset hitbox kalo dimatiin
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
    Step = 1, Value = { Min = 2, Max = 50, Default = 10 },
    Callback = function(v) _G.HitboxSize = v end,
})

-- Logika Hitbox (Loop)
RunService.RenderStepped:Connect(function()
    if _G.Hitbox then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                p.Character.HumanoidRootPart.Size = Vector3.new(_G.HitboxSize, _G.HitboxSize, _G.HitboxSize)
                p.Character.HumanoidRootPart.Transparency = 0.7
                p.Character.HumanoidRootPart.CanCollide = false
            end
        end
    end
end)

-- ==============================================
-- // TAB: VISUALS (Fitur Liat Musuh)
-- ==============================================
Tabs.Visuals:Section({ Title = "Player ESP" })

Tabs.Visuals:Toggle({
    Title = "Enable ESP (Highlight)",
    Value = _G.ESP,
    Callback = function(v) 
        _G.ESP = v 
        if not v then
            for _, p in pairs(Players:GetPlayers()) do
                if p.Character and p.Character:FindFirstChild("Highlight") then p.Character.Highlight:Destroy() end
            end
        end
    end,
})

-- Logika ESP (Loop)
RunService.RenderStepped:Connect(function()
    if _G.ESP then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
                local hl = p.Character:FindFirstChild("Highlight") or Instance.new("Highlight", p.Character)
                hl.FillColor = Color3.fromHex("#7775F2")
                hl.OutlineColor = Color3.new(1, 1, 1)
                hl.FillTransparency = 0.5
            end
        end
    end
end)

-- ==============================================
-- // TAB: PLAYER (Fitur Pergerakan)
-- ==============================================
Tabs.Player:Section({ Title = "Movement Speed" })

Tabs.Player:Slider({
    Title = "WalkSpeed",
    Step = 1, Value = { Min = 16, Max = 250, Default = 16 },
    Callback = function(v) 
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then 
            LocalPlayer.Character.Humanoid.WalkSpeed = v 
        end 
    end,
})

Tabs.Player:Slider({
    Title = "JumpPower",
    Step = 1, Value = { Min = 50, Max = 300, Default = 50 },
    Callback = function(v) 
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then 
            LocalPlayer.Character.Humanoid.UseJumpPower = true
            LocalPlayer.Character.Humanoid.JumpPower = v 
        end 
    end,
})

Tabs.Player:Toggle({
    Title = "Infinite Jump",
    Value = _G.InfJump,
    Callback = function(v) _G.InfJump = v end,
})

-- Logika InfJump
UIS.JumpRequest:Connect(function()
    if _G.InfJump and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

Tabs.Player:Section({ Title = "Other" })

-- Fitur Noclip
Tabs.Player:Toggle({
    Title = "Noclip",
    Value = false,
    Callback = function(v)
        _G.Noclip = v
        if LocalPlayer.Character then
            for _, child in pairs(LocalPlayer.Character:GetDescendants()) do
                if child:IsA("BasePart") then child.CanCollide = not v end
            end
        end
    end,
})

-- ==============================================
-- // TAB: TELEPORT (Fitur Pindah Tempat)
-- ==============================================
Tabs.Teleport:Section({ Title = "Player Teleport" })

local SelectedPlayer = nil
local PlayerDropdown = Tabs.Teleport:Dropdown({
    Title = "Select Player",
    Values = {}, -- Kosong dulu, diisi otomatis
    Callback = function(v) SelectedPlayer = v end,
})

-- Fungsi Refresh List Pemain
local function RefreshPlayerList()
    local list = {}
    for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer then table.insert(list, p.Name) end end
    PlayerDropdown:Refresh(list)
end

Tabs.Teleport:Button({ Title = "Refresh Player List", Callback = RefreshPlayerList })

Tabs.Teleport:Button({
    Title = "Teleport to Player",
    Callback = function()
        local target = Players:FindFirstChild(SelectedPlayer)
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame
        end
    end,
})

-- ==============================================
-- // TAB: SETTINGS (Pengaturan UI)
-- ==============================================
Tabs.Settings:Section({ Title = "UI Options" })

Tabs.Settings:Keybind({
    Title = "Toggle UI Key",
    Value = "RightControl",
    Callback = function(key) Window:SetToggleKey(Enum.KeyCode[key]) end,
})

Tabs.Settings:Button({
    Title = "Destroy UI",
    Callback = function() Window:Destroy() end,
})

-- Auto refresh list player pas awal load tab teleport
RefreshPlayerList()

print("WNDS Hub Features: Loaded!")
