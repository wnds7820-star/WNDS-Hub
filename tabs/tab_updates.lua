-- // WNDS HUB - OFFICIAL CHANGELOG SYSTEM
-- // Developer: Raize
-- // Version: [LATEST]

local Window = _G.WNDS_Window
local Fluent = _G.WNDS_Fluent

local UpdatesTab = Window:AddTab({ 
    Title = "Updates", 
    Icon = "refresh-cw" 
})

-- // SECTION: STATUS SISTEM
local StatusSec = UpdatesTab:AddSection("System Status")

StatusSec:AddParagraph({
    Title = "Current Version: [NEW]",
    Content = "Status: Online & Undetected\nLast Sync: " .. os.date("%d %B, %Y")
})

-- // SECTION: UPDATE TERBARU (V1.7.0)
local UpdateV17 = UpdatesTab:AddSection("Version: 1.7.0 [NEW]")

UpdateV15:AddParagraph({ -- FIX: Harus pakai UpdateV15
    Title = "Rencana Fitur Selanjutnya",
    Content = "• Bug Fixes\n" ..

-- // SECTION: UPDATE TERBARU (V1.6.0)
local UpdateV16 = UpdatesTab:AddSection("Version: 1.6.0 [NEW]")

UpdateV16:AddParagraph({ -- FIX: Harus pakai UpdateV16
    Title = "Rencana Fitur Selanjutnya",
    Content = "• Bug Fixes\n" ..
})

-- // SECTION: UPDATE TERBARU (V1.5.0)
local UpdateV15 = UpdatesTab:AddSection("Version: 1.5.0 [NEW]")

UpdateV15:AddParagraph({ -- FIX: Harus pakai UpdateV15
    Title = "Rencana Fitur Selanjutnya",
    Content = "• Cloud Config System (Database)\n" ..
              "• Custom Theme Engine\n" ..
              "• Auto-Farm Level (Experimental)\n" ..
              "• Speed Bypass Anti-Cheat"
})

-- // SECTION: UPDATE TERBARU (V1.4.0) 
local UpdateV14 = UpdatesTab:AddSection("Version: 1.4.0")

UpdateV14:AddParagraph({ -- FIX: Harus pakai UpdateV14
    Title = "Rencana Update v3.0 (God Tier)",
    Content = "• Silent Aim & FOV Customization\n" ..
              "• Chams & Tracer Visuals (Wallhack)\n" ..
              "• Tween Fly & Experimental Noclip\n" ..
              "• Custom Theme Engine (User Colors)\n" ..
              "• Cloud Config sharing system\n" ..
              "• Auto-Farm logic for Top 5 Roblox Games"
})

-- // SECTION: UPDATE TERBARU (V1.3.0)
local UpdateV13 = UpdatesTab:AddSection("Version: 1.3.0")

UpdateV13:AddParagraph({ -- FIX: Harus pakai UpdateV13
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

print("[WNDS HUB] Changelog Updated Successfully.")
