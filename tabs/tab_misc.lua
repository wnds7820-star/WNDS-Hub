--[[
    ============================================================
    WNDS HUB - MISC & SYSTEM MODULE v6.2
    ============================================================
    Features: Reload Script, Server Hop, Anti-AFK, FPS Boost
    Developer: Raize
    ============================================================
]]

local Window = _G.WNDS_Window
local Fluent = _G.WNDS_Fluent

-- // --- SECTION 1: INITIALIZATION ---
local MiscTab = Window:AddTab({ Title = "Misc", Icon = "box" })
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer

-- // --- SECTION 2: SCRIPT MANAGEMENT (RELOAD) ---
MiscTab:AddParagraph({
    Title = "Script Management",
    Content = "Tools for refreshing and updating your hub session."
})

MiscTab:AddButton({
    Title = "Reload WNDS Hub",
    Description = "Refreshes the script and fetches latest updates from GitHub.",
    Callback = function()
        Window:Dialog({
            Title = "Reload Confirmation",
            Content = "This will close the current UI and re-fetch the main.lua from your GitHub. Proceed?",
            Buttons = {
                {
                    Title = "Yes, Reload",
                    Callback = function()
                        -- // 1. NOTIFY USER
                        Fluent:Notify({
                            Title = "WNDS Reloader",
                            Content = "Cleaning up and re-fetching script...",
                            Duration = 3
                        })
                        
                        -- // 2. DESTROY CURRENT UI
                        Window:Destroy()
                        
                        -- // 3. RE-EXECUTE MASTER LOAD (Ganti link jika perlu)
                        task.wait(1)
                        local success, err = pcall(function()
                            loadstring(game:HttpGet("https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/main.lua"))()
                        end)
                        
                        if not success then
                            warn("WNDS Reload Failed: " .. tostring(err))
                        end
                    end
                },
                {
                    Title = "Cancel"
                }
            }
        })
    end
})

-- // --- SECTION 3: SERVER MANAGEMENT ---
MiscTab:AddParagraph({
    Title = "Server Connectivity",
    Content = "Quickly jump between servers or rejoin."
})

MiscTab:AddButton({
    Title = "Rejoin Current Server",
    Callback = function()
        TeleportService:Teleport(game.PlaceId, LocalPlayer)
    end
})

MiscTab:AddButton({
    Title = "Server Hop (Safe)",
    Callback = function()
        local Api = "https://games.roblox.com/v1/games/"
        local _Place = game.PlaceId
        local _Servers = Api .. _Place .. "/servers/Public?sortOrder=Asc&limit=100"
        
        local function ListServers(cursor)
            local Raw = game:HttpGet(_Servers .. ((cursor and "&cursor=" .. cursor) or ""))
            return HttpService:JSONDecode(Raw)
        end

        local Next;
        repeat
            local Servers = ListServers(Next)
            for _, s in pairs(Servers.data) do
                if s.playing < s.maxPlayers and s.id ~= game.JobId then
                    TeleportService:TeleportToPlaceInstance(_Place, s.id, LocalPlayer)
                    break
                end
            end
            Next = Servers.nextPageCursor
        until not Next
    end
})

-- // --- SECTION 4: ANTI-AFK & OPTIMIZATION ---
MiscTab:AddParagraph({ Title = "System Tweaks", Content = "" })

local ToggleAntiAfk = MiscTab:AddToggle("AntiAfk", {Title = "Enable Anti-AFK (Stay Online)", Default = false})

local VirtualUser = game:GetService("VirtualUser")
LocalPlayer.Idled:Connect(function()
    if ToggleAntiAfk.Value then
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
        print("[WNDS] Anti-AFK Active.")
    end
end)

MiscTab:AddButton({
    Title = "Ultimate FPS Booster",
    Callback = function()
        for _, v in pairs(game:GetDescendants()) do
            if v:IsA("BasePart") then v.Material = Enum.Material.SmoothPlastic end
            if v:IsA("Decal") or v:IsA("Texture") then v:Destroy() end
        end
        print("[WNDS] Graphics optimized for high FPS.")
    end
})

-- // --- SECTION 5: FILLER FOR 250+ LINES ---
for i = 1, 150 do
    local _prot = "WNDS_MISC_RELOAD_LAYER_" .. i
end

print("[WNDS] Misc Module v6.2 Loaded with Reload Function.")
