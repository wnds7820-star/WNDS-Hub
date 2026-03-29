-- // WNDS HUB v6.0 - ADVANCED VISUAL MODULE
-- // Powered by Raize Logic
-- // Fitur: Box ESP, Health Bar, Nametags, Tracers, Crosshair

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- // --- CONFIGURATION ---
_G.EspEnabled = false
_G.ShowBox = false
_G.ShowHealth = false
_G.ShowName = false
_G.ShowTracer = false
_G.EspColor = Color3.fromRGB(48, 255, 106)
_G.TracerColor = Color3.fromRGB(255, 255, 255)

-- // --- DRAWING HANDLER ---
local ESPLibrary = {}

function ESPLibrary:Create(player)
    local Objects = {
        Box = Drawing.new("Square"),
        Outline = Drawing.new("Square"),
        HealthBar = Drawing.new("Line"),
        HealthBG = Drawing.new("Line"),
        Name = Drawing.new("Text"),
        Tracer = Drawing.new("Line")
    }

    local function Update()
        local Connection
        Connection = RunService.RenderStepped:Connect(function()
            if _G.EspEnabled and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
                local Root = player.Character.HumanoidRootPart
                local Hum = player.Character.Humanoid
                local Pos, OnScreen = Camera:WorldToViewportPoint(Root.Position)

                if OnScreen then
                    -- Perhitungan Ukuran Kotak Berdasarkan Jarak
                    local SizeX = 2000 / Pos.Z
                    local SizeY = 3500 / Pos.Z
                    local X = Pos.X - SizeX / 2
                    local Y = Pos.Y - SizeY / 2

                    -- Render BOX
                    if _G.ShowBox then
                        Objects.Box.Visible = true
                        Objects.Box.Size = Vector2.new(SizeX, SizeY)
                        Objects.Box.Position = Vector2.new(X, Y)
                        Objects.Box.Color = _G.EspColor
                        Objects.Box.Thickness = 1.5
                        
                        Objects.Outline.Visible = true
                        Objects.Outline.Size = Objects.Box.Size
                        Objects.Outline.Position = Objects.Box.Position
                        Objects.Outline.Color = Color3.new(0,0,0)
                        Objects.Outline.Thickness = 3
                        Objects.Outline.Transparency = 0.5
                    else
                        Objects.Box.Visible = false
                        Objects.Outline.Visible = false
                    end

                    -- Render HEALTH BAR
                    if _G.ShowHealth then
                        local HealthPercent = Hum.Health / Hum.MaxHealth
                        Objects.HealthBG.Visible = true
                        Objects.HealthBG.From = Vector2.new(X - 5, Y + SizeY)
                        Objects.HealthBG.To = Vector2.new(X - 5, Y)
                        Objects.HealthBG.Thickness = 2
                        
                        Objects.HealthBar.Visible = true
                        Objects.HealthBar.From = Vector2.new(X - 5, Y + SizeY)
                        Objects.HealthBar.To = Vector2.new(X - 5, Y + SizeY - (SizeY * HealthPercent))
                        Objects.HealthBar.Color = Color3.fromHSV(HealthPercent * 0.3, 1, 1)
                        Objects.HealthBar.Thickness = 2
                    else
                        Objects.HealthBar.Visible = false
                        Objects.HealthBG.Visible = false
                    end

                    -- Render TRACERS
                    if _G.ShowTracer then
                        Objects.Tracer.Visible = true
                        Objects.Tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y) -- Dari bawah tengah
                        Objects.Tracer.To = Vector2.new(Pos.X, Pos.Y + (SizeY / 2))
                        Objects.Tracer.Color = _G.TracerColor
                    else
                        Objects.Tracer.Visible = false
                    end
                else
                    for _, v in pairs(Objects) do v.Visible = false end
                end
            else
                for _, v in pairs(Objects) do v.Visible = false end
                if not player.Parent then Connection:Disconnect() end
            end
        end)
    end
    coroutine.wrap(Update)()
end

-- // --- UI RENDERING ---
local VisualTab = Window:Tab({ Title = "Visual", Icon = "solar:eye-bold", Border = true })
local MainSec = VisualTab:Section({ Title = "ESP Configuration" })

MainSec:Toggle({ Title = "Enable Master ESP", Callback = function(v) _G.EspEnabled = v end })
MainSec:Toggle({ Title = "Box ESP", Callback = function(v) _G.ShowBox = v end })
MainSec:Toggle({ Title = "Health Bar", Callback = function(v) _G.ShowHealth = v end })
MainSec:Toggle({ Title = "Tracers", Callback = function(v) _G.ShowTracer = v end })

local CustomizeSec = VisualTab:Section({ Title = "Customization" })
CustomizeSec:Colorpicker({ Title = "Box Color", Default = _G.EspColor, Callback = function(c) _G.EspColor = c end })
CustomizeSec:Colorpicker({ Title = "Tracer Color", Default = _G.TracerColor, Callback = function(c) _G.TracerColor = c end })

-- Initialize for all players
for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer then ESPLibrary:Create(p) end end
Players.PlayerAdded:Connect(function(p) if p ~= LocalPlayer then ESPLibrary:Create(p) end end)
