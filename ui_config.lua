-- // WNDS HUB - MOBILE FLOATING BUTTON (SMOOTH DRAG)
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")

local function CreateFloatingButton()
    local ScreenGui = Instance.new("ScreenGui")
    local Button = Instance.new("TextButton")
    local UICorner = Instance.new("UICorner")
    local UIGradient = Instance.new("UIGradient")

    ScreenGui.Name = "WNDS_MobileToggle"
    ScreenGui.Parent = game:GetService("CoreGui")
    ScreenGui.ResetOnSpawn = false

    Button.Name = "ToggleButton"
    Button.Parent = ScreenGui
    Button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Button.BorderSizePixel = 0
    Button.Position = UDim2.new(0.1, 0, 0.15, 0)
    Button.Size = UDim2.new(0, 50, 0, 50)
    Button.Font = Enum.Font.GothamBold
    Button.Text = "W"
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 24
    Button.Active = true
    Button.Draggable = true -- Aktifkan fitur seret

    UICorner.CornerRadius = UDim.new(0, 15) -- Lebih bulat biar estetik
    UICorner.Parent = Button

    UIGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(120, 117, 242)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 58, 121))
    }
    UIGradient.Parent = Button

    -- Logika Klik (Buka/Tutup Menu)
    Button.MouseButton1Click:Connect(function()
        -- Simulasi tekan RightControl
        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.RightControl, false, game)
        
        -- Animasi klik kecil
        Button:TweenSize(UDim2.new(0, 45, 0, 45), "Out", "Quad", 0.1, true)
        task.wait(0.1)
        Button:TweenSize(UDim2.new(0, 50, 0, 50), "Out", "Quad", 0.1, true)
    end)
end

-- Deteksi HP/Mobile
if UserInputService.TouchEnabled then
    CreateFloatingButton()
end
