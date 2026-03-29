local Window = _G.Window
local Fluent = _G.Fluent

local PlayerTab = Window:AddTab({ Title = "Player", Icon = "user" })

PlayerTab:AddParagraph({
    Title = "Movement Settings",
    Content = "Adjust your speed and jump here."
})

-- Fitur kamu di sini...
PlayerTab:AddSlider("WS", {
    Title = "WalkSpeed",
    Default = 16, Min = 16, Max = 500, Rounding = 1,
    Callback = function(v) 
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v 
    end
})
