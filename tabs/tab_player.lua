local PlayerTab = _G.WNDS_Window:AddTab({ Title = "Player", Icon = "user" })
_G.WNDS_WS = 16
_G.WNDS_JP = 50

PlayerTab:AddSlider("WS", {Title = "WalkSpeed", Default = 16, Min = 16, Max = 250, Rounding = 1, Callback = function(v) _G.WNDS_WS = v end})
PlayerTab:AddSlider("JP", {Title = "JumpPower", Default = 50, Min = 50, Max = 500, Rounding = 1, Callback = function(v) _G.WNDS_JP = v end})

game:GetService("RunService").Stepped:Connect(function()
    pcall(function()
        local hum = game.Players.LocalPlayer.Character.Humanoid
        hum.WalkSpeed = _G.WNDS_WS
        hum.JumpPower = _G.WNDS_JP
    end)
end)
