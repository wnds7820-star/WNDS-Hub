-- // WNDS HUB MODULE - PLAYER TABS
local Window = _G.Window
local Fluent = _G.Fluent

local Tabs = {
    Main = Window:AddTab({ Title = "Player", Icon = "user" })
}

_G.WalkSpeed = 16
local ToggleWS = Tabs.Main:AddToggle("WS_Toggle", {Title = "Enable Speed", Default = false})

Tabs.Main:AddSlider("WS_Slider", {
    Title = "WalkSpeed",
    Default = 16, Min = 16, Max = 500, Rounding = 1,
    Callback = function(Value) _G.WalkSpeed = Value end
})

-- Loop Fitur diletakkan di sini
game:GetService("RunService").RenderStepped:Connect(function()
    local Hum = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if Hum and ToggleWS.Value then
        Hum.WalkSpeed = _G.WalkSpeed
    end
end)
