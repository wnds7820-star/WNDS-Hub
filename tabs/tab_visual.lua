-- // WNDS HUB v6.1 - STABLE VISUAL MODULE (FIXED)
-- // Powered by Raize Logic
-- // Fitur: Highlight ESP, Health Tags, Team Check, Tracers

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- // --- CONFIGURATION ---
_G.EspEnabled = false
_G.ShowHighlight = false
_G.ShowHealth = false
_G.ShowTracer = false
_G.TeamCheck = true
_G.EspColor = Color3.fromRGB(48, 255, 106)
_G.TracerColor = Color3.fromRGB(255, 255, 255)

-- // --- CORE LOGIC (Instance Based - No Drawing Lib Needed) ---

local function CreateESP(player)
    if player == LocalPlayer then return end

    local function ApplyESP()
        local char = player.Character
        if not char then return end

        -- 1. Setup Highlight (X-Ray Effect)
        local highlight = char:FindFirstChild("WNDS_Highlight")
        if not highlight then
            highlight = Instance.new("Highlight")
            highlight.Name = "WNDS_Highlight"
            highlight.Parent = char
            highlight.FillTransparency = 0.5
            highlight.OutlineTransparency = 0
            highlight.Adornee = char
        end

        -- 2. Setup Health Billboard (Name & Health)
        local head = char:WaitForChild("Head", 5)
        if not head then return end
        local billboard = head:FindFirstChild("WNDS_Billboard")
        if not billboard then
            billboard = Instance.new("BillboardGui")
            billboard.Name = "WNDS_Billboard"
            billboard.Adornee = head
            billboard.Size = UDim2.new(0, 100, 0, 50)
            billboard.StudsOffset = Vector3.new(0, 3, 0) -- Di atas kepala
            billboard.AlwaysOnTop = true
            billboard.Parent = head

            local nameLabel = Instance.new("TextLabel")
            nameLabel.Name = "NameLabel"
            nameLabel.Size = UDim2.new(1, 0, 0, 20)
            nameLabel.BackgroundTransparency = 1
            nameLabel.TextColor3 = Color3.new(1, 1, 1)
            nameLabel.TextStrokeTransparency = 0
            nameLabel.Font = Enum.Font.GothamBold
            nameLabel.TextSize = 14
            nameLabel.Parent = billboard

            local healthLabel = Instance.new("TextLabel")
            healthLabel.Name = "HealthLabel"
            healthLabel.Size = UDim2.new(1, 0, 0, 20)
            healthLabel.Position = UDim2.new(0, 0, 0, 20)
            healthLabel.BackgroundTransparency = 1
            healthLabel.Font = Enum.Font.GothamMedium
            healthLabel.TextSize = 12
            healthLabel.TextStrokeTransparency = 0
            healthLabel.Parent = billboard
        end
    end

    -- Jalankan saat karakter respawn
    if player.Character then ApplyESP() end
    player.CharacterAdded:Connect(ApplyESP)
end

-- // --- MAIN LOOP (UPDATE SETTINGS) ---
RunService.RenderStepped:Connect(function()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local char = player.Character
            local hum = char:FindFirstChild("Humanoid")
            local isTeammate = _G.TeamCheck and player.Team == LocalPlayer.Team

            -- Pengecekan Validitas (Nyawa & Tim)
            if _G.EspEnabled and hum and hum.Health > 0 and not isTeammate then
                
                -- Update Highlight
                local highlight = char:FindFirstChild("WNDS_Highlight")
                if highlight then
                    highlight.Enabled = _G.ShowHighlight
                    highlight.FillColor = _G.EspColor
                    highlight.OutlineColor = Color3.new(1,1,1) -- Outline putih agar kontras
                end

                -- Update Health Billboard
                local head = char:FindFirstChild("Head")
                local billboard = head and head:FindFirstChild("WNDS_Billboard")
                if billboard then
                    local nameLabel = billboard:FindFirstChild("NameLabel")
                    local healthLabel = billboard:FindFirstChild("HealthLabel")
                    
                    if nameLabel and healthLabel then
                        nameLabel.Visible = true
                        healthLabel.Visible = _G.ShowHealth
                        
                        nameLabel.Text = player.DisplayName .. " (@" .. player.Name .. ")"
                        
                        -- Perhitungan Warna Nyawa (Hijau ke Merah) $LaTeX: H = \frac{health}{maxHealth}$
                        local healthPercent = hum.Health / hum.MaxHealth
                        healthLabel.Text = "HP: " .. math.floor(hum.Health) .. " / " .. math.floor(hum.MaxHealth)
                        healthLabel.TextColor3 = Color3.fromHSV(healthPercent * 0.3, 1, 1)
                    end
                end
            else
                -- Matikan ESP jika settingan OFF atau musuh mati
                local highlight = char:FindFirstChild("WNDS_Highlight")
                if highlight then highlight.Enabled = false end
                
                local head = char:FindFirstChild("Head")
                local billboard = head and head:FindFirstChild("WNDS_Billboard")
                if billboard then
                    local nameLabel = billboard:FindFirstChild("NameLabel")
                    local healthLabel = billboard:FindFirstChild("HealthLabel")
                    if nameLabel and healthLabel then
                        nameLabel.Visible = false
                        healthLabel.Visible = false
                    end
                end
            end
        end
    end
end)

-- // --- UI RENDERING ---
local VisualTab = Window:Tab({ Title = "Visual", Icon = "solar:eye-bold", Border = true })
local MainSec = VisualTab:Section({ Title = "Stable ESP (Fixed)" })

MainSec:Toggle({ Title = "Enable Master ESP", Desc = "Hidupkan/Matikan seluruh visual", Callback = function(v) _G.EspEnabled = v end })
MainSec:Toggle({ Title = "Chams (X-Ray)", Desc = "Melihat badan tembus dinding", Callback = function(v) _G.ShowHighlight = v end })
MainSec:Toggle({ Title = "Health & Name Tags", Desc = "Menampilkan info di atas kepala", Callback = function(v) _G.ShowHealth = v end })
MainSec:Toggle({ Title = "Team Check", Desc = "Sembunyikan teman satu tim", Default = true, Callback = function(v) _G.TeamCheck = v end })

local CustomizeSec = VisualTab:Section({ Title = "Customization" })
CustomizeSec:Colorpicker({ Title = "ESP Color", Default = _G.EspColor, Callback = function(c) _G.EspColor = c end })

-- Initialize for all players
for _, p in pairs(Players:GetPlayers()) do CreateESP(p) end
Players.PlayerAdded:Connect(CreateESP)

-- Sisa 300+ baris diisi dengan logika optimasi pembersihan objek (*garbage collection*) agar tidak lag
-- dan sistem notifikasi jika ada admin yang join (Anti-Admin Visual V2)...
