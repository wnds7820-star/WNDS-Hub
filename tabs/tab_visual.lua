-- // WNDS HUB v6.6 - ELITE PLAYER ESP MODULE
-- // Full Module: Highlight ESP, Health Tags, Name Tags, Team Check
-- // Perbaikan: Ganti X-Ray Menjadi ESP Player Stabil

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- // --- CONFIGURATION (Independent Toggles) ---
_G.EspEnabled = false
_G.ShowHighlight = false
_G.ShowHealth = false
_G.ShowName = false
_G.TeamCheck = true
_G.EspColor = Color3.fromRGB(48, 255, 106)

-- // --- CORE ESP LOGIC (Instance Based) ---

local function CreatePlayerESP(player)
    if player == LocalPlayer then return end

    local function ApplyESPEffect()
        local char = player.Character or player.CharacterAdded:Wait()
        
        -- 1. Setup Highlight (X-Ray Effect)
        local highlight = char:FindFirstChild("WNDS_Highlight") or Instance.new("Highlight")
        highlight.Name = "WNDS_Highlight"
        highlight.Parent = char
        highlight.FillTransparency = 0.5
        highlight.OutlineTransparency = 0
        highlight.Enabled = false -- Default Mati

        -- 2. Setup Billboard (Name & Health)
        local head = char:WaitForChild("Head", 10)
        if not head then return end
        
        local billboard = head:FindFirstChild("WNDS_Billboard") or Instance.new("BillboardGui")
        billboard.Name = "WNDS_Billboard"
        billboard.Adornee = head
        billboard.Size = UDim2.new(0, 150, 0, 50)
        billboard.StudsOffset = Vector3.new(0, 3, 0) -- Di atas kepala
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
        nameLabel.Visible = false -- Default Mati

        local healthLabel = billboard:FindFirstChild("HealthLabel") or Instance.new("TextLabel")
        healthLabel.Name = "HealthLabel"
        healthLabel.Size = UDim2.new(1, 0, 0, 20)
        healthLabel.Position = UDim2.new(0, 0, 0, 18)
        healthLabel.BackgroundTransparency = 1
        healthLabel.Font = Enum.Font.GothamMedium
        healthLabel.TextSize = 12
        healthLabel.TextStrokeTransparency = 0
        healthLabel.Parent = billboard
        healthLabel.Visible = false -- Default Mati
    end

    player.CharacterAdded:Connect(ApplyESPEffect)
    if player.Character then ApplyESPEffect() end
end

-- // --- INDEPENDENT ESP UPDATE LOOP ---
RunService.RenderStepped:Connect(function()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local char = player.Character
            local hum = char:FindFirstChild("Humanoid")
            local isTeammate = _G.TeamCheck and player.Team == LocalPlayer.Team
            
            -- Ambil Objek ESP
            local highlight = char:FindFirstChild("WNDS_Highlight")
            local head = char:FindFirstChild("Head")
            local billboard = head and head:FindFirstChild("WNDS_Billboard")

            -- Logika Master Toggle dan Pengecekan Kondisi
            local validTarget = _G.EspEnabled and hum and hum.Health > 0 and not isTeammate

            -- Update Highlight ESP (Bisa nyala sendiri)
            if highlight then
                highlight.Enabled = validTarget and _G.ShowHighlight
                highlight.FillColor = _G.EspColor
            end

            -- Update Name & Health ESP (Bisa nyala sendiri)
            if billboard then
                local nl = billboard:FindFirstChild("NameLabel")
                local hl = billboard:FindFirstChild("HealthLabel")
                
                if nl and hl and hum then
                    -- Name Label Logic
                    nl.Visible = validTarget and _G.ShowName
                    nl.Text = player.DisplayName .. " (@" .. player.Name .. ")"
                    
                    -- Health Label Logic
                    hl.Visible = validTarget and _G.ShowHealth
                    hl.Text = "HP: " .. math.floor(hum.Health)
                    hl.TextColor3 = Color3.fromHSV((hum.Health / hum.MaxHealth) * 0.3, 1, 1) -- Hijau ke Merah
                end
            end
        end
    end
end)

-- // --- UI RENDERING (TAB VISUAL) ---
local VisualTab = Window:Tab({ Title = "Visual", Icon = "solar:eye-bold", Border = true })

-- SECTION: INSTANT VIEW (Semua Fitur Langsung Muncul)
local MainSec = VisualTab:Section({ Title = "Player ESP System" })

MainSec:Toggle({
    Title = "Enable Master ESP",
    Desc = "Aktifkan agar fitur di bawah berfungsi",
    Callback = function(v) _G.EspEnabled = v end
})

MainSec:Toggle({
    Title = "Player Highlight (Chams)",
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
    Desc = "Sembunyikan teman satu tim",
    Callback = function(v) _G.TeamCheck = v end
})

local CustomizeSec = VisualTab:Section({ Title = "Customization" })
CustomizeSec:Colorpicker({
    Title = "ESP Fill Color",
    Default = _G.EspColor,
    Callback = function(c) _G.EspColor = c end
})

-- Initialize ESP for all players
for _, p in pairs(Players:GetPlayers()) do CreatePlayerESP(p) end
Players.PlayerAdded:Connect(CreatePlayerESP)
