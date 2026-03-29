local HomeTab = _G.WNDS_Window:AddTab({ Title = "Home", Icon = "home" })
local info = HomeTab:AddParagraph({ Title = "WNDS Statistics", Content = "Calculating..." })

game:GetService("RunService").RenderStepped:Connect(function()
    local fps = math.floor(1/game:GetService("RunService").RenderStepped:Wait())
    local ping = math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue())
    info:SetContent("FPS: " .. fps .. " | Ping: " .. ping .. "ms\nAccount: " .. game.Players.LocalPlayer.Name)
end)
