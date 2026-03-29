local WorldTab = Window:Tab({ Title = "World", Icon = "solar:earth-bold", Border = true })
local EnvSec = WorldTab:Section({ Title = "Environment" })

EnvSec:Button({
    Title = "Remove Fog",
    Callback = function() game:GetService("Lighting").FogEnd = 9e9 end
})

EnvSec:Toggle({
    Title = "Low Graphics (FPS Boost)",
    Callback = function(v)
        for _, obj in pairs(game:GetDescendants()) do
            if obj:IsA("BasePart") then obj.Material = Enum.Material.SmoothPlastic end
        end
    end
})
