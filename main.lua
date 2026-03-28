local base_url = "https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/"
local function SafeLoad(file)
    local s, content = pcall(function() return game:HttpGet(base_url .. file) end)
    if s and content then
        local func = loadstring(content)
        if func then return func() end
    end
end
task.spawn(function() SafeLoad("loader_intro.lua") end)
task.wait(4.5)
_G.WNDS_Data = SafeLoad("info_data.lua")
_G.WNDS_UI = SafeLoad("ui_config.lua")
-- Memanggil file fitur per tab
SafeLoad("tab_combat.lua")
SafeLoad("tab_visuals.lua")
SafeLoad("tab_player.lua")
SafeLoad("tab_teleport.lua")
SafeLoad("tab_settings.lua")
