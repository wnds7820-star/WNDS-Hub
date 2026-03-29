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
    Desc = "Username: @" .. Player.Name .. "\nUser ID: " .. Player.UserId,
    Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. Player.UserId .. "&width=420&height=420&format=png",
    ImageSize = 64,
})

-- SECTION INFO AKUN (Ditambah Umur Akun)
local AccInfo = HomeTab:Section({ Title = "Account Details" })
AccInfo:Paragraph({
    Title = "Account Age",
    Desc = Player.AccountAge .. " Days since creation",
    Icon = "solar:calendar-bold"
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
    Title = "Copy Job ID",
    Desc = "Salin ID Server saat ini",
    Callback = function()
        setclipboard(game.JobId)
        WindUI:Notify({Title = "Success", Content = "Job ID Copied!"})
    end
})

ActionSection:Button({
    Title = "Fast Rejoin / Server Hop",
    Desc = "Pindah server dengan cepat menggunakan Cached Script",
    Color = Color3.fromHex("#30ff6a"),
    Callback = function()
        WindUI:Notify({Title = "WNDS Hub", Content = "Searching for fastest server..."})
        loadstring(game:HttpGet('https://raw.githubusercontent.com/Cesare0328/my-scripts/refs/heads/main/CachedServerhop.lua'))()
    end
})
