-- // WNDS HUB - OFFICIAL CHANGELOG SYSTEM
-- // Developer: Made for you
-- // Version: [LATEST]

local Window = _G.WNDS_Window
local Fluent = _G.WNDS_Fluent

-- Pastikan Window ada sebelum nambah Tab
if Window then
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

    -- // SECTION: UPDATE TERBARU (V1.5.0)
    local UpdateV15 = UpdatesTab:AddSection("Version: 1.5.0 [NEW]")

    UpdateV15:AddParagraph({ 
        Title = "Rencana Fitur Selanjutnya",
        Content = "• Bug Fixes\n• Cloud Config System (Database)\n• Custom Theme Engine\n• Auto-Farm Level (Experimental)\n• Speed Bypass Anti-Cheat"
    })

    -- // SECTION: UPDATE TERBARU (V1.4.0) 
    local UpdateV14 = UpdatesTab:AddSection("Version: 1.4.0")

    UpdateV14:AddParagraph({ 
        Title = "Rencana Update v3.0 (God Tier)",
        Content = "• Silent Aim & FOV Customization\n• Chams & Tracer Visuals (Wallhack)\n• Tween Fly & Experimental Noclip\n• Custom Theme Engine (User Colors)\n• Cloud Config sharing system\n• Auto-Farm logic for Top 5 Roblox Games"
    })

    -- // SECTION: UPDATE TERBARU (V1.3.0)
    local UpdateV13 = UpdatesTab:AddSection("Version: 1.3.0")

    UpdateV13:AddParagraph({ 
        Title = "The Grand Migration (March 29, 2026)",
        Content = "• Complete UI Overhaul: Migrated to Fluent UI Framework.\n• Added World Tab: FPS Booster, Lighting & Gravity Control.\n• Added Misc Tab: Anti-AFK, Rejoin & Server Hop System.\n• Added Settings Tab: Auto-Config Save/Load (SaveManager).\n• New Security: 3-Tier Bootloader (Bootstrapper > Loader > Main).\n• Fix: Infinite Jump Toggle (On/Off Logic)."
    })

    -- // SECTION: UPDATE SEBELUMNYA
    local OldUpdates = UpdatesTab:AddSection("Previous Versions")

    OldUpdates:AddParagraph({
        Title = "Archive (v1.0.0 - v1.2.0)",
        Content = "• Modular Loading System\n• Executor Tester Tool v2\n• Basic ESP & Tracers\n• WalkSpeed & JumpPower Sliders"
    })

    print("[WNDS HUB] Changelog Tab Loaded Successfully.")
else
    warn("[WNDS HUB] Error: Window not found. Make sure Main Script is running first!")
end