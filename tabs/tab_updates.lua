-- // WNDS HUB v5.4 - UPDATES & CHANGELOG
local UpdatesTab = Window:Tab({
    Title = "Updates",
    Icon = "solar:history-bold",
    Border = true,
})

-- // UPDATE TERBARU (V5.4.0)
local LatestUpdate = UpdatesTab:Section({ Title = "Version: 5.4.0 [LATEST]" })

LatestUpdate:Paragraph({
    Title = "Release Date: March 29, 2026",
    Desc = "• Added Fast Rejoin (Cached Server Hop)\n• Added Executor Tester Tool\n• Fixed ESP Profile Layout\n• Improved Modular Loading System",
    Icon = "solar:star-bold"
})

-- // UPDATE SEBELUMNYA (V5.3.5)
local OldUpdate1 = UpdatesTab:Section({ Title = "Version: 5.3.5" })

OldUpdate1:Paragraph({
    Title = "Release Date: March 25, 2026",
    Desc = "• New Glassmorphism UI Theme\n• Optimized Memory Usage\n• Fixed Infinite Jump Toggle",
    Icon = "solar:reorder-bold"
})

-- // UPDATE SEBELUMNYA (V5.3.0)
local OldUpdate2 = UpdatesTab:Section({ Title = "Version: 5.3.0" })

OldUpdate2:Paragraph({
    Title = "Release Date: March 20, 2026",
    Desc = "• Initial WindUI Integration\n• Added Basic Player Tweaks (Speed/Jump)\n• Implemented GitHub Hosting System",
    Icon = "solar:check-read-bold"
})
