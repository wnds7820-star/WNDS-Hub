local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

local PlayerTab = Window:Tab({
    Title = "Player",
    Icon = "solar:user-bold",
    Border = true,
})

local MainSection = PlayerTab:Section({ Title = "Movement" })

MainSection:Slider({
    Title = "WalkSpeed",
    Step = 1,
    Value = { Min = 16, Max = 500, Default = 16 },
    Callback = function(v) 
        pcall(function() Player.Character.Humanoid.WalkSpeed = v end) 
    end,
})

MainSection:Slider({
    Title = "JumpPower",
    Step = 1,
    Value = { Min = 50, Max = 500, Default = 50 },
    Callback = function(v) 
        pcall(function() 
            Player.Character.Humanoid.UseJumpPower = true
            Player.Character.Humanoid.JumpPower = v 
        end) 
    end,
})

local ExtraSection = PlayerTab:Section({ Title = "Abilities" })

ExtraSection:Toggle({
    Title = "Infinite Jump",
    Callback = function(v) _G.InfJump = v end,
})

ExtraSection:Toggle({
    Title = "Noclip",
    Desc = "Bisa tembus tembok",
    Callback = function(v) _G.Noclip = v end,
})

-- Logika Noclip & InfJump
game:GetService("RunService").Stepped:Connect(function()
    if _G.Noclip then
        for _, v in pairs(Player.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
end)
