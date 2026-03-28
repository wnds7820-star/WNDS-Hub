local Tabs = _G.WNDS_UI.Tabs
Tabs.Combat:Section({ Title = "Main Combat" })

local Features = {"Aimbot", "Silent Aim", "Wallbang", "Auto Clicker", "Fast Reload", "No Recoil", "No Spread", "Infinite Ammo", "Hitbox Expander", "Kill Aura"}
for _, v in pairs(Features) do
    Tabs.Combat:Toggle({ Title = v, Default = false, Callback = function(v) print(v .. " toggled") end })
end
