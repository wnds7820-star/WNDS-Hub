local Tabs = _G.WNDS_UI.Tabs
Tabs.Player:Section({ Title = "Movement" })
Tabs.Player:Slider({ Title = "Speed", Step = 1, Value = {Min = 16, Max = 300, Default = 16}, Callback = function(v) game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v end })
Tabs.Player:Slider({ Title = "Jump", Step = 1, Value = {Min = 50, Max = 300, Default = 50}, Callback = function(v) game.Players.LocalPlayer.Character.Humanoid.JumpPower = v end })
Tabs.Player:Toggle({ Title = "Infinite Jump", Callback = function(v) _G.InfJump = v end })
Tabs.Player:Toggle({ Title = "Noclip", Callback = function(v) _G.Noclip = v end })
Tabs.Player:Toggle({ Title = "Anti-AFK", Callback = function(v) end })
