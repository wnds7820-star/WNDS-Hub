local Tabs = _G.WNDS_UI.Tabs

Tabs.Info:Section({ Title = "User Dashboard" })

-- Profil User
Tabs.Info:Paragraph({
    Title = "Welcome, " .. (_G.WNDS_Data.DisplayName or "User"),
    Desc = "Project: WNDS Hub v5.4\nStatus: Authorized",
    Image = _G.WNDS_Data.Avatar or "rbxassetid://0",
    ImageSize = 64
})

Tabs.Info:Section({ Title = "Live Performance" })

-- Label Statistik
local StatsLabel = Tabs.Info:Paragraph({
    Title = "Metrics",
    Desc = "Calculating..."
})

task.spawn(function()
    while task.wait(1) do
        local fps = math.floor(1 / game:GetService("RunService").RenderStepped:Wait())
        StatsLabel:SetDesc("• Current FPS: " .. fps .. " FPS\n• Platform: " .. (_G.WNDS_Data.Platform or "Unknown"))
    end
end)
