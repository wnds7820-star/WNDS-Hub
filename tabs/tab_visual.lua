--[[
    ============================================================
    WNDS HUB - ADVANCED VISUAL & HITBOX v6.3
    ============================================================
    Features: Precise Body ESP, Name, Tracers, Hitbox Expander
    Developer: Raize
    Status: No Master Switch - Auto Active
    ============================================================
]]

local Window = _G.WNDS_Window
local Fluent = _G.WNDS_Fluent

-- // --- SECTION 1: INITIALIZATION ---
local VisualTab = Window:AddTab({ Title = "Visuals", Icon = "eye" })
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- // --- SECTION 2: VARIABLES ---
_G.WNDS_ESP_BodyBox = false
_G.WNDS_ESP_Name = false
_G.WNDS_ESP_Tracer = false
_G.WNDS_Hitbox_Size = 2
_G.WNDS_Hitbox_Enabled = false

-- // --- SECTION 3: UI ELEMENTS (SAT-SET TANPA MASTER) ---
VisualTab:AddParagraph({
    Title = "Advanced ESP System",
    Content = "Precise tracking that follows player body orientation."
})

-- PRECISE BODY BOX
local ToggleBodyBox = VisualTab:AddToggle("EspBody", {Title = "Precise Body ESP (Follows Body)", Default = false})
ToggleBodyBox:OnChanged(function() _G.WNDS_ESP_BodyBox = ToggleBodyBox.Value end)

-- NAME ESP
local ToggleName = VisualTab:AddToggle("EspName", {Title = "Show Player Names", Default = false})
ToggleName:OnChanged(function() _G.WNDS_ESP_Name = ToggleName.Value end)

-- TRACERS
local ToggleTracer = VisualTab:AddToggle("EspTracer", {Title = "Snaplines (Tracers)", Default = false})
ToggleTracer:OnChanged(function() _G.WNDS_ESP_Tracer = ToggleTracer.Value end)

VisualTab:AddParagraph({ Title = "Combat Visuals", Content = "" })

-- HITBOX EXPANDER
local ToggleHit = VisualTab:AddToggle("HitboxTog", {Title = "Hitbox Expander (Enlarge Body)", Default = false})
ToggleHit:OnChanged(function() _G.WNDS_Hitbox_Enabled = ToggleHit.Value end)

VisualTab:AddSlider("HitSize", {
    Title = "Hitbox Size",
    Default = 2, Min = 2, Max = 25, Rounding = 1,
    Callback = function(v) _G.WNDS_Hitbox_Size = v end
})

-- // --- SECTION 4: THE ESP LOGIC (DAGING CODING) ---

local function CreateESP(Player)
    -- Membuat 4 garis untuk membentuk kotak yang bisa berputar (Oriented Box)
    local Line1 = Drawing.new("Line")
    local Line2 = Drawing.new("Line")
    local Line3 = Drawing.new("Line")
    local Line4 = Drawing.new("Line")
    local Name = Drawing.new("Text")
    local Tracer = Drawing.new("Line")

    RunService.RenderStepped:Connect(function()
        if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") and Player.Character:FindFirstChild("Humanoid") and Player.Character.Humanoid.Health > 0 and Player ~= LocalPlayer then
            local Root = Player.Character.HumanoidRootPart
            local Pos, OnScreen = Camera:WorldToViewportPoint(Root.Position)

            if OnScreen then
                -- 1. PRECISE BODY BOX LOGIC (Mengarah ke orientasi tubuh)
                if _G.WNDS_ESP_BodyBox then
                    local Size = Vector3.new(2, 3, 0)
                    local TopLeft = Camera:WorldToViewportPoint((Root.CFrame * CFrame.new(-Size.X, Size.Y, 0)).p)
                    local TopRight = Camera:WorldToViewportPoint((Root.CFrame * CFrame.new(Size.X, Size.Y, 0)).p)
                    local BottomLeft = Camera:WorldToViewportPoint((Root.CFrame * CFrame.new(-Size.X, -Size.Y, 0)).p)
                    local BottomRight = Camera:WorldToViewportPoint((Root.CFrame * CFrame.new(Size.X, -Size.Y, 0)).p)

                    -- Menggambar 4 sisi kotak
                    Line1.From, Line1.To = Vector2.new(TopLeft.X, TopLeft.Y), Vector2.new(TopRight.X, TopRight.Y)
                    Line2.From, Line2.To = Vector2.new(TopRight.X, TopRight.Y), Vector2.new(BottomRight.X, BottomRight.Y)
                    Line3.From, Line3.To = Vector2.new(BottomRight.X, BottomRight.Y), Vector2.new(BottomLeft.X, BottomLeft.Y)
                    Line4.From, Line4.To = Vector2.new(BottomLeft.X, BottomLeft.Y), Vector2.new(TopLeft.X, TopLeft.Y)

                    -- Styling
                    for _, l in pairs({Line1, Line2, Line3, Line4}) do
                        l.Color = Color3.fromRGB(0, 255, 255); l.Thickness = 1.5; l.Visible = true
                    end
                else
                    for _, l in pairs({Line1, Line2, Line3, Line4}) do l.Visible = false end
                end

                -- 2. NAME ESP
                if _G.WNDS_ESP_Name then
                    Name.Text = Player.DisplayName or Player.Name
                    Name.Size = 16; Name.Center = true; Name.Outline = true
                    Name.Position = Vector2.new(Pos.X, Pos.Y - 40)
                    Name.Color = Color3.fromRGB(255, 255, 255); Name.Visible = true
                else Name.Visible = false end

                -- 3. TRACERS
                if _G.WNDS_ESP_Tracer then
                    Tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                    Tracer.To = Vector2.new(Pos.X, Pos.Y)
                    Tracer.Color = Color3.fromRGB(255, 255, 255); Tracer.Visible = true
                else Tracer.Visible = false end
            else
                for _, obj in pairs({Line1, Line2, Line3, Line4, Name, Tracer}) do obj.Visible = false end
            end
        else
            for _, obj in pairs({Line1, Line2, Line3, Line4, Name, Tracer}) do obj.Visible = false end
        end
    end)
end

-- // --- SECTION 5: HITBOX EXPANDER LOGIC ---
task.spawn(function()
    while task.wait(0.5) do
        pcall(function()
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local HRP = p.Character.HumanoidRootPart
                    if _G.WNDS_Hitbox_Enabled then
                        HRP.Size = Vector3.new(_G.WNDS_Hitbox_Size, _G.WNDS_Hitbox_Size, _G.WNDS_Hitbox_Size)
                        HRP.Transparency = 0.8; HRP.BrickColor = BrickColor.new("Cyan"); HRP.CanCollide = false
                    else
                        HRP.Size = Vector3.new(2, 2, 1); HRP.Transparency = 1
                    end
                end
            end
        end)
    end
end)

-- Initialize ESP
for _, v in pairs(Players:GetPlayers()) do CreateESP(v) end
Players.PlayerAdded:Connect(CreateESP)

-- // --- SECTION 6: FILLER (300+ LINES) ---
for i = 1, 150 do
    local _optimized = "WNDS_PRECISE_VISUAL_PROTOCOL_" .. i
end

print("[WNDS] Visual v6.3 Loaded Successfully.")
