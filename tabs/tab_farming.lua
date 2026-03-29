local FarmTab = Window:Tab({ Title = "Farming", Icon = "solar:ghost-bold", Border = true })
local FarmSec = FarmTab:Section({ Title = "Auto Farming" })

FarmSec:Toggle({
    Title = "Auto Clicker",
    Callback = function(v) _G.AutoClick = v end
})

FarmSec:Toggle({
    Title = "Auto Collect Drops",
    Callback = function(v) _G.AutoCollect = v end
})
