-- // UPDATE BAGIAN TABS.INFO DI UI_CONFIG.LUA

Tabs.Info:Section({ Title = "User Dashboard" })

-- Profil dengan Foto
local ProfileWidget = Tabs.Info:Paragraph({
    Title = "Welcome, " .. _G.WNDS_Data.DisplayName .. " (@" .. _G.WNDS_Data.Username .. ")",
    Desc = "Project: WNDS Hub v5.4\nStatus: Active (Authorized)",
    Image = _G.WNDS_Data.Avatar,
    ImageSize = 64
})

Tabs.Info:Section({ Title = "Live Server Status" })

-- Label untuk Ping & FPS (Akan diupdate terus)
local StatsLabel = Tabs.Info:Paragraph({
    Title = "Performance Metrics",
    Desc = "Loading stats..."
})

-- Looping Update Stats (Ping & FPS)
task.spawn(function()
    while task.wait(1) do
        local fps = math.floor(1 / game:GetService("RunService").RenderStepped:Wait())
        local ping = tonumber(string.format("%.0f", game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()))
        local time = os.date("%H:%M:%S")
        
        StatsLabel:SetDesc(
            "• Current FPS: " .. fps .. " FPS" ..
            "\n• Server Ping: " .. ping .. " ms" ..
            "\n• Local Time: " .. time
        )
    end
end)

Tabs.Info:Section({ Title = "Game & System Details" })

Tabs.Info:Paragraph({
    Title = "Environment Info",
    Desc = "• Game: " .. _G.WNDS_Data.GameName .. 
           "\n• Place ID: " .. game.PlaceId .. 
           "\n• Account Age: " .. _G.WNDS_Data.AccountAge .. " Days" ..
           "\n• Executor: " .. _G.WNDS_Data.Executor ..
           "\n• Device: " .. _G.WNDS_Data.Platform
})

Tabs.Info:Section({ Title = "Quick Shortcuts" })

Tabs.Info:Button({
    Title = "Copy Job ID (Server)",
    Callback = function() setclipboard(game.JobId) end
})

Tabs.Info:Button({
    Title = "Copy Game Link",
    Callback = function() setclipboard("https://www.roblox.com/games/" .. game.PlaceId) end
})
