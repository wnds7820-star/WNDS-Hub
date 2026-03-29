-- // WNDS HUB v5.4 - OFFICIAL MASTER LOADER
-- // Base: WindUI Framework Standard

local cloneref = (cloneref or clonereference or function(instance) return instance end)
local HttpService = cloneref(game:GetService("HttpService"))
local RunService = cloneref(game:GetService("RunService"))

local WindUI

-- // --- LOAD LIBRARY ---
do
    local success, result = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
    end)

    if success then
        WindUI = result
    else
        warn("❌ [WNDS]: Gagal memuat library UI. Pastikan internet lancar.")
        return
    end
end

-- // --- WINDOW CREATION ---
local Window = WindUI:CreateWindow({
    Title = "WNDS HUB v5.4",
    Author = "by Raize",
    Folder = "WNDS_Configs",
    Icon = "solar:folder-2-bold-duotone",
    NewElements = true,
    OpenButton = {
        Title = "Open WNDS Hub",
        CornerRadius = UDim.new(1, 0),
        Enabled = true,
        Draggable = true,
        Scale = 0.5,
        Color = ColorSequence.new(
            Color3.fromHex("#30FF6A"),
            Color3.fromHex("#e7ff2f")
        ),
    },
    Topbar = {
        Height = 44,
        ButtonsType = "Mac",
    },
})

-- // --- TAGS (VERSION) ---
Window:Tag({
    Title = "v5.4 OFFICIAL",
    Icon = "github",
    Color = Color3.fromHex("#1c1c1c"),
    Border = true,
})

-- // --- SECTIONS ---
local MainSection = Window:Section({ Title = "Main Features" })
local PlayerSection = Window:Section({ Title = "Character & World" })
local ConfigSection = Window:Section({ Title = "System" })

-- // --- TAB: HOME (INFO) ---
do
    local HomeTab = MainSection:Tab({
        Title = "Home",
        Desc = "User Dashboard",
        Icon = "solar:home-2-bold",
        IconShape = "Square",
        Border = true,
    })

    HomeTab:Section({ Title = "Welcome, " .. game.Players.LocalPlayer.DisplayName })

    HomeTab:Button({
        Title = "Join Discord",
        Justify = "Center",
        Callback = function()
            setclipboard("https://discord.gg/wndshub")
            WindUI:Notify({ Title = "Discord", Content = "Link copied to clipboard!" })
        end,
    })
end

-- // --- TAB: COMBAT ---
do
    local CombatTab = MainSection:Tab({
        Title = "Combat",
        Icon = "solar:shield-warning-bold",
        Border = true,
    })

    CombatTab:Toggle({
        Title = "Silent Aim",
        Desc = "Automatically target players",
        Callback = function(v) _G.SilentAim = v end,
    })

    CombatTab:Slider({
        Title = "Aimbot FOV",
        Step = 1,
        Value = { Min = 0, Max = 800, Default = 100 },
        Callback = function(v) _G.FOV = v end,
    })
end

-- // --- TAB: PLAYER ---
do
    local PlayerTab = PlayerSection:Tab({
        Title = "Player",
        Icon = "solar:user-bold",
        Border = true,
    })

    PlayerTab:Slider({
        Title = "WalkSpeed",
        Step = 1,
        Value = { Min = 16, Max = 500, Default = 16 },
        Callback = function(v) 
            pcall(function() game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v end) 
        end,
    })

    PlayerTab:Toggle({
        Title = "Infinite Jump",
        Callback = function(v) _G.InfJump = v end,
    })
end

-- // --- TAB: SETTINGS & CONFIG ---
do
    local SettingsTab = ConfigSection:Tab({
        Title = "Settings",
        Icon = "solar:settings-bold",
        Border = true,
    })

    SettingsTab:Button({
        Title = "Destroy UI",
        Color = Color3.fromHex("#ff4830"),
        Justify = "Center",
        Callback = function() Window:Destroy() end,
    })
end

-- // --- LOGIC (REPEATING TASKS) ---
game:GetService("UserInputService").JumpRequest:Connect(function()
    if _G.InfJump then
        pcall(function()
            game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
        end)
    end
end)

WindUI:Notify({
    Title = "WNDS Hub Loaded",
    Content = "Script is successfully running!",
    Duration = 5
})
