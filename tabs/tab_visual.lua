-- // WNDS HUB v5.4 - VISUAL (ESP) MODULE
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Variabel Kontrol
_G.EspEnabled = _G.EspEnabled or false
_G.EspColor = _G.EspColor or Color3.fromRGB(255, 0, 0) -- Default Merah

local VisualTab = Window:Tab({
    Title = "Visual",
    Icon = "solar:eye-bold",
    Border = true,
})

local EspSection = VisualTab:Section({ Title = "Extra Sensory Perception" })

-- Toggle Utama ESP
EspSection:Toggle({
    Title = "Player ESP (Names)",
    Desc = "Melihat nama pemain menembus dinding",
    Callback = function(v)
        _G.EspEnabled = v
        if not v then
            -- Bersihkan ESP saat dimatikan
            for _, player in pairs(Players:GetPlayers()) do
                if player.Character and player.Character:FindFirstChild("WNDS_ESP") then
                    player.Character.WNDS_ESP:Destroy()
                end
            end
        end
    end,
})

-- Pengatur Warna ESP
EspSection:Colorpicker({
    Title = "ESP Color",
    Default = _G.EspColor,
    Callback = function(color) 
        _G.EspColor = color 
    end,
})

-- // LOGIKA UTAMA ESP (Looping)
RunService.RenderStepped:Connect(function()
    if _G.EspEnabled then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local char = player.Character
                local root = char.HumanoidRootPart
                
                -- Cek apakah sudah ada Highlight/ESP
                local esp = char:FindFirstChild("WNDS_ESP") or Instance.new("Highlight")
                esp.Name = "WNDS_ESP"
                esp.Parent = char
                
                -- Setting Tampilan
                esp.FillTransparency = 0.5 -- Transparansi isi badan
                esp.OutlineTransparency = 0 -- Garis pinggir jelas
                esp.FillColor = _G.EspColor
                esp.OutlineColor = Color3.fromRGB(255, 255, 255) -- Garis luar putih agar kontras
            end
        end
    end
end)

local WorldSection = VisualTab:Section({ Title = "World Modifier" })

WorldSection:Button({
    Title = "Full Bright",
    Desc = "Menghilangkan kegelapan di map",
    Callback = function()
        game:GetService("Lighting").Brightness = 2
        game:GetService("Lighting").ClockTime = 14
        game:GetService("Lighting").FogEnd = 100000
        game:GetService("Lighting").GlobalShadows = false
    end,
})
