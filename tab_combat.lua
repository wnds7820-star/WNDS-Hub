local Tabs = _G.WNDS_UI.Tabs
Tabs.Combat:Section({ Title = "Combat Master" })
Tabs.Combat:Toggle({ Title = "Aimbot", Callback = function(v) _G.Aimbot = v end })
Tabs.Combat:Toggle({ Title = "Silent Aim", Callback = function(v) end })
Tabs.Combat:Slider({ Title = "Hitbox Size", Step = 1, Value = {Min = 2, Max = 50, Default = 15}, Callback = function(v) _G.HSize = v end })
Tabs.Combat:Toggle({ Title = "Enable Hitbox", Callback = function(v) _G.Hitbox = v end })
Tabs.Combat:Button({ Title = "Kill All (Experimental)", Callback = function() end })
