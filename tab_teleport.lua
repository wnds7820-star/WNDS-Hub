local Tabs = _G.WNDS_UI.Tabs
Tabs.Teleport:Section({ Title = "Quick TP" })
local tp = {"Spawn", "Shop", "Farm Area", "PVP Arena"}
for _, v in pairs(tp) do
    Tabs.Teleport:Button({ Title = "TP to " .. v, Callback = function() print("Teleporting...") end })
end
