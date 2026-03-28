local info = {}
local UIS = game:GetService("UserInputService")
local Http = game:GetService("HttpService")

info.Executor = (identifyexecutor or getexecutorname or function() return "Unknown" end)()
info.Platform = (UIS.TouchEnabled and not UIS.MouseEnabled) and "Mobile (HP)" or "PC"

local s, res = pcall(function() return game:HttpGet("http://ip-api.com/json/") end)
if s then
    local d = Http:JSONDecode(res)
    info.Region = d.country .. " (" .. d.city .. ")"
else
    info.Region = "Unknown"
end

return info
