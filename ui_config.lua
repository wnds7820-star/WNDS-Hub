-- // WNDS HUB - MOBILE FLOATING BUTTON
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

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
    Button.Position = UDim2.new(0.1, 0, 0.15, 0) -- Posisi awal
    Button.Size = UDim2.new(0, 50, 0, 50) -- Ukuran tombol
    Button.Font = Enum.Font.GothamBold
    Button.Text = "W" -- Inisial WNDS
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 24
    Button.Active = true
    Button.Draggable = true -- Biar bisa digeser-geser di HP

    UICorner.CornerRadius = UDim.new(0, 12) -- Bentuk agak kotak membulat (Modern)
    UICorner.Parent = Button

    UIGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(120, 117, 242)), -- Warna khas WNDS
        ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 58, 121))
    }
    UIGradient.Parent = Button

    -- Fungsi Klik untuk Buka/Tutup Menu
    Button.MouseButton1Click:Connect(function()
        -- Simulasi menekan tombol RightControl untuk memicu Library Fluent
        game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.RightControl, false, game)
        
        -- Efek klik (animasi kecil)
        Button:TweenSize(UDim2.new(0, 45, 0, 45), "Out", "Quad", 0.1, true)
        task.wait(0.1)
        Button:TweenSize(UDim2.new(0, 50, 0, 50), "Out", "Quad", 0.1, true)
    end)
end

-- Hanya munculkan tombol jika user pakai HP
if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled then
    CreateFloatingButton()
end
