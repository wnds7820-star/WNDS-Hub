local Tabs = _G.WNDS_UI.Tabs -- WAJIB ADA DI PALING ATAS

Tabs.Player:Section({ Title = "Movement" })

Tabs.Player:Slider({
    Title = "WalkSpeed",
    Default = 16,
    Min = 16,
    Max = 500,
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end
})

Tabs.Player:Slider({
    Title = "JumpPower",
    Default = 50,
    Min = 50,
    Max = 500,
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
    end
})
