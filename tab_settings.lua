local Tabs = _G.WNDS_UI.Tabs
Tabs.Settings:Section({ Title = "System Configuration" })

-- 1. FITUR UTAMA: RELOAD SCRIPT
Tabs.Settings:Button({
    Title = "Reload WNDS Hub",
    Desc = "Memuat ulang seluruh script dari GitHub (Tanpa keluar game)",
    Callback = function()
        Window:Destroy() -- Menghapus UI yang lama
        task.wait(0.5)
        -- Memanggil ulang Master Loader (main.lua)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/main.lua"))()
    end
})

Tabs.Settings:Section({ Title = "Optimization & Tools" })

-- 2. Toggle Anti-AFK (Agar tidak kena kick Error 260)
Tabs.Settings:Toggle({
    Title = "Anti-AFK System",
    Default = false,
    Callback = function(Value)
        _G.AntiAFK = Value
        while _G.AntiAFK do
            local VirtualUser = game:GetService("VirtualUser")
            game.Players.LocalPlayer.Idled:Connect(function()
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())
            end)
            task.wait(30)
        end
    end
})

-- 3. Rejoin Server
Tabs.Settings:Button({
    Title = "Rejoin Server",
    Callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
    end
})

-- 4. Server Hop (Pindah Server)
Tabs.Settings:Button({
    Title = "Server Hop",
    Callback = function()
        local Http = game:GetService("HttpService")
        local TPS = game:GetService("TeleportService")
        local Api = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Desc&limit=100"
        local _Servers = Http:JSONDecode(game:HttpGet(Api))
        for i,v in pairs(_Servers.data) do
            if v.playing < v.maxPlayers then
                TPS:TeleportToPlaceInstance(game.PlaceId, v.id)
                break
            end
        end
    end
})

-- 5. Copy Discord Link
Tabs.Settings:Button({
    Title = "Copy Discord Link",
    Callback = function()
        setclipboard("https://discord.gg/wndshub") -- Ganti dengan link kamu
        Fluent:Notify({ Title = "Success", Content = "Link copied to clipboard!" })
    end
})

-- 6. Low Graphics (Boost FPS)
Tabs.Settings:Toggle({
    Title = "Low Graphics Mode",
    Default = false,
    Callback = function(Value)
        if Value then
            for i,v in pairs(game:GetDescendants()) do
                if v:IsA("Part") or v:IsA("UnionOperation") then
                    v.Material = Enum.Material.SmoothPlastic
                end
            end
        end
    end
})

-- 7. Hide/Show UI Keybind Info
Tabs.Settings:Section({ Title = "Interface Settings" })
Tabs.Settings:Keybind({
    Title = "Minimize Key",
    Default = "RightControl",
    ChangedCallback = function(New)
        Window.MinimizeKey = New
    end
})

-- 8. Reset Config
Tabs.Settings:Button({ Title = "Reset All Settings", Callback = function() print("Settings Reset") end })
-- 9. Auto Load Config
Tabs.Settings:Toggle({ Title = "Auto Load Config", Default = true, Callback = function(v) end })
-- 10. Destroy UI
Tabs.Settings:Button({ Title = "Unload Script", Callback = function() Window:Destroy() end })
