local VisualTab = _G.WNDS_Window:AddTab({ Title = "Visuals", Icon = "eye" })
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

_G.WNDS_BodyESP = false
_G.WNDS_HEnabled = false
_G.WNDS_HSize = 2

VisualTab:AddToggle("be", {Title = "Body ESP (Precise Square)", Default = false}):OnChanged(function(v) _G.WNDS_BodyESP = v end)
VisualTab:AddToggle("he", {Title = "Hitbox Expander", Default = false}):OnChanged(function(v) _G.WNDS_HEnabled = v end)
VisualTab:AddSlider("hs", {Title = "Hitbox Scale", Default = 2, Min = 2, Max = 25, Rounding = 1, Callback = function(v) _G.WNDS_HSize = v end})

local function CreateESP(P)
    local l1, l2, l3, l4 = Drawing.new("Line"), Drawing.new("Line"), Drawing.new("Line"), Drawing.new("Line")
    RunService.RenderStepped:Connect(function()
        if _G.WNDS_BodyESP and P.Character and P.Character:FindFirstChild("HumanoidRootPart") and P ~= LocalPlayer then
            local root = P.Character.HumanoidRootPart
            local pos, os = Camera:WorldToViewportPoint(root.Position)
            if os then
                local cf = root.CFrame
                local size = Vector3.new(2, 3, 0)
                local tl = Camera:WorldToViewportPoint((cf * CFrame.new(-size.X, size.Y, 0)).p)
                local tr = Camera:WorldToViewportPoint((cf * CFrame.new(size.X, size.Y, 0)).p)
                local bl = Camera:WorldToViewportPoint((cf * CFrame.new(-size.X, -size.Y, 0)).p)
                local br = Camera:WorldToViewportPoint((cf * CFrame.new(size.X, -size.Y, 0)).p)
                l1.From, l1.To = Vector2.new(tl.X, tl.Y), Vector2.new(tr.X, tr.Y)
                l2.From, l2.To = Vector2.new(tr.X, tr.Y), Vector2.new(br.X, br.Y)
                l3.From, l3.To = Vector2.new(br.X, br.Y), Vector2.new(bl.X, bl.Y)
                l4.From, l4.To = Vector2.new(bl.X, bl.Y), Vector2.new(tl.X, tl.Y)
                for _,l in pairs({l1,l2,l3,l4}) do l.Visible = true; l.Thickness = 1.5; l.Color = Color3.new(0,1,1) end
            else for _,l in pairs({l1,l2,l3,l4}) do l.Visible = false end end
        else for _,l in pairs({l1,l2,l3,l4}) do l.Visible = false end end
    end)
end

task.spawn(function()
    while task.wait(0.5) do
        if _G.WNDS_HEnabled then
            for _,p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    p.Character.HumanoidRootPart.Size = Vector3.new(_G.WNDS_HSize, _G.WNDS_HSize, _G.WNDS_HSize)
                    p.Character.HumanoidRootPart.Transparency = 0.7
                end
            end
        end
    end
end)

for _,v in pairs(Players:GetPlayers()) do CreateESP(v) end
Players.PlayerAdded:Connect(CreateESP)
