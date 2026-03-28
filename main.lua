-- // WNDS HUB v5.4 - WIND UI STABLE
-- // Developer: Raize (WNDS)

-- Link Alternatif WindUI yang lebih stabil
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/refs/heads/main/Source.lua"))()

local Window = WindUI:CreateWindow({
    Title = "WNDS Hub v5.4",
    Icon = "rbxassetid://10723343321",
    Author = "by Raize",
    Folder = "WNDS_Configs"
})

-- // NOTIFIKASI STARTUP
WindUI:Notify({
    Title = "WNDS Hub",
    Content = "Successfully Loaded! Hello, " .. game.Players.LocalPlayer.DisplayName,
    Duration = 5
})

-- // --- TAB: INFO ---
local TabInfo = Window:AddTab({ Title = "Info", Icon = "info" })
TabInfo:AddParagraph({
    Title = "User Profile",
    Desc = "Name: " .. game.Players.LocalPlayer.Name .. "\nID: " .. game.Players.LocalPlayer.UserId
})

-- // --- TAB: COMBAT ---
local TabCombat = Window:AddTab({ Title = "Combat", Icon = "sword" })
TabCombat:AddToggle({
    Title = "Aimbot",
    Default = false,
    Callback = function(v) _G.Aimbot = v end
})
TabCombat:AddSlider({
    Title = "FOV Radius",
    Min = 10, Max = 500, Default = 100,
    Callback = function(v) _G.FOV = v end
})

-- // --- TAB: PLAYER ---
local TabPlayer = Window:AddTab({ Title = "Player", Icon = "user" })
TabPlayer:AddSlider({
    Title = "WalkSpeed",
    Min = 16, Max = 300, Default = 16,
    Callback = function(v) 
        pcall(function() game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v end) 
    end
})
TabPlayer:AddToggle({
    Title = "Infinite Jump",
    Default = false,
    Callback = function(v) _G.InfJump = v end
})

-- // --- TAB: VISUALS ---
local TabVisual = Window:AddTab({ Title = "Visuals", Icon = "eye" })
TabVisual:AddToggle({
    Title = "ESP Player",
    Default = false,
    Callback = function(v) _G.ESP = v end
})

-- // --- TAB: SETTINGS ---
local TabSettings = Window:AddTab({ Title = "Settings", Icon = "settings" })
TabSettings:AddButton({
    Title = "Rejoin Server",
    Callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
    end
})

-- // LOGIKA INFINITE JUMP
game:GetService("UserInputService").JumpRequest:Connect(function()
    if _G.InfJump then
        game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end)

-- // SETTING KEYBIND (PC)
Window:SetKeybind(Enum.KeyCode.RightControl)

print("✅ [WNDS]: Script Fully Loaded!")
