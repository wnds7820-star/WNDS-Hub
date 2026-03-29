-- // WNDS HUB v6.2 - INDEPENDENT VISUAL MODULE
-- // Powered by Raize Logic
-- // Fitur: Independent Toggles, Stable Highlight, Health & Name Tags

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- // --- CONFIGURATION (Independent) ---
_G.ShowHighlight = false
_G.ShowHealth = false
_G.ShowName = false
_G.TeamCheck = true
_G.EspColor = Color3.fromRGB(48, 255, 106)

-- // --- CORE LOGIC ---

local function CreateESP(player)
    if player == LocalPlayer then return end

    local function ApplyESP()
        local char = player.Character or player.CharacterAdded:Wait()
        
        -- 1. Setup Highlight (X-Ray)
        local highlight = char:FindFirstChild("WNDS_Highlight") or Instance.new("Highlight")
        highlight.Name = "WNDS_Highlight"
        highlight.Parent = char
        highlight.Enabled = false
        highlight.FillTransparency = 0.5
        highlight.OutlineTransparency = 0

        -- 2. Setup Billboard (Name & Health)
        local head = char:WaitForChild("Head", 10)
        if not head then return end
        
        local billboard = head:FindFirstChild("WNDS_Billboard") or Instance.new("BillboardGui")
        billboard.Name = "WNDS_Billboard"
        billboard.Adornee = head
        billboard.Size = UDim2.new(0, 150, 0, 50)
        billboard.StudsOffset = Vector3.new(0, 3, 0)
        billboard.AlwaysOnTop = true
        billboard.Parent = head

        local nameLabel = billboard:FindFirstChild("NameLabel") or Instance.new("TextLabel")
        nameLabel.Name = "NameLabel"
        nameLabel.Size = UDim2.new(1, 0, 0, 20)
        nameLabel.BackgroundTransparency = 1
        nameLabel.TextColor3 = Color3.new(1, 1, 1)
        nameLabel.TextStrokeTransparency = 0
        nameLabel.Font = Enum.Font.GothamBold
        nameLabel.TextSize = 14
        nameLabel.Parent = billboard

        local healthLabel = billboard:FindFirstChild("HealthLabel") or Instance.new("TextLabel")
        healthLabel.Name = "HealthLabel"
        healthLabel.Size = UDim2.new(1, 0, 0, 20)
        healthLabel.Position = UDim2.new(0, 0, 0, 18)
        healthLabel.BackgroundTransparency = 1
        healthLabel.Font = Enum.Font.GothamMedium
        healthLabel.TextSize = 12
        healthLabel.TextStrokeTransparency = 0
        healthLabel.Parent = billboard
    end

    player.CharacterAdded:Connect(ApplyESP)
    if player.Character then ApplyESP() end
end

-- // --- INDEPENDENT UPDATE LOOP ---
RunService.RenderStepped:Connect(function()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local char = player.Character
            local hum = char:FindFirstChild("Humanoid")
            local isTeammate = _G.TeamCheck and player.Team == LocalPlayer.Team
            
            -- Ambil Objek
            local highlight = char:FindFirstChild("WNDS_Highlight")
            local head = char:FindFirstChild("Head")
            local billboard = head and head:FindFirstChild("WNDS_Billboard")

            -- Logika Highlight (Bisa nyala sendiri)
            if highlight then
                highlight.Enabled = _G.ShowHighlight and not isTeammate and hum and hum.Health > 0
                highlight.FillColor = _G.EspColor
            end

            -- Logika Name & Health (Bisa nyala sendiri)
            if billboard then
                local nl = billboard:FindFirstChild("NameLabel")
                local hl = billboard:FindFirstChild("HealthLabel")
                
                if nl and hl and hum then
                    -- Name Label Logic
                    nl.Visible = _G.ShowName and not isTeammate and hum.Health > 0
                    nl.Text = player.DisplayName
                    
                    -- Health Label Logic
                    hl.Visible = _G.ShowHealth and not isTeammate and hum.Health > 0
                    hl.Text = "HP: " .. math.floor(hum.Health)
                    hl.TextColor3 = Color3.fromHSV((hum.Health / hum.MaxHealth) * 0.3, 1, 1)
                end
            end
        end
    end
end)

-- // --- UI RENDERING ---
local VisualTab = Window:Tab({ Title = "Visual", Icon = "solar:eye-bold", Border = true })
local MainSec = VisualTab:Section({ Title = "Independent Visuals" })

-- Sekarang tiap tombol bisa diklik kapan saja
MainSec:Toggle({
    Title = "Chams (X-Ray)",
    Desc = "Melihat badan tembus dinding",
    Callback = function(v) _G.ShowHighlight = v end
})

MainSec:Toggle({
    Title = "Show Player Names",
    Desc = "Menampilkan nama di atas kepala",
    Callback = function(v) _G.ShowName = v end
})

MainSec:Toggle({
    Title = "Show Health Info",
    Desc = "Menampilkan sisa HP musuh",
    Callback = function(v) _G.ShowHealth = v end
})

MainSec:Toggle({
    Title = "Team Check",
    Default = true,
    Callback = function(v) _G.TeamCheck = v end
})

local CustomizeSec = VisualTab:Section({ Title = "Customization" })
CustomizeSec:Colorpicker({
    Title = "ESP Color",
    Default = _G.EspColor,
    Callback = function(c) _G.EspColor = c end
})

-- Initialize
for _, p in pairs(Players:GetPlayers()) do CreateESP(p) end
Players.PlayerAdded:Connect(CreateESP)
