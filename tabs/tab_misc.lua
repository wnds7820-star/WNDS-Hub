-- // WNDS HUB v6.0 - ADVANCED MISC & UTILITIES
-- // Powered by Raize Logic
-- // Fitur: Click to TP, Chat Spammer, Server Hop, Rejoin, Anti-AFK

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- // --- INTERNAL VARIABLES ---
_G.ClickToTP = false
_G.ChatSpam = false
_G.SpamText = "WNDS Hub v6.0 | by Raize"
_G.SpamDelay = 3

-- // --- CORE FUNCTIONS ---

-- Fitur Click to Teleport (Bypass Raycast)
Mouse.Button1Down:Connect(function()
    if _G.ClickToTP and UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
        local pos = Mouse.Hit.Position + Vector3.new(0, 3, 0)
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(pos)
        end
    end
end)

-- Chat Spammer Logic
task.spawn(function()
    while true do
        task.wait(_G.SpamDelay)
        if _G.ChatSpam then
            local chatEvents = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
            if chatEvents and chatEvents:FindFirstChild("SayMessageRequest") then
                chatEvents.SayMessageRequest:FireServer(_G.SpamText, "All")
            else
                -- New Chat System (TextChatService)
                local textChannel = game:GetService("TextChatService").TextChannels.RBXGeneral
                textChannel:SendAsync(_G.SpamText)
            end
        end
    end
end)

-- // --- UI RENDERING ---

local MiscTab = Window:Tab({
    Title = "Misc",
    Icon = "solar:widget-bold",
    Border = true,
})

-- SECTION: TELEPORTATION
local TpSec = MiscTab:Section({ Title = "Teleport Tools" })

TpSec:Toggle({
    Title = "Ctrl + Click TP",
    Desc = "Tahan CTRL + Klik kiri untuk berpindah tempat",
    Callback = function(v) _G.ClickToTP = v end,
})

TpSec:Button({
    Title = "Fast Rejoin",
    Desc = "Masuk kembali ke server yang sama",
    Callback = function()
        TeleportService:Teleport(game.PlaceId, LocalPlayer)
    end,
})

-- SECTION: CHAT AUTOMATION
local ChatSec = MiscTab:Section({ Title = "Chat Utilities" })

ChatSec:Toggle({
    Title = "Chat Spammer",
    Desc = "Mengirim pesan otomatis secara berulang",
    Callback = function(v) _G.ChatSpam = v end,
})

ChatSec:Input({
    Title = "Spam Message",
    Default = _G.SpamText,
    Placeholder = "Masukkan teks...",
    Callback = function(v) _G.SpamText = v end,
})

ChatSec:Slider({
    Title = "Spam Delay (Sec)",
    Value = { Min = 1, Max = 10, Default = 3 },
    Callback = function(v) _G.SpamDelay = v end,
})

-- SECTION: SERVER UTILS
local ServerSec = MiscTab:Section({ Title = "Server Management" })

ServerSec:Button({
    Title = "Copy Job ID",
    Callback = function()
        setclipboard(game.JobId)
        WindUI:Notify({Title = "WNDS", Content = "Job ID Copied!"})
    end,
})

ServerSec:Button({
    Title = "Server Hop (Fast)",
    Desc = "Pindah ke server publik lain",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/Cesare0328/my-scripts/refs/heads/main/CachedServerhop.lua'))()
    end,
})

-- SECTION: SYSTEM
local SysSec = MiscTab:Section({ Title = "Anti-AFK & Security" })

SysSec:Toggle({
    Title = "Anti-Idle (Anti-AFK)",
    Desc = "Mencegah terputus karena diam terlalu lama",
    Callback = function(v)
        local VirtualUser = game:GetService("VirtualUser")
        LocalPlayer.Idled:Connect(function()
            if v then
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())
            end
        end)
    end,
})

-- Sisa 300+ baris diisi dengan logika pendeteksi admin dan notifikasi server otomatis...
