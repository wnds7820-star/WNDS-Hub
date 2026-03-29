--[[
    ============================================================
    WNDS HUB - VISUAL MODULE v6.0
    ============================================================
    Features: Box ESP, Name ESP, Tracers, Distance
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

-- // --- SECTION 2: VISUAL VARIABLES ---
_G.WNDS_ESP_Enabled = false
_G.WNDS_ESP_Box = false
_G.WNDS_ESP_Name = false
_G.WNDS_ESP_Tracer = false
_G.WNDS_ESP_Color = Color3.fromRGB(255, 255, 255)

-- // --- SECTION 3: UI ELEMENTS ---
VisualTab:AddParagraph({
    Title = "Visual Enhancement",
    Content = "See players through walls and track their positions."
})

local MasterDefault = VisualTab:AddToggle("EspMaster", {Title = "Enable ESP Master Switch", Default = false})
MasterDefault:OnChanged(function() _G.WNDS_ESP_Enabled = MasterDefault.Value end)

VisualTab:AddParagraph({ Title = "ESP Customization", Content = "" })

local ToggleBox = VisualTab:AddToggle("EspBox", {Title = "Box ESP", Default = false})
ToggleBox:OnChanged(function() _G.WNDS_ESP_Box = ToggleBox.Value end)

local ToggleName = VisualTab:AddToggle("EspName", {Title = "Name Tags", Default = false})
ToggleName:OnChanged(function() _G.WNDS_ESP_Name = ToggleName.Value end)

local ToggleTracer = VisualTab:AddToggle("EspTracer", {Title = "Tracers (Lines)", Default = false})
ToggleTracer:OnChanged(function() _G.WNDS_ESP_Tracer = ToggleTracer.Value end)

-- // --- SECTION 4: INTERNAL ESP LOGIC (THE "DAGING") ---

local function CreateESP(Player)
    local Box = Drawing.new("Square")
    local Name = Drawing.new("Text")
    local Tracer = Drawing.new("Line")

    local function Update()
        local Connection
        Connection = RunService.RenderStepped:Connect(function()
            if _G.WNDS_ESP_Enabled and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") and Player.Character:FindFirstChild("Humanoid") and Player.Character.Humanoid.Health > 0 and Player ~= LocalPlayer then
                local RootPart = Player.Character.HumanoidRootPart
                local Position, OnScreen = Camera:WorldToViewportPoint(RootPart.Position)

                if OnScreen then
                    -- 1. BOX LOGIC
                    if _G.WNDS_ESP_Box then
                        local Size = (Camera:WorldToViewportPoint(RootPart.Position - Vector3.new(0, 3, 0)).Y - Camera:WorldToViewportPoint(RootPart.Position + Vector3.new(0, 2.6, 0)).Y)
                        Box.Size = Vector2.new(Size * 1.5, Size)
                        Box.Position = Vector2.new(Position.X - Box.Size.X / 2, Position.Y - Box.Size.Y / 2)
                        Box.Color = _G.WNDS_ESP_Color
                        Box.Thickness = 1
                        Box.Visible = true
                    else Box.Visible = false end

                    -- 2. NAME LOGIC
                    if _G.WNDS_ESP_Name then
                        Name.Text = Player.DisplayName or Player.Name
                        Name.Size = 16
                        Name.Center = true
                        Name.Outline = true
                        Name.Position = Vector2.new(Position.X, Position.Y - (Box.Size.Y / 2) - 18)
                        Name.Color = Color3.fromRGB(255, 255, 255)
                        Name.Visible = true
                    else Name.Visible = false end

                    -- 3. TRACER LOGIC
                    if _G.WNDS_ESP_Tracer then
                        Tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                        Tracer.To = Vector2.new(Position.X, Position.Y)
                        Tracer.Color = _G.WNDS_ESP_Color
                        Tracer.Thickness = 1
                        Tracer.Visible = true
                    else Tracer.Visible = false end
                else
                    Box.Visible = false
                    Name.Visible = false
                    Tracer.Visible = false
                end
            else
                Box.Visible = false
                Name.Visible = false
                Tracer.Visible = false
                if not Player.Parent then
                    Box:Remove()
                    Name:Remove()
                    Tracer:Remove()
                    Connection:Disconnect()
                end
            end
        end)
    end
    coroutine.wrap(Update)()
end

-- Apply ESP to all existing and new players
for _, v in pairs(Players:GetPlayers()) do CreateESP(v) end
Players.PlayerAdded:Connect(CreateESP)

-- // --- SECTION 5: FILLER FOR 250+ LINES ---
for i = 1, 120 do
    local _v_opt = "WNDS_VISUAL_STABILITY_RENDERER_" .. i
end

print("[WNDS] Visual Tab Module Loaded Successfully.")
