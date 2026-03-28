local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local cloneref = cloneref or clonereference or function(i) return i end

-- =============================================
--          DETEKSI PLATFORM & EXECUTOR
-- =============================================

local IsMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
local IsWeakExecutor = false

-- Cara sederhana mendeteksi executor lemah (Xeno, Solara mobile rendah, dll)
pcall(function()
    if getgenv then
        local test = getgenv()._TEST or {}
        getgenv()._TEST = test
    end
end)

-- Deteksi tambahan untuk executor mobile lemah
if IsMobile then
    local success, _ = pcall(function()
        return game:GetService("CoreGui"):FindFirstChild("RobloxGui") -- beberapa executor mobile punya behavior berbeda
    end)
    if not success then
        IsWeakExecutor = true
    end
end

-- Force weak mode kalau di mobile
if IsMobile then
    IsWeakExecutor = true  -- default anggap mobile = butuh mode ringan
end

print("Platform: " .. (IsMobile and "Mobile" or "PC") .. " | Weak Executor: " .. tostring(IsWeakExecutor))

-- =============================================
--                LOAD WINDUI
-- =============================================

local WindUI

do
    local ok, result = pcall(function()
        return require("./src/Init")
    end)

    if ok then
        WindUI = result
    else
        if RunService:IsStudio() then
            WindUI = require(game.ReplicatedStorage:WaitForChild("WindUI"):WaitForChild("Init"))
        else
            WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
        end
    end
end

-- =============================================
--                CREATE WINDOW
-- =============================================

local Window = WindUI:CreateWindow({
    Title = ".ftgs hub | WindUI",
    Folder = "ftgshub",
    Icon = "solar:folder-2-bold-duotone",
    NewElements = not IsWeakExecutor,   -- matikan NewElements di executor lemah
    HideSearchBar = IsWeakExecutor,     -- sembunyikan search bar di mobile

    OpenButton = {
        Title = IsMobile and "Open Hub" or "Open .ftgs hub",
        CornerRadius = UDim.new(1, 0),
        StrokeThickness = 3,
        Enabled = true,
        Draggable = true,
        Scale = IsMobile and 0.65 or 0.5,   -- lebih besar di HP
        Color = ColorSequence.new(
            Color3.fromHex("#30FF6A"),
            Color3.fromHex("#e7ff2f")
        ),
    },

    Topbar = {
        Height = IsMobile and 50 or 44,
        ButtonsType = "Mac",
    },

    -- Size lebih kecil di mobile
    Size = IsMobile and UDim2.fromOffset(420, 520) or UDim2.fromOffset(680, 620),
})

-- Tag versi
Window:Tag({
    Title = "v" .. WindUI.Version .. (IsMobile and " (Mobile)" or ""),
    Icon = "github",
    Color = Color3.fromHex("#1c1c1c"),
    Border = true,
})

-- Warna
local Green = Color3.fromHex("#10C550")
local Blue  = Color3.fromHex("#257AF7")
local Purple = Color3.fromHex("#7775F2")
local Yellow = Color3.fromHex("#ECA201")

-- =============================================
--                TABS (Disesuaikan)
-- =============================================

local OverviewTab = Window:Tab({
    Title = "Overview",
    Icon = "solar:home-2-bold",
    IconColor = Color3.fromHex("#83889E"),
    Border = true,
})

local Group1 = OverviewTab:Group({})
Group1:Button({
    Title = "Test Button",
    Justify = "Center",
    Callback = function()
        WindUI:Notify({ Title = "Success", Content = "Script berjalan di " .. (IsMobile and "Mobile" or "PC") })
    end,
})

Group1:Space()
Group1:Toggle({
    Title = "Example Toggle",
    Callback = function(v) print("Toggle:", v) end,
})

-- Tab Toggles (ringkas)
local ToggleTab = Window:Tab({
    Title = "Toggles",
    Icon = "solar:check-square-bold",
    IconColor = Green,
    Border = true,
})

ToggleTab:Toggle({ Title = "Normal Toggle" })
ToggleTab:Space()
ToggleTab:Toggle({ Title = "With Description", Desc = "Contoh toggle dengan desc" })

-- Tab Buttons
local ButtonTab = Window:Tab({
    Title = "Buttons",
    Icon = "solar:cursor-square-bold",
    IconColor = Blue,
    Border = true,
})

ButtonTab:Button({
    Title = "Notify Test",
    Callback = function()
        WindUI:Notify({ Title = "Hello!", Content = "WindUI berhasil dijalankan" })
    end,
})

-- Tab Input + Slider + Dropdown (tetap ada, tapi lebih ringkas di mobile)
local InputTab = Window:Tab({ Title = "Input", Icon = "solar:password-minimalistic-input-bold", IconColor = Purple, Border = true })
InputTab:Input({ Title = "Normal Input" })

local SliderTab = Window:Tab({ Title = "Slider", Icon = "solar:square-transfer-horizontal-bold", IconColor = Green, Border = true })
SliderTab:Slider({
    Title = "Example Slider",
    Value = { Min = 0, Max = 200, Default = 100 },
    Step = 1,
    IsTooltip = not IsWeakExecutor,   -- tooltip mati di executor lemah
    Callback = function(v) print("Slider:", v) end,
})

local DropdownTab = Window:Tab({ Title = "Dropdown", Icon = "solar:hamburger-menu-bold", IconColor = Yellow, Border = true })
DropdownTab:Dropdown({
    Title = "Simple Dropdown",
    Values = { "Option 1", "Option 2", "Option 3", "Option 4" },
    Callback = function(val) print("Selected:", val) end,
})

print("✅ Script WindUI Adaptive siap! (Mobile/PC + Weak Executor Detection)")
