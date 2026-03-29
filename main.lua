-- // WNDS MODULE: PLAYER TAB
local Window = _G.Window
local Fluent = _G.Fluent

if not Window then return end

local PlayerTab = Window:AddTab({ Title = "Player", Icon = "user" })

PlayerTab:AddParagraph({
    Title = "Movement Control",
    Content = "User: " .. game.Players.LocalPlayer.Name
})

_G.WS = 16
PlayerTab:AddSlider("WS_Slider", {
    Title = "WalkSpeed",
    Default = 16, Min = 16, Max = 500, Rounding = 1,
    Callback = function(v) _G.WS = v end
})

-- Loop agar WalkSpeed tidak reset
game:GetService("RunService").RenderStepped:Connect(function()
    pcall(function()
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = _G.WS
    end)
end)

print("[WNDS] Player Tab Loaded Successfully!")
