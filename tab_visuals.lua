local Tabs = _G.WNDS_UI.Tabs
Tabs.Visuals:Section({ Title = "ESP & Vision" })
Tabs.Visuals:Toggle({ Title = "Box ESP", Callback = function(v) end })
Tabs.Visuals:Toggle({ Title = "Tracer ESP", Callback = function(v) end })
Tabs.Visuals:Toggle({ Title = "Name ESP", Callback = function(v) end })
Tabs.Visuals:Toggle({ Title = "Distance ESP", Callback = function(v) end })
Tabs.Visuals:Toggle({ Title = "Chams (Highlight)", Callback = function(v) _G.ESPChams = v end })
