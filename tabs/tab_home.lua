-- // WNDS HUB v5.4 - HOME TAB (PREMIUM EDITION)
local Player = game.Players.LocalPlayer
local HttpService = game:GetService("HttpService")

-- Fungsi Deteksi Executor
local function GetExecutor()
    return identifyexecutor and identifyexecutor() or "Unknown Executor"
end

-- Fungsi Hitung Umur Akun
local function GetAccountAge()
    return Player.AccountAge .. " Days"
end

local HomeTab = Window:Tab({
    Title = "Home",
    Icon = "solar:home-2-bold",
    Border = true,
})

-- // --- SECTION: USER PROFILE ---
local ProfileSection = HomeTab:Section({ Title = "Player Profile" })

ProfileSection:Paragraph({
    Title = "Welcome, " .. Player.DisplayName .. " (@" .. Player.Name .. ")",
    Desc = "Status: Premium User (Active)\nAccount Age: " .. GetAccountAge(),
    Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. Player.UserId .. "&width=420&height=420&format=png",
    ImageSize = 64,
})

-- // --- SECTION: SYSTEM INFO ---
local SystemSection = HomeTab:Section({ Title = "System Information" })

SystemSection:Paragraph({
    Title = "Technical Specs",
    Desc = "Executor: " .. GetExecutor() .. 
           "\nDevice: " .. (game:GetService("UserInputService").TouchEnabled and "Mobile" or "PC") ..
           "\nPing: " .. math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()) .. "ms" ..
           "\nGame ID: " .. game.PlaceId,
    Icon = "solar:monitor-bold",
})

-- // --- SECTION: INTERACTIVE BUTTONS ---
local ActionSection = HomeTab:Section({ Title = "Quick Actions" })

ActionSection:Button({
    Title = "Copy Job ID",
    Desc = "Copy current server ID",
    Justify = "Center",
    Callback = function()
        setclipboard(game.JobId)
        WindUI:Notify({ Title = "Success", Content = "Job ID Copied!" })
    end
})

ActionSection:Button({
    Title = "Rejoin Server",
    Justify = "Center",
    Callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, Player)
    end
})

-- // --- SECTION: CREDITS ---
local CreditSection = HomeTab:Section({ Title = "WNDS Hub Credits" })

CreditSection:Paragraph({
    Title = "Developed by Raize",
    Desc = "Version: 5.4.0\nFramework: WindUI (Premium Edition)",
    Icon = "solar:star-bold",
})

CreditSection:Button({
    Title = "Copy Discord Invite",
    Color = Color3.fromHex("#7289da"),
    Callback = function()
        setclipboard("https://discord.gg/wndshub")
        WindUI:Notify({ Title = "Discord", Content = "Invite Link Copied!" })
    end
})
