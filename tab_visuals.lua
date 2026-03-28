-- // WNDS HUB - VISUALS MODULE (FIXED)
local Tabs = _G.WNDS_UI.Tabs
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local RunService = game:GetService("RunService")

_G.ESP_Enabled = false

Tabs.Visuals:Section({ Title = "Player ESP" })

Tabs.Visuals:Toggle({
    Title = "Enable ESP (Highlight)",
    Callback = function(v) 
        _G.ESP_Enabled = v 
        if not v then
            for _, p in pairs(Players:GetPlayers()) do
                if p.Character and p.Character:FindFirstChild("WNDS_ESP") then
                    p.Character.WNDS_ESP:Destroy()
                end
            end
        end
    end,
})

-- Looping ESP
RunService.RenderStepped:Connect(function()
    if _G.ESP_Enabled then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local hl = p.Character:FindFirstChild("WNDS_ESP") or Instance.new("Highlight", p.Character)
                hl.Name = "WNDS_ESP"
                hl.FillColor = Color3.fromRGB(120, 117, 242) -- Warna khas WNDS
                hl.OutlineColor = Color3.new(1, 1, 1)
                hl.FillTransparency = 0.5
            end
        end
    end
end)

Tabs.Visuals:Section({ Title = "World Environment" })

Tabs.Visuals:Toggle({
    Title = "FullBright (Anti-Dark)",
    Callback = function(v)
        if v then
            game:GetService("Lighting").Ambient = Color3.new(1, 1, 1)
            game:GetService("Lighting").OutdoorAmbient = Color3.new(1, 1, 1)
            game:GetService("Lighting").Brightness = 2
        else
            game:GetService("Lighting").Ambient = Color3.fromRGB(127, 127, 127)
            game:GetService("Lighting").Brightness = 1
        end
    end,
})
