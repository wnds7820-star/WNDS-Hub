local Tabs = _G.WNDS_UI.Tabs
Tabs.Visuals:Section({ Title = "ESP & World" })

local Visuals = {"Player ESP", "Box ESP", "Tracer ESP", "Skeleton ESP", "Distance ESP", "Item ESP", "Full Bright", "No Fog", "Wallhack", "Chams"}
for _, v in pairs(Visuals) do
    Tabs.Visuals:Toggle({ Title = v, Default = false, Callback = function(v) print(v) end })
end
