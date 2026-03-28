-- // WNDS HUB v5.4 - CORE FUNCTIONS
local Tabs = _G.WNDS_UI.Tabs
local LocalPlayer = game.Players.LocalPlayer
local RunService = game:GetService("RunService")

-- [ TAB: PLAYER ]
Tabs.Player:Slider({
    Title = "WalkSpeed",
    Step = 1, Value = { Min = 16, Max = 300, Default = 16 },
    Callback = function(v) if LocalPlayer.Character then LocalPlayer.Character.Humanoid.WalkSpeed = v end end,
})

Tabs.Player:Toggle({
    Title = "Infinite Jump",
    Callback = function(v) _G.InfJump = v end,
})

game:GetService("UserInputService").JumpRequest:Connect(function()
    if _G.InfJump and LocalPlayer.Character then
        LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

-- [ TAB: COMBAT ]
Tabs.Combat:Toggle({
    Title = "Hitbox Expander",
    Callback = function(v) _G.Hitbox = v end,
})

RunService.RenderStepped:Connect(function()
    if _G.Hitbox then
        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                p.Character.HumanoidRootPart.Size = Vector3.new(10, 10, 10)
                p.Character.HumanoidRootPart.Transparency = 0.7
                p.Character.HumanoidRootPart.CanCollide = false
            end
        end
    end
end)

-- [ TAB: VISUALS ]
Tabs.Visuals:Toggle({
    Title = "Player ESP",
    Callback = function(v) _G.ESP = v end,
})

RunService.RenderStepped:Connect(function()
    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local hl = p.Character:FindFirstChild("Highlight") or (_G.ESP and Instance.new("Highlight", p.Character))
            if hl then hl.Enabled = _G.ESP end
        end
    end
end)
