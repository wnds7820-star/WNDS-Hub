local Tabs = _G.WNDS_UI.Tabs
Tabs.Player:Section({ Title = "Physical" })

Tabs.Player:Slider({ Title = "WalkSpeed", Min = 16, Max = 500, Default = 16, Callback = function(v) game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v end })
Tabs.Player:Slider({ Title = "JumpPower", Min = 50, Max = 500, Default = 50, Callback = function(v) game.Players.LocalPlayer.Character.Humanoid.JumpPower = v end })

local Toggles = {"Infinite Jump", "Fly Mode", "No Clip", "God Mode", "Anti-Fling", "Auto Farm", "Spin Bot", "Invisibility"}
for _, v in pairs(Toggles) do
    Tabs.Player:Toggle({ Title = v, Default = false, Callback = function(val) print(v .. " is " .. tostring(val)) end })
end
