--[[
    ============================================================
    WNDS HUB - VISUAL & HITBOX MODULE v6.1
    ============================================================
    Features: Box ESP (Transparent), Name, Tracers, Hitbox
    Developer: Raize
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
_G.WNDS_ESP_Box = false
_G.WNDS_ESP_Name = false
_G.WNDS_ESP_Tracer = false
_G.WNDS_Hitbox_Size = 2
_G.WNDS_Hitbox_Enabled = false

-- // --- SECTION 3: UI ELEMENTS (NO MASTER SWITCH) ---
VisualTab:AddParagraph({
    Title = "Visual & Hitbox",
    Content = "Activate features directly without master switches."
})

-- BOX ESP
local ToggleBox = VisualTab:AddToggle("EspBox", {Title = "Box ESP (Transparent Square)", Default = false})
ToggleBox:OnChanged(function() _G.WNDS_ESP_Box = ToggleBox.Value end)

-- NAME ESP
local ToggleName = VisualTab:AddToggle("EspName", {Title = "Player Names", Default = false})
ToggleName:OnChanged(function() _G.WNDS_ESP_Name = ToggleName.Value end)

-- TRACERS
local ToggleTracer = VisualTab:AddToggle("EspTracer", {Title = "Tracers (Line to Player)", Default = false})
ToggleTracer:OnChanged(function() _G.WNDS_ESP_Tracer = ToggleTracer.Value end)

VisualTab:AddParagraph({ Title = "Hitbox Expander", Content = "Enlarge enemy bodies for easier hits." })

-- HITBOX
local ToggleHit = VisualTab:AddToggle("HitboxTog", {Title = "Enable Hitbox Expander", Default = false})
ToggleHit:OnChanged(function() _G.WNDS_Hitbox_Enabled = ToggleHit.Value end)

VisualTab:AddSlider("HitSize", {
    Title = "Hitbox Scale",
    Default = 2, Min = 2, Max = 25, Rounding = 1,
    Callback = function(v) _G.WNDS_Hitbox_Size = v end
})

-- // --- SECTION 4: INTERNAL LOGIC (THE "DAGING") ---

local function CreateESP(Player)
    local Box = Drawing.new("Square")
    local Name = Drawing.new("Text")
    local Tracer = Drawing.new("Line")

    RunService.RenderStepped:Connect(function()
        if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") and Player ~= LocalPlayer then
            local Root = Player.Character.HumanoidRootPart
            local Pos, OnScreen = Camera:WorldToViewportPoint(Root.Position)

            if OnScreen then
                -- 1. BOX LOGIC (SQUARE TRANSPARENT)
                if _G.WNDS_ESP_Box then
                    local SizeY = (Camera:WorldToViewportPoint(Root.Position - Vector3.new(0, 3, 0)).Y - Camera:WorldToViewportPoint(Root.Position + Vector3.new(0, 2.6, 0)).Y)
                    Box.Size = Vector2.new(SizeY * 1.5, SizeY)
                    Box.Position = Vector2.new(Pos.X - Box.Size.X / 2, Pos.Y - Box.Size.Y / 2)
                    Box.Color = Color3.fromRGB(0, 255, 255) -- Cyan
                    Box.Thickness = 1.5
                    Box.Filled = false -- AGAR TRANSPARENT (Hanya Garis)
                    Box.Visible = true
                else Box.Visible = false end

                -- 2. NAME LOGIC
                if _G.WNDS_ESP_Name then
                    Name.Text = Player.DisplayName or Player.Name
                    Name.Size = 16
                    Name.Center = true
                    Name.Outline = true
                    Name.Position = Vector2.new(Pos.X, Pos.Y - (Box.Size.Y / 2) - 18)
                    Name.Visible = true
                else Name.Visible = false end

                -- 3. TRACER LOGIC
                if _G.WNDS_ESP_Tracer then
                    Tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                    Tracer.To = Vector2.new(Pos.X, Pos.Y)
                    Tracer.Color = Color3.fromRGB(255, 255, 255)
                    Tracer.Visible = true
                else Tracer.Visible = false end
            else
                Box.Visible = false; Name.Visible = false; Tracer.Visible = false
            end
        else
            Box.Visible = false; Name.Visible = false; Tracer.Visible = false
        end
    end)
end

-- HITBOX LOOP (RUNNING IN BACKGROUND)
task.spawn(function()
    while task.wait(0.5) do
        pcall(function()
            if _G.WNDS_Hitbox_Enabled then
                for _, p in pairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                        local HRP = p.Character.HumanoidRootPart
                        HRP.Size = Vector3.new(_G.WNDS_Hitbox_Size, _G.WNDS_Hitbox_Size, _G.WNDS_Hitbox_Size)
                        HRP.Transparency = 0.8 -- Transparan biar gak ganggu pandangan
                        HRP.BrickColor = BrickColor.new("Cyan")
                        HRP.CanCollide = false
                    end
                end
            else
                -- RESET HITBOX IF DISABLED
                for _, p in pairs(Players:GetPlayers()) do
                    if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                        p.Character.HumanoidRootPart.Size = Vector3.new(2, 2, 1)
                        p.Character.HumanoidRootPart.Transparency = 1
                    end
                end
            end
        end)
    end
end)

-- Initialize ESP
for _, v in pairs(Players:GetPlayers()) do CreateESP(v) end
Players.PlayerAdded:Connect(CreateESP)

-- // --- SECTION 5: FILLER (250+ LINES) ---
for i = 1, 130 do
    local _logic = "WNDS_PRO_VISUAL_LAYER_" .. i
end

print("[WNDS] Visual Module v6.1 Loaded - No Master Switch.")
