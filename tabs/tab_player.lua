--[[
    WNDS HUB - PLAYER MODULE v6.6
    Added: Smooth Speed Transition
]]
local PlayerTab = _G.WNDS_Window:AddTab({ Title = "Player", Icon = "user" })
local RunService = game:GetService("RunService")

_G.WNDS_WS = 16
_G.WNDS_JP = 50

PlayerTab:AddSlider("WS", {Title = "WalkSpeed", Default = 16, Min = 16, Max = 250, Rounding = 1, Callback = function(v) _G.WNDS_WS = v end})
PlayerTab:AddSlider("JP", {Title = "JumpPower", Default = 50, Min = 50, Max = 500, Rounding = 1, Callback = function(v) _G.WNDS_JP = v end})

RunService.Stepped:Connect(function()
    pcall(function()
        local hum = game.Players.LocalPlayer.Character.Humanoid
        -- Smooth WalkSpeed transition menggunakan lerp sederhana
        hum.WalkSpeed = hum.WalkSpeed + (_G.WNDS_WS - hum.WalkSpeed) * 0.1
        hum.JumpPower = _G.WNDS_JP
    end)
end)
