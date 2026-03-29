-- // WNDS HUB - VISUAL MODULE (ADVANCED)
-- // Developer: Raize

local VisualTab = _G.WNDS_Window:AddTab({ Title = "Visuals", Icon = "eye" })
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- // GLOBAL SETTINGS
_G.WNDS_BodyESP = false
_G.WNDS_HEnabled = false
_G.WNDS_HSize = 2
_G.WNDS_Chams = false -- New
_G.WNDS_Tracers = false -- New

-- // UI CONTROLS
VisualTab:AddToggle("be", {Title = "Body ESP (Precise Square)", Default = false}):OnChanged(function(v) _G.WNDS_BodyESP = v end)
VisualTab:AddToggle("ch", {Title = "Chams (Wallhack Highlight)", Default = false}):OnChanged(function(v) _G.WNDS_Chams = v end)
VisualTab:AddToggle("tr", {Title = "Tracer Lines (Snaplines)", Default = false}):OnChanged(function(v) _G.WNDS_Tracers = v end)

local HitboxSec = VisualTab:AddSection("Hitbox Settings")
HitboxSec:AddToggle("he", {Title = "Hitbox Expander", Default = false}):OnChanged(function(v) _G.WNDS_HEnabled = v end)
HitboxSec:AddSlider("hs", {Title = "Hitbox Scale", Default = 2, Min = 2, Max = 25, Rounding = 1, Callback = function(v) _G.WNDS_HSize = v end})

-- // CORE VISUAL LOGIC
local function CreateESP(P)
    -- Drawing Objects
    local l1, l2, l3, l4 = Drawing.new("Line"), Drawing.new("Line"), Drawing.new("Line"), Drawing.new("Line")
    local tracer = Drawing.new("Line")

    RunService.RenderStepped:Connect(function()
        if P.Character and P.Character:FindFirstChild("HumanoidRootPart") and P ~= LocalPlayer then
            local root = P.Character.HumanoidRootPart
            local char = P.Character
            local pos, os = Camera:WorldToViewportPoint(root.Position)

            -- 1. BOX ESP LOGIC
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

            -- 2. TRACERS LOGIC
            if os and _G.WNDS_Tracers then
                tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y) -- Dari bawah tengah layar
                tracer.To = Vector2.new(pos.X, pos.Y)
                tracer.Color = Color3.new(1, 1, 1)
                tracer.Thickness = 1
                tracer.Visible = true
            else
                tracer.Visible = false
            end

            -- 3. CHAMS LOGIC (Highlight)
            local highlight = char:FindFirstChild("WNDS_Highlight")
            if _G.WNDS_Chams then
                if not highlight then
                    highlight = Instance.new("Highlight")
                    highlight.Name = "WNDS_Highlight"
                    highlight.Parent = char
                    highlight.FillColor = Color3.fromRGB(0, 255, 255)
                    highlight.FillTransparency = 0.5
                    highlight.OutlineColor = Color3.new(1, 1, 1)
                    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                end
            else
                if highlight then highlight:Destroy() end
            end

        else
            for _,l in pairs({l1,l2,l3,l4,tracer}) do l.Visible = false end
        end
    end)
end

-- // HITBOX LOOP - VERSION 3.0 (SUPER STABLE)
task.spawn(function()
    while task.wait(0.5) do
        local isEnabled = _G.WNDS_HEnabled
        local rawSize = _G.WNDS_HSize
        
        -- Pastikan benar-benar angka murni
        local safeSize = 2
        if type(rawSize) == "number" then
            safeSize = rawSize
        elseif type(rawSize) == "string" then
            safeSize = tonumber(rawSize) or 2
        end

        if isEnabled then
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local hrp = p.Character.HumanoidRootPart
                    pcall(function()
                        -- Gunakan koordinat yang pasti valid
                        hrp.Size = Vector3.new(safeSize, safeSize, safeSize)
                        hrp.Transparency = 0.7
                        hrp.CanCollide = false
                    end)
                end
            end
        else
            -- Reset ke ukuran asli Roblox (Hanya jalan sekali saat dimatikan)
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local hrp = p.Character.HumanoidRootPart
                    pcall(function()
                        if hrp.Size ~= Vector3.new(2, 2, 1) then
                            hrp.Size = Vector3.new(2, 2, 1)
                            hrp.Transparency = 1
                        end
                    end)
                end
            end
        end
    end
end)

-- // INITIALIZE
for _,v in pairs(Players:GetPlayers()) do CreateESP(v) end
Players.PlayerAdded:Connect(CreateESP)

print("[WNDS] Visual Module Advanced Loaded Successfully.")
