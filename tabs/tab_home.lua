-- // tab_home.lua
local Player = game.Players.LocalPlayer

local HomeTab = Window:Tab({
    Title = "Home",
    Icon = "solar:home-2-bold",
    Border = true,
})

-- SECTION: PROFILE
local ProfileSection = HomeTab:Section({ Title = "User Dashboard" })

ProfileSection:Paragraph({
    Title = "Welcome, " .. Player.DisplayName,
    Desc = "Username: @" .. Player.Name .. "\nUser ID: " .. Player.UserId .. "\nAccount Age: " .. Player.AccountAge .. " Days",
    Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. Player.UserId .. "&width=420&height=420&format=png",
    ImageSize = 64,
})

-- SECTION: EXECUTOR & SYSTEM
local SysSection = HomeTab:Section({ Title = "System Info" })

local exec = (identifyexecutor and identifyexecutor() or "Unknown/Mobile")
SysSection:Paragraph({
    Title = "Hardware & Software",
    Desc = "Executor: " .. exec .. "\nPlace ID: " .. game.PlaceId .. "\nJob ID: " .. game.JobId,
    Icon = "solar:monitor-bold"
})

-- SECTION: QUICK ACTIONS
local ActionSection = HomeTab:Section({ Title = "Quick Actions" })

ActionSection:Button({
    Title = "Copy Invite Discord",
    Callback = function()
        setclipboard("https://discord.gg/wndshub")
        WindUI:Notify({Title = "Success", Content = "Link Copied!"})
    end
})

ActionSection:Button({
    Title = "Rejoin Server",
    Callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, Player)
    end
})
