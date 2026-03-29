-- // WNDS HUB - OFFICIAL CHANGELOG SYSTEM
-- // Developer: Raize
-- // Version: 2.0.0 [LATEST]

local Window = _G.WNDS_Window
local Fluent = _G.WNDS_Fluent

local UpdatesTab = Window:AddTab({ 
    Title = "Updates", 
    Icon = "refresh-cw" 
})

-- // SECTION: STATUS SISTEM
local StatusSec = UpdatesTab:AddSection("System Status")

StatusSec:AddParagraph({
    Title = "Current Version: v2.0.0 [PREMIUM]",
    Content = "Status: Online & Undetected\nLast Sync: " .. os.date("%d %B, %Y")
})

-- // SECTION: UPDATE TERBARU (V2.0.0) - CURRENT VERSION
local UpdateV2 = UpdatesTab:AddSection("Version: 2.0.0 [LATEST]")

UpdateV2:AddParagraph({
    Title = "The Grand Migration (March 29, 2026)",
    Content = "• Complete UI Overhaul: Migrated to Fluent UI Framework.\n" ..
              "• Added World Tab: FPS Booster, Lighting & Gravity Control.\n" ..
              "• Added Misc Tab: Anti-AFK, Rejoin & Server Hop System.\n" ..
              "• Added Settings Tab: Auto-Config Save/Load (SaveManager).\n" ..
              "• New Security: 3-Tier Bootloader (Bootstrapper > Loader > Main).\n" ..
              "• Fix: Infinite Jump Toggle (On/Off Logic)."
})

-- // SECTION: UPDATE 3 (V1.2.0)
local UpdateV12 = UpdatesTab:AddSection("Version: 1.2.0")

UpdateV12:AddParagraph({
    Title = "Modular Update",
    Content = "• Added Modular Loading System (External Scripts).\n" ..
              "• Added Executor Tester Tool v2.\n" ..
              "• Added Visuals: Basic ESP Box & Tracers."
})

-- // SECTION: UPDATE 2 (V1.1.0)
local UpdateV11 = UpdatesTab:AddSection("Version: 1.1.0")

UpdateV11:AddParagraph({
    Title = "Feature Expansion",
    Content = "• Added Player Tweaks: WalkSpeed & JumpPower Sliders.\n" ..
              "• Added Infinite Jump (Beta).\n" ..
              "• Fixed UI Lag & Optimized Script Execution."
})

-- // SECTION: VERSI AWAL (V1.0.0)
local UpdateV10 = UpdatesTab:AddSection("Version: 1.0.0")

UpdateV10:AddParagraph({
    Title = "Initial Release",
    Content = "• First release of WNDS Hub.\n" ..
              "• Basic GUI with Main Features.\n" ..
              "• GitHub Hosting Integration."
})

print("[WNDS HUB] Changelog v2.0.0 Loaded Successfully.")
