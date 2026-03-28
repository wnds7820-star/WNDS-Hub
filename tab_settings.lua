local Tabs = _G.WNDS_UI.Tabs
Tabs.Settings:Section({ Title = "System" })
Tabs.Settings:Button({ Title = "Reload Script", Callback = function() _G.WNDS_UI.Window:Destroy(); loadstring(game:HttpGet("https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/main.lua"))() end })
local s = {"Anti-AFK", "Auto Rejoin", "Server Hop", "Low Graphics", "Show FPS", "Anti-Kick"}
for _, v in pairs(s) do
    Tabs.Settings:Toggle({ Title = v, Default = false, Callback = function(state) print(v .. " is " .. tostring(state)) end })
end
