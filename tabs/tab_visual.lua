local VisualTab = Window:Tab({
    Title = "Visual",
    Icon = "solar:eye-bold",
    Border = true,
})

local EspSection = VisualTab:Section({ Title = "Extra Sensory Perception" })

EspSection:Toggle({
    Title = "Player ESP",
    Desc = "Melihat nama pemain lain",
    Callback = function(v)
        _G.EspEnabled = v
        -- Tambahkan logika ESP library kamu di sini
    end,
})

EspSection:Colorpicker({
    Title = "ESP Color",
    Default = Color3.fromRGB(255, 255, 255),
    Callback = function(color) _G.EspColor = color end,
})

local WorldSection = VisualTab:Section({ Title = "World Modifier" })

WorldSection:Button({
    Title = "Full Bright",
    Callback = function()
        game:GetService("Lighting").Brightness = 2
        game:GetService("Lighting").ClockTime = 14
        game:GetService("Lighting").FogEnd = 100000
    end,
})
