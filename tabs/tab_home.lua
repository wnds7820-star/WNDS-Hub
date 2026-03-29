local HomeTab = _G.WNDS_Window:AddTab({ Title = "Home", Icon = "home" })

HomeTab:AddParagraph({ 
    Title = "WNDS HUB v6.6 UPDATED!", 
    Content = "- Added Smooth Aimbot (Lerp System)\n- Added Smooth Speed Transition\n- Improved ESP Stability" 
})

local info = HomeTab:AddParagraph({ Title = "Statistics", Content = "Loading..." })
game:GetService("RunService").RenderStepped:Connect(function()
    local fps = math.floor(1/game:GetService("RunService").RenderStepped:Wait())
    local ping = math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue())
    info:SetContent("FPS: " .. fps .. " | Ping: " .. ping .. "ms")
end)
