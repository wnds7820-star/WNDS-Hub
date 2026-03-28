local Tabs = _G.WNDS_UI.Tabs
Tabs.Visuals:Section({ Title = "ESP" })
local vists = {"Player ESP", "Box ESP", "Tracer ESP", "Name ESP", "Chams (Wallhack)"}
for _, v in pairs(vists) do
    Tabs.Visuals:Toggle({ Title = v, Default = false, Callback = function(s) print(v .. " is " .. tostring(s)) end })
end
Tabs.Visuals:Section({ Title = "World" })
Tabs.Visuals:Toggle({ Title = "Full Bright", Default = false, Callback = function(v) game.Lighting.Brightness = v and 2 or 1 end })
