-- // WNDS HUB v6.5.0 - UPDATES & CHANGELOG
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

-- // SECTION: UPDATE TERBARU (V6.5.0) - PEMBARUAN HARI INI
local LatestUpdate = UpdatesTab:AddSection("Version: 6.5.0 [LATEST]")

LatestUpdate:AddParagraph({
    Title = "Release Date: March 29, 2026",
    Content = "• Migration: Full transition to Fluent UI Framework.\n" ..
              "• New Tab: Added 'World' with FPS Booster & Lighting Control.\n" ..
              "• New Tab: Added 'Misc' with Anti-AFK, Rejoin, & Server Hop.\n" ..
              "• Logic: Integrated Fluent SaveManager for auto-config saving.\n" ..
              "• Security: Implemented 3-Tier Bootloader (Bootstrapper > Loader > Main).\n" ..
              "• Fix: Repositioned & fixed Infinite Jump toggle state (On/Off logic)."
})

-- // SECTION: UPDATE SEBELUMNYA (V5.4.0)
local OldUpdate1 = UpdatesTab:AddSection("Version: 5.4.0")

OldUpdate1:AddParagraph({
    Title = "Legacy Update",
    Content = "• Added Fast Rejoin (Cached Server Hop).\n" ..
              "• Added Executor Tester Tool v1.\n" ..
              "• Improved Modular Loading System."
})

-- // SECTION: FITUR MENDATANG (ROADMAP)
local RoadmapSec = UpdatesTab:AddSection("Upcoming Features")

RoadmapSec:AddParagraph({
    Title = "Rencana v7.0",
    Content = "• Cloud Config Saving (Database Integration).\n" ..
              "• Custom Theme Engine (User-defined colors).\n" ..
              "• Game Specific Tabs (Blox Fruits, Brookhaven, etc)."
})

-- Memberi tahu user kalau changelog sudah siap
print("[WNDS HUB] Updates tab successfully loaded with v6.5.0 changelog.")
