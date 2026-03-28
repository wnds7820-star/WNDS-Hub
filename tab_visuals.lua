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

-- Field of View (FOV)
Tabs.Visuals:Slider({
    Title = "Field of View (FOV)",
    Step = 1, Value = {Min = 70, Max = 120, Default = 70},
    Callback = function(v) workspace.CurrentCamera.FieldOfView = v end,
})

-- No Fog (Menghapus kabut di semua game)
Tabs.Visuals:Toggle({
    Title = "Remove Fog",
    Callback = function(v)
        if v then
            game:GetService("Lighting").FogEnd = 999999
        else
            game:GetService("Lighting").FogEnd = 1000
        end
    end,
})
