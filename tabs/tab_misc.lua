-- // WNDS HUB v6.5 - MISCELLANEOUS TOOLS
-- // Developer: Raize

local Window = _G.WNDS_Window
local Fluent = _G.WNDS_Fluent
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local MiscTab = Window:AddTab({ Title = "Misc", Icon = "box" })

-- // SECTION: SCRIPT UTILITY
local ScriptSec = MiscTab:AddSection("Script Utility")

ScriptSec:AddButton({
    Title = "Reload WNDS Hub",
    Description = "Muat ulang script dari GitHub",
    Callback = function()
        Window:Destroy()
        task.wait(0.5)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/main.lua"))()
    end
})

-- // SECTION: PLAYER AUTOMATION
local AutoSec = MiscTab:AddSection("Automation")

-- Fitur Anti-AFK (Sangat penting buat grinding)
AutoSec:AddButton({
    Title = "Enable Anti-AFK",
    Description = "Mencegah idle kick (20 menit)",
    Callback = function()
        local VirtualUser = game:GetService("VirtualUser")
        LocalPlayer.Idled:Connect(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
            Fluent:Notify({Title = "Anti-AFK", Content = "Mencegah idle kick aktif!"})
        end)
    end
})

-- // SECTION: SERVER MANAGEMENT
local ServerSec = MiscTab:AddSection("Server Management")

ServerSec:AddButton({
    Title = "Rejoin Server",
    Description = "Masuk kembali ke server yang sama",
    Callback = function()
        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
    end
})

ServerSec:AddButton({
    Title = "Server Hop",
    Description = "Pindah ke server lain yang random",
    Callback = function()
        local Http = game:GetService("HttpService")
        local Api = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
        local function GetServer()
            local Raw = game:HttpGet(Api)
            local Decode = Http:JSONDecode(Raw)
            for _, v in pairs(Decode.data) do
                if v.playing < v.maxPlayers and v.id ~= game.JobId then
                    return v.id
                end
            end
        end
        local ServerId = GetServer()
        if ServerId then
            TeleportService:TeleportToPlaceInstance(game.PlaceId, ServerId, LocalPlayer)
        else
            Fluent:Notify({Title = "Error", Content = "Tidak menemukan server lain."})
        end
    end
})

-- // SECTION: TOOLS
local ToolSec = MiscTab:AddSection("Developer Tools")

ToolSec:AddButton({
    Title = "Copy Job ID",
    Description = "Salin ID server ke clipboard",
    Callback = function()
        setclipboard(game.JobId)
        Fluent:Notify({Title = "Copied", Content = "Job ID berhasil disalin!"})
    end
})

print("[WNDS HUB] Misc tab successfully loaded.")
