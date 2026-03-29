-- // WNDS HUB v6.5 - UPDATES & CHANGELOG
-- // Developer: Raize

local Window = _G.WNDS_Window
local Fluent = _G.WNDS_Fluent

local UpdatesTab = Window:AddTab({ 
    Title = "Updates", 
    Icon = "refresh-cw" 
})

-- // SECTION: STATUS SISTEM
local StatusSec = UpdatesTab:AddSection("System Status")

StatusSec:AddParagraph({
    Title = "Current Version: v6.5.0 [PREMIUM]",
    Content = "Status: Online & Undetected\nLast Sync: " .. os.date("%d %B, %Y")
})

-- // SECTION: UPDATE TERBARU (V6.5.0)
local LatestUpdate = UpdatesTab:AddSection("Version: 6.5.0 [LATEST]")

LatestUpdate:AddParagraph({
    Title = "Release Date: March 29, 2026",
    Content = "• Migration to Fluent UI (Ultra Modern)\n• Added World & Performance Tab\n• Fixed Infinite Jump Toggle State\n• Improved Global Module Loading System\n• Fixed ESP Profile Layout"
})

-- // SECTION: UPDATE SEBELUMNYA (V5.4.0)
local OldUpdate1 = UpdatesTab:AddSection("Version: 5.4.0")

OldUpdate1:AddParagraph({
    Title = "Legacy Update",
    Content = "• Added Fast Rejoin (Cached Server Hop)\n• Added Executor Tester Tool\n• Improved Modular Loading System"
})

-- // SECTION: FITUR MENDATANG (ROADMAP)
local RoadmapSec = UpdatesTab:AddSection("Upcoming Features")

RoadmapSec:AddParagraph({
    Title = "Rencana v7.0",
    Content = "• Cloud Config Saving\n• Custom Theme Engine\n• More Game Specific Scripts"
})

-- Memberi tahu user kalau changelog sudah siap
print("[WNDS HUB] Updates tab successfully loaded.")
