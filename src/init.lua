local UserInputService = game:GetService("UserInputService")

local IsMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
local IsWeakExecutor = IsMobile

local Window = WindUI:CreateWindow({
    Title = ".ftgs hub",
    Folder = "ftgshub",
    Icon = "solar:folder-2-bold-duotone",
    NewElements = not IsWeakExecutor,
    HideSearchBar = IsWeakExecutor,

    OpenButton = {
        Title = IsMobile and "Open Hub" or "Open .ftgs hub",
        CornerRadius = UDim.new(1, 0),
        StrokeThickness = 3,
        Enabled = true,
        Draggable = true,
        Scale = IsMobile and 0.65 or 0.5,
        Color = ColorSequence.new(Color3.fromHex("#30FF6A"), Color3.fromHex("#e7ff2f")),
    },

    Topbar = {
        Height = IsMobile and 50 or 44,
        ButtonsType = "Mac",
    },

    Size = IsMobile and UDim2.fromOffset(420, 520) or UDim2.fromOffset(680, 620),
})

Window:Tag({
    Title = "v1.0" .. (IsMobile and " (Mobile)" or ""),
    Icon = "github",
    Color = Color3.fromHex("#1c1c1c"),
    Border = true,
})

return {
    Window = Window,
    IsMobile = IsMobile,
    IsWeakExecutor = IsWeakExecutor
}
