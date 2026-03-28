local Tabs = _G.WNDS_UI.Tabs
Tabs.Teleport:Section({ Title = "Locations" })

local Locs = {"Spawn", "Shop", "Farm Zone", "Quest NPC", "Boss Arena", "PVP Zone", "Safe Zone", "Hidden Room", "Event Area", "Lobby"}
for _, v in pairs(Locs) do
    Tabs.Teleport:Button({ Title = "TP to " .. v, Callback = function() print("Teleporting to " .. v) end })
end
