-- // WNDS HUB - SETTINGS MODULE (FIXED)
local Tabs = _G.WNDS_UI.Tabs
local Window = _G.WNDS_UI.Window

Tabs.Settings:Section({ Title = "Hub Management" })

Tabs.Settings:Button({
    Title = "Rejoin Server",
    Callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
    end,
})

Tabs.Settings:Button({
    Title = "Copy Discord Link",
    Callback = function()
        setclipboard("https://discord.gg/wnds")
        Window:Notify({ Title = "Success", Desc = "Link Copied to Clipboard!" })
    end,
})

Tabs.Settings:Button({
    Title = "Destroy UI",
    Callback = function() Window:Destroy() end,
})
