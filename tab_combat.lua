local Tabs = _G.WNDS_UI.Tabs
Tabs.Combat:Section({ Title = "Aim Assistance" })
Tabs.Combat:Toggle({ Title = "Aimbot", Default = false, Callback = function(s) _G.Aimbot = s end })
Tabs.Combat:Toggle({ Title = "Silent Aim", Default = false, Callback = function(s) _G.SilentAim = s end })
Tabs.Combat:Section({ Title = "Gun Mods" })
local guns = {"No Recoil", "No Spread", "Infinite Ammo", "Rapid Fire", "Kill Aura"}
for _, v in pairs(guns) do
    Tabs.Combat:Toggle({ Title = v, Default = false, Callback = function(s) print(v .. " is " .. tostring(s)) end })
end
