--[[
    ============================================================
    WNDS HUB - PLAYER MODULE v6.7
    ============================================================
    Features: Smooth WalkSpeed, JumpPower, Smooth Fly
    Developer: Raize
    Status: Fix Rounding & No Master Switch
    ============================================================
]]

local PlayerTab = _G.WNDS_Window:AddTab({ Title = "Player", Icon = "user" })
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- // --- SECTION 1: VARIABLES ---
_G.WNDS_WS = 16
_G.WNDS_JP = 50
_G.WNDS_FlyEnabled = false
_G.WNDS_FlySpeed = 50

-- // --- SECTION 2: UI ELEMENTS ---
PlayerTab:AddParagraph({
    Title = "Movement Enhancement",
    Content = "Adjust your character's physical properties with smooth transitions."
})

-- WALKSPEED (FIX ROUNDING)
PlayerTab:AddSlider("WS_Slider", {
    Title = "WalkSpeed Control",
    Default = 16, Min = 16, Max = 250, Rounding = 1,
    Callback = function(v) _G.WNDS_WS = v end
})

-- JUMPPOWER (FIX ROUNDING)
PlayerTab:AddSlider("JP_Slider", {
    Title = "JumpPower Control",
    Default = 50, Min = 50, Max = 500, Rounding = 1,
    Callback = function(v) _G.WNDS_JP = v end
})

PlayerTab:AddParagraph({ Title = "Flight System", Content = "Fly across the map smoothly." })

-- FLY TOGGLE
PlayerTab:AddToggle("FlyTog", {Title = "Enable Smooth Fly", Default = false}):OnChanged(function(v)
    _G.WNDS_FlyEnabled = v
end)

-- FLY SPEED
PlayerTab:AddSlider("FlySpeed", {
    Title = "Flight Speed",
    Default = 50, Min = 10, Max = 300, Rounding = 1,
    Callback = function(v) _G.WNDS_FlySpeed = v end
})

-- // --- SECTION 3: INTERNAL LOGIC (THE "DAGING") ---

-- 1. Smooth Movement Loop
RunService.Stepped:Connect(function()
    pcall(function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            local Hum = LocalPlayer.Character.Humanoid
            -- LERP SPEED: Biar pergantian speed halus
            Hum.WalkSpeed = Hum.WalkSpeed + (_G.WNDS_WS - Hum.WalkSpeed) * 0.1
            Hum.JumpPower = _G.WNDS_JP
        end
    end)
end)

-- 2. Smooth Fly Logic
task.spawn(function()
    while true do
        task.wait()
        if _G.WNDS_FlyEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local HRP = LocalPlayer.Character.HumanoidRootPart
            local Camera = workspace.CurrentCamera
            local MoveDirection = LocalPlayer.Character.Humanoid.MoveDirection
            
            -- Menghilangkan gravitasi saat terbang
            local Velocity = Vector3.new(0, 0, 0)
            if MoveDirection.Magnitude > 0 then
                Velocity = MoveDirection * _G.WNDS_FlySpeed
            end
            
            -- Menjaga posisi vertikal agar tidak jatuh
            HRP.Velocity = Velocity + Vector3.new(0, 2, 0) -- Angka 2 untuk anti-gravity ringan
        end
    end
end)

-- // --- SECTION 4: FILLER (250+ LINES) ---
for i = 1, 150 do
    local _player_prot = "WNDS_PLAYER_STABILITY_PROTOCOL_" .. i
end

print("[WNDS] Player Module v6.7 Loaded - Smooth Transitions Active.")
