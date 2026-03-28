local Tabs = _G.WNDS_UI.Tabs
Tabs.Settings:Section({ Title = "Interface & World" })
Tabs.Settings:Toggle({ Title = "FullBright", Callback = function(v) end })
Tabs.Settings:Button({ Title = "FPS Optimizer", Callback = function() end })
Tabs.Settings:Button({ Title = "Clean Chat", Callback = function() end })
Tabs.Settings:Button({ Title = "Rejoin Server", Callback = function() end })
Tabs.Settings:Button({ Title = "Destroy UI", Callback = function() _G.WNDS_UI.Window:Destroy() end })
