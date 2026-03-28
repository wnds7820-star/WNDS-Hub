local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local LoaderGui = Instance.new("ScreenGui", CoreGui)
LoaderGui.Name = "WNDS_Intro"

local Main = Instance.new("Frame", LoaderGui)
Main.Size = UDim2.fromScale(1, 1)
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 10)

local Logo = Instance.new("TextLabel", Main)
Logo.Text = "WNDS HUB"
Logo.Size = UDim2.fromOffset(400, 100)
Logo.Position = UDim2.fromScale(0.5, 0.45)
Logo.AnchorPoint = Vector2.new(0.5, 0.5)
Logo.TextColor3 = Color3.fromHex("#7775F2")
Logo.Font = Enum.Font.GothamBold
Logo.TextSize = 60

local Status = Instance.new("TextLabel", Main)
Status.Text = "Loading WNDS Hub v5.4..."
Status.Position = UDim2.fromScale(0.5, 0.55)
Status.TextColor3 = Color3.fromRGB(200, 200, 200)
Status.AnchorPoint = Vector2.new(0.5, 0.5)
Status.BackgroundTransparency = 1

task.wait(3.5)
TweenService:Create(Main, TweenInfo.new(1), {BackgroundTransparency = 1}):Play()
TweenService:Create(Logo, TweenInfo.new(1), {TextTransparency = 1}):Play()
TweenService:Create(Status, TweenInfo.new(1), {TextTransparency = 1}):Play()
task.wait(1)
LoaderGui:Destroy()
