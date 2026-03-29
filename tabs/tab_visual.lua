local Window = _G.WNDS_Window
local Fluent = _G.WNDS_Fluent

-- FIX: Pakai AddTab, bukan Tab
local VisualTab = Window:AddTab({ Title = "Visuals", Icon = "eye" })
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- Variabel Fitur
_G.WNDS_ESP_BodyBox = false
_G.WNDS_Hitbox_Enabled = false
_G.WNDS_Hitbox_Size = 2

-- UI Langsung Tanpa Master Switch
VisualTab:AddToggle("EspBody", {Title = "Precise Body ESP (Follows Body)", Default = false}):OnChanged(function(v) 
    _G.WNDS_ESP_BodyBox = v 
end)

VisualTab:AddToggle("HitboxTog", {Title = "Enable Hitbox Expander", Default = false}):OnChanged(function(v) 
    _G.WNDS_Hitbox_Enabled = v 
end)

-- FIX: Tambahkan Rounding = 1 agar tidak error merah
VisualTab:AddSlider("HitSize", {
    Title = "Hitbox Scale",
    Default = 2, Min = 2, Max = 25, Rounding = 1, 
    Callback = function(v) _G.WNDS_Hitbox_Size = v end
})

-- LOGIKA ESP BODY (Oriented Box)
local function CreateESP(Player)
    local Line1, Line2, Line3, Line4 = Drawing.new("Line"), Drawing.new("Line"), Drawing.new("Line"), Drawing.new("Line")
    
    RunService.RenderStepped:Connect(function()
        if _G.WNDS_ESP_BodyBox and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") and Player ~= LocalPlayer then
            local Root = Player.Character.HumanoidRootPart
            local Pos, OnScreen = Camera:WorldToViewportPoint(Root.Position)
            if OnScreen then
                local Size = Vector3.new(2, 3, 0)
                local TL = Camera:WorldToViewportPoint((Root.CFrame * CFrame.new(-Size.X, Size.Y, 0)).p)
                local TR = Camera:WorldToViewportPoint((Root.CFrame * CFrame.new(Size.X, Size.Y, 0)).p)
                local BL = Camera:WorldToViewportPoint((Root.CFrame * CFrame.new(-Size.X, -Size.Y, 0)).p)
                local BR = Camera:WorldToViewportPoint((Root.CFrame * CFrame.new(Size.X, -Size.Y, 0)).p)
                
                Line1.From, Line1.To = Vector2.new(TL.X, TL.Y), Vector2.new(TR.X, TR.Y)
                Line2.From, Line2.To = Vector2.new(TR.X, TR.Y), Vector2.new(BR.X, BR.Y)
                Line3.From, Line3.To = Vector2.new(BR.X, BR.Y), Vector2.new(BL.X, BL.Y)
                Line4.From, Line4.To = Vector2.new(BL.X, BL.Y), Vector2.new(TL.X, TL.Y)
                
                for _, l in pairs({Line1, Line2, Line3, Line4}) do l.Visible = true; l.Color = Color3.fromRGB(0, 255, 255) end
            else
                for _, l in pairs({Line1, Line2, Line3, Line4}) do l.Visible = false end
            end
        else
            for _, l in pairs({Line1, Line2, Line3, Line4}) do l.Visible = false end
        end
    end)
end

-- LOGIKA HITBOX
task.spawn(function()
    while task.wait(0.5) do
        if _G.WNDS_Hitbox_Enabled then
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    p.Character.HumanoidRootPart.Size = Vector3.new(_G.WNDS_Hitbox_Size, _G.WNDS_Hitbox_Size, _G.WNDS_Hitbox_Size)
                    p.Character.HumanoidRootPart.Transparency = 0.8
                end
            end
        end
    end
end)

for _, v in pairs(Players:GetPlayers()) do CreateESP(v) end
Players.PlayerAdded:Connect(CreateESP)
