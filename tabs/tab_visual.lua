-- // WNDS HUB - VISUAL MODULE (STABLE v2.0)
-- // Developer: Raize

local VisualTab = _G.WNDS_Window:AddTab({ Title = "Visuals", Icon = "eye" })
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local Fluent = _G.WNDS_Fluent

-- // 1. ERROR INTERCEPTOR HELPER
local function SafeExecute(func, context)
    local success, err = pcall(func)
    if not success then
        Fluent:Notify({
            Title = "Visual System Alert",
            Content = "Error in " .. context .. ": " .. tostring(err):sub(1, 40),
            Duration = 5
        })
        warn("[WNDS DEBUG] Handled: " .. tostring(err))
    end
end

-- // 2. FUNGSI PROTEKSI ANGKA
local function GetSafeNumber(val, default)
    if type(val) == "number" then return val end
    if type(val) == "string" then return tonumber(val) or default end
    if type(val) == "table" and val.Value then return tonumber(val.Value) or default end
    return default
end

-- // GLOBAL SETTINGS
_G.WNDS_BodyESP = false
_G.WNDS_HEnabled = false
_G.WNDS_HSize = 2
_G.WNDS_HTeamCheck = true
_G.WNDS_Chams = false
_G.WNDS_Tracers = false

-- // UI CONTROLS
VisualTab:AddToggle("be", {Title = "Body ESP (Precise Square)", Default = false}):OnChanged(function(v) _G.WNDS_BodyESP = v end)
VisualTab:AddToggle("ch", {Title = "Chams (Wallhack Highlight)", Default = false}):OnChanged(function(v) _G.WNDS_Chams = v end)
VisualTab:AddToggle("tr", {Title = "Tracer Lines (Snaplines)", Default = false}):OnChanged(function(v) _G.WNDS_Tracers = v end)

local HitboxSec = VisualTab:AddSection("Hitbox Settings")
HitboxSec:AddToggle("he", {Title = "Hitbox Expander", Default = false}):OnChanged(function(v) _G.WNDS_HEnabled = v end)
HitboxSec:AddToggle("htc", {Title = "Hitbox Team Check", Default = true}):OnChanged(function(v) _G.WNDS_HTeamCheck = v end)
HitboxSec:AddSlider("hs", {Title = "Hitbox Scale", Default = 2, Min = 2, Max = 25, Rounding = 1, Callback = function(v) _G.WNDS_HSize = v end})

-- // CORE VISUAL LOGIC (ESP, Tracers, Chams)
local function CreateESP(P)
    local l1, l2, l3, l4 = Drawing.new("Line"), Drawing.new("Line"), Drawing.new("Line"), Drawing.new("Line")
    local tracer = Drawing.new("Line")

    RunService.RenderStepped:Connect(function()
        SafeExecute(function()
            if P.Character and P.Character:FindFirstChild("HumanoidRootPart") and P ~= LocalPlayer then
                local root = P.Character.HumanoidRootPart
                local char = P.Character
                local pos, os = Camera:WorldToViewportPoint(root.Position)

                -- 1. BOX ESP
                if os and _G.WNDS_BodyESP then
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
                else 
                    for _,l in pairs({l1,l2,l3,l4}) do l.Visible = false end 
                end

                -- 2. TRACERS
                if os and _G.WNDS_Tracers then
                    tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                    tracer.To = Vector2.new(pos.X, pos.Y)
                    tracer.Color = Color3.new(1, 1, 1)
                    tracer.Visible = true
                else
                    tracer.Visible = false
                end

                -- 3. CHAMS
                local highlight = char:FindFirstChild("WNDS_Highlight")
                if _G.WNDS_Chams then
                    if not highlight then
                        highlight = Instance.new("Highlight")
                        highlight.Name = "WNDS_Highlight"
                        highlight.Parent = char
                        highlight.FillColor = Color3.fromRGB(0, 255, 255)
                        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    end
                else
                    if highlight then highlight:Destroy() end
                end
            else
                for _,l in pairs({l1,l2,l3,l4,tracer}) do l.Visible = false end
            end
        end, "ESP Engine")
    end)
end

-- // HITBOX LOOP - ADVANCED REINFORCED
task.spawn(function()
    while task.wait(0.5) do -- Delay lebih cepat untuk akurasi tinggi
        SafeExecute(function()
            local isEnabled = _G.WNDS_HEnabled
            local safeSize = GetSafeNumber(_G.WNDS_HSize, 2)

            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local hrp = p.Character.HumanoidRootPart
                    
                    if isEnabled then
                        -- Team Check Logic
                        if _G.WNDS_HTeamCheck and p.Team == LocalPlayer.Team then
                            -- Reset jika teman satu tim
                            if hrp.Size.X ~= 2 then
                                hrp.Size = Vector3.new(2, 2, 1)
                                hrp.Transparency = 1
                            end
                        else
                            -- Apply Advanced Hitbox
                            hrp.Size = Vector3.new(safeSize, safeSize, safeSize)
                            hrp.Transparency = 0.7
                            hrp.BrickColor = BrickColor.new("Really red")
                            hrp.Material = Enum.Material.Neon
                            hrp.CanCollide = false
                            
                            -- Physics Fix: Menjaga karakter agar tidak terpental/jatuh
                            hrp.Velocity = Vector3.new(0, 0, 0)
                            hrp.RotVelocity = Vector3.new(0, 0, 0)
                        end
                    else
                        -- Reset Global jika Fitur OFF
                        if hrp.Size.X ~= 2 then
                            hrp.Size = Vector3.new(2, 2, 1)
                            hrp.Transparency = 1
                            hrp.BrickColor = BrickColor.new("Medium stone grey")
                            hrp.Material = Enum.Material.Plastic
                        end
                    end
                end
            end
        end, "Hitbox Module")
    end
end)

-- // INITIALIZE
for _,v in pairs(Players:GetPlayers()) do CreateESP(v) end
Players.PlayerAdded:Connect(CreateESP)

print("[WNDS] Visual Module v2.0 + Hitbox Expander Stable Loaded.")