-- // WNDS HUB v5.4 - STABLE VISUAL (ESP)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Pastikan variabel global siap
_G.EspEnabled = _G.EspEnabled or false
_G.EspColor = _G.EspColor or Color3.fromRGB(0, 255, 120)

local VisualTab = Window:Tab({
    Title = "Visual",
    Icon = "solar:eye-bold",
    Border = true,
})

local EspSection = VisualTab:Section({ Title = "Extra Sensory Perception" })

-- Toggle ESP
EspSection:Toggle({
    Title = "Player ESP",
    Desc = "Menampilkan kotak di sekitar musuh",
    Callback = function(v)
        _G.EspEnabled = v
    end,
})

-- Color Picker
EspSection:Colorpicker({
    Title = "ESP Color",
    Default = _G.EspColor,
    Callback = function(color) _G.EspColor = color end,
})

-- // LOGIKA ESP MENGGUNAKAN BOX (Lebih Ringan & Support All Executor)
local function CreateESP(plr)
    local Box = Instance.new("BoxHandleAdornment")
    Box.Name = "WNDS_Box"
    Box.AlwaysOnTop = true
    Box.ZIndex = 10
    Box.Adornee = nil
    Box.Transparency = 0.5
    Box.Color3 = _G.EspColor
    Box.Size = Vector3.new(4, 6, 1) -- Ukuran kotak standar karakter
    Box.Parent = game:GetService("CoreGui")

    RunService.RenderStepped:Connect(function()
        if _G.EspEnabled and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            Box.Adornee = plr.Character.HumanoidRootPart
            Box.Visible = true
            Box.Color3 = _G.EspColor
        else
            Box.Visible = false
        end
    end)
end

-- Terapkan ke semua pemain
for _, p in pairs(Players:GetPlayers()) do
    if p ~= LocalPlayer then CreateESP(p) end
end

Players.PlayerAdded:Connect(function(p)
    if p ~= LocalPlayer then CreateESP(p) end
end)
