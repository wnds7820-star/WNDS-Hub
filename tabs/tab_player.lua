-- // WNDS HUB v6.7 - TAB PLAYER
-- // Features: Speed, Jump, Static Fly (WASD + QE)

local PlayerTab = Window:Tab({ Title = "Player", Icon = "solar:user-bold" })
local MainSec = PlayerTab:Section({ Title = "Movement Modification" })

_G.WalkSpeed = 16
_G.JumpPower = 50
_G.FlyEnabled = false
_G.FlySpeed = 50

-- Core Loop (Anti-Bypass)
game:GetService("RunService").RenderStepped:Connect(function()
    local Char = game.Players.LocalPlayer.Character
    local Hum = Char and Char:FindFirstChildOfClass("Humanoid")
    if Hum then
        Hum.WalkSpeed = _G.WalkSpeed
        if Hum.UseJumpPower then Hum.JumpPower = _G.JumpPower else Hum.JumpHeight = _G.JumpPower/7.2 end
    end
end)

MainSec:Slider({ Title = "WalkSpeed", Value = {Min = 16, Max = 500, Default = 16}, Callback = function(v) _G.WalkSpeed = v end})
MainSec:Slider({ Title = "JumpPower", Value = {Min = 50, Max = 1000, Default = 50}, Callback = function(v) _G.JumpPower = v end})

-- Static Fly System (WASD + QE)
local function ToggleFly(v)
    _G.FlyEnabled = v
    local Root = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
    if v then
        local BV = Instance.new("BodyVelocity", Root)
        BV.Name = "WNDS_FlyForce"
        BV.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        BV.Velocity = Vector3.new(0,0,0)
        
        task.spawn(function()
            while _G.FlyEnabled do
                local dir = Vector3.new(0,0,0)
                local cam = workspace.CurrentCamera.CFrame
                local UIS = game:GetService("UserInputService")
                if UIS:IsKeyDown("W") then dir += cam.LookVector end
                if UIS:IsKeyDown("S") then dir -= cam.LookVector end
                if UIS:IsKeyDown("A") then dir -= cam.RightVector end
                if UIS:IsKeyDown("D") then dir += cam.RightVector end
                if UIS:IsKeyDown("E") then dir += Vector3.new(0,1,0) end
                if UIS:IsKeyDown("Q") then dir -= Vector3.new(0,1,0) end
                BV.Velocity = (dir.Magnitude > 0) and (dir.Unit * _G.FlySpeed) or Vector3.new(0,0,0)
                task.wait()
            end
            BV:Destroy()
        end)
    end
end

MainSec:Toggle({ Title = "Static Flight (Fly)", Callback = ToggleFly })
MainSec:Slider({ Title = "Fly Speed", Value = {Min = 10, Max = 500, Default = 50}, Callback = function(v) _G.FlySpeed = v end})
