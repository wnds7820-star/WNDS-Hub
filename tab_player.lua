local Tabs = _G.WNDS_UI.Tabs
Tabs.Player:Section({ Title = "Movement" })
Tabs.Player:Slider({ Title = "Speed", Min = 16, Max = 500, Default = 16, Callback = function(v) game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v end })
Tabs.Player:Toggle({ Title = "Infinite Jump", Default = false, Callback = function(s) _G.InfJump = s end })
Tabs.Player:Toggle({ Title = "Fly Mode", Default = false, Callback = function(s) _G.Fly = s end })
Tabs.Player:Section({ Title = "Exploits" })
local p = {"Noclip", "God Mode", "Anti-Fling", "Spin Bot", "Auto Farm"}
for _, v in pairs(p) do
    Tabs.Player:Toggle({ Title = v, Default = false, Callback = function(s) print(v .. " is " .. tostring(s)) end })
end
