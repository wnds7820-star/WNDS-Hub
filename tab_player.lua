-- // WNDS HUB - PLAYER MODULE (FIXED)
local Tabs = _G.WNDS_UI.Tabs
local LP = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")

_G.InfJump = false
_G.Noclip = false

Tabs.Player:Section({ Title = "Movement" })

-- 1. WalkSpeed
Tabs.Player:Slider({
    Title = "WalkSpeed",
    Step = 1, Value = {Min = 16, Max = 500, Default = 16},
    Callback = function(v) 
        if LP.Character and LP.Character:FindFirstChild("Humanoid") then
            LP.Character.Humanoid.WalkSpeed = v 
        end
    end,
})

-- 2. JumpPower
Tabs.Player:Slider({
    Title = "JumpPower",
    Step = 1, Value = {Min = 50, Max = 500, Default = 50},
    Callback = function(v) 
        if LP.Character and LP.Character:FindFirstChild("Humanoid") then
            LP.Character.Humanoid.JumpPower = v 
        end
    end,
})

-- 3. Infinite Jump Logic
Tabs.Player:Toggle({
    Title = "Infinite Jump",
    Callback = function(v) _G.InfJump = v end,
})

UIS.JumpRequest:Connect(function()
    if _G.InfJump and LP.Character and LP.Character:FindFirstChild("Humanoid") then
        LP.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

-- 4. Noclip Logic
Tabs.Player:Toggle({
    Title = "Noclip",
    Callback = function(v) _G.Noclip = v end,
})

game:GetService("RunService").Stepped:Connect(function()
    if _G.Noclip and LP.Character then
        for _, part in pairs(LP.Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
end)

-- 5. Anti-AFK (Biar nggak kena kick kalau diem lama)
Tabs.Player:Button({
    Title = "Enable Anti-AFK",
    Callback = function()
        local vu = game:GetService("VirtualUser")
        LocalPlayer.Idled:Connect(function()
            vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
            task.wait(1)
            vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        end)
    end,
})

-- 6. Gravity Slider (Bisa loncat melayang)
Tabs.Player:Slider({
    Title = "Gravity Control",
    Step = 1, Value = {Min = 0, Max = 196, Default = 196},
    Callback = function(v) workspace.Gravity = v end,
})

-- 7. Sit Toggle (Biar nggak bisa jatuh/ragdoll di beberapa game)
Tabs.Player:Toggle({
    Title = "Anti-Sit",
    Callback = function(v) 
        LocalPlayer.Character.Humanoid.Sit = false
        LocalPlayer.Character.Humanoid:GetPropertyChangedSignal("Sit"):Connect(function()
            if v then LocalPlayer.Character.Humanoid.Sit = false end
        end)
    end,
})
