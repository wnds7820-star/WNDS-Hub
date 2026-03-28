local Tabs = _G.WNDS_UI.Tabs
Tabs.Settings:Section({ Title = "Configuration" })

Tabs.Settings:Button({ Title = "Destroy UI", Callback = function() _G.WNDS_UI.Window:Destroy() end })
local Configs = {"Save Config", "Load Config", "Auto Rejoin", "Server Hop", "Anti-AFK", "Low Graphics", "Rejoin Server", "Hide UI", "Show FPS"}
for _, v in pairs(Configs) do
    Tabs.Settings:Toggle({ Title = v, Default = false, Callback = function(v) print(v) end })
end
