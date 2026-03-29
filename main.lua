-- // WNDS HUB v6.0 - FLUENT EDITION
-- // Developer: Raize
-- // Standard: Ultra Modern Glassmorphism

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

-- // --- SAFE IDENTITY CHECK ---
local function GetExecutor()
    local s, r = pcall(function() return identifyexecutor() end)
    return s and r or "Mobile/Unknown"
end

local Window = Fluent:CreateWindow({
    Title = "WNDS HUB v6.0",
    SubTitle = "by Raize",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true, 
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- // --- VARIABLES ---
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
_G.WalkSpeed = 16
_G.JumpPower = 50
_G.FlyEnabled = false
_G.FlySpeed = 50
_G.EspEnabled = false

-- // --- TABS ---
local Tabs = {
    Main = Window:AddTab({ Title = "Player", Icon = "user" }),
    Combat = Window:AddTab({ Title = "Combat", Icon = "target" }),
    Visual = Window:AddTab({ Title = "Visuals", Icon = "eye" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

-- // --- NOTIFICATION ---
Fluent:Notify({
    Title = "WNDS Hub",
    Content = "Welcome, " .. LocalPlayer.DisplayName .. "! Exec: " .. GetExecutor(),
    Duration = 5
})

-- // --- PLAYER TAB ---
Tabs.Main:AddParagraph({
    Title = "Movement Modification",
    Content = "Adjust your character physics here."
})

local ToggleWS = Tabs.Main:AddToggle("WS_Toggle", {Title = "Enable Speed/Jump", Default = false})
ToggleWS:OnChanged(function()
    _G.MovementEnabled = ToggleWS.Value
end)

Tabs.Main:AddSlider("WS_Slider", {
    Title = "WalkSpeed",
    Description = "Adjust your speed",
    Default = 16, Min = 16, Max = 500, Rounding = 1,
    Callback = function(Value) _G.WalkSpeed = Value end
})

Tabs.Main:AddSlider("JP_Slider", {
    Title = "JumpPower",
    Description = "Adjust your jump",
    Default = 50, Min = 50, Max = 1000, Rounding = 1,
    Callback = function(Value) _G.JumpPower = Value end
})

local ToggleFly = Tabs.Main:AddToggle("Fly_Toggle", {Title = "Static Flight (WASD + QE)", Default = false})
ToggleFly:OnChanged(function()
    _G.FlyEnabled = ToggleFly.Value
    if _G.FlyEnabled then
        local Root = LocalPlayer.Character.HumanoidRootPart
        local BV = Instance.new("BodyVelocity", Root)
        BV.Name = "WNDS_FlyForce"
        BV.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        
        task.spawn(function()
            while _G.FlyEnabled do
                local dir = Vector3.new(0,0,0)
                local cam = workspace.CurrentCamera.CFrame
                local UIS = game:GetService("UserInputService")
                if UIS:IsKeyDown("W") then dir += cam.LookVector end
                if UIS:IsKeyDown("S") then dir -= cam.LookVector end
                if UIS:IsKeyDown("A") then dir -= cam.RightVector end
                if UIS:IsKeyDown("D") then dir += cam.RightVector end
                if UIS:IsKeyDown("E") then dir += Vector3.new(0,1,0) end
                if UIS:IsKeyDown("Q") then dir -= Vector3.new(0,1,0) end
                BV.Velocity = (dir.Magnitude > 0) and (dir.Unit * _G.FlySpeed) or Vector3.new(0,0,0)
                task.wait()
            end
            BV:Destroy()
        end)
    end
end)

-- // --- COMBAT TAB ---
local ToggleAim = Tabs.Combat:AddToggle("Aim_Toggle", {Title = "Enable Aimbot", Default = false})
-- (Logic Aimbot ditaruh di RenderStepped bawah)

-- // --- VISUAL TAB ---
local ToggleEsp = Tabs.Visual:AddToggle("Esp_Toggle", {Title = "Player ESP", Default = false})
ToggleEsp:OnChanged(function() _G.EspEnabled = ToggleEsp.Value end)

-- // --- CORE LOOP (60FPS+) ---
game:GetService("RunService").RenderStepped:Connect(function()
    local Char = LocalPlayer.Character
    local Hum = Char and Char:FindFirstChildOfClass("Humanoid")
    if Hum and _G.MovementEnabled then
        Hum.WalkSpeed = _G.WalkSpeed
        if Hum.UseJumpPower then Hum.JumpPower = _G.JumpPower else Hum.JumpHeight = _G.JumpPower/7.2 end
    end
end)

-- // --- FINISH ---
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
InterfaceManager:SetFolder("WNDSHub")
SaveManager:SetFolder("WNDSHub/configs")

Window:SelectTab(1)
Fluent:Notify({
    Title = "WNDS Hub",
    Content = "Script fully loaded with Fluent UI!",
    Duration = 5
})
