-- // WNDS HUB - TELEPORT MODULE (FIXED)
local Tabs = _G.WNDS_UI.Tabs
local LP = game.Players.LocalPlayer
local Players = game:GetService("Players")

Tabs.Teleport:Section({ Title = "Quick Travel" })

Tabs.Teleport:Button({
    Title = "Teleport to Spawn",
    Callback = function()
        if workspace:FindFirstChild("SpawnLocation") then
            LP.Character.HumanoidRootPart.CFrame = workspace.SpawnLocation.CFrame * CFrame.new(0, 3, 0)
        end
    end,
})

local SelectedPlayer = nil
local Dropdown = Tabs.Teleport:Dropdown({
    Title = "Select Player",
    Values = {},
    Callback = function(v) SelectedPlayer = v end,
})

Tabs.Teleport:Button({
    Title = "Refresh Player List",
    Callback = function()
        local list = {}
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LP then table.insert(list, p.Name) end
        end
        Dropdown:Refresh(list)
    end,
})

Tabs.Teleport:Button({
    Title = "Teleport to Player",
    Callback = function()
        local target = Players:FindFirstChild(SelectedPlayer)
        if target and target.Character then
            LP.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame
        end
    end,
})
