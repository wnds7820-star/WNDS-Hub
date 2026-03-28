local RunService = game:GetService("RunService")
local cloneref = cloneref or clonereference or function(i) return i end

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
--                  WINDOW
-- =============================================
local Window = WindUI:CreateWindow({
	Title = ".ftgs hub | WindUI",
	Folder = "ftgshub",
	Icon = "solar:folder-2-bold-duotone",
	NewElements = true,
	HideSearchBar = false,

	OpenButton = {
		Title = "Open .ftgs hub",
		CornerRadius = UDim.new(1, 0),
		StrokeThickness = 3,
		Enabled = true,
		Draggable = true,
		Scale = 0.5,
		Color = ColorSequence.new(
			Color3.fromHex("#30FF6A"),
			Color3.fromHex("#e7ff2f")
		),
	},

	Topbar = {
		Height = 44,
		ButtonsType = "Mac",
	},
})

-- Tag versi
Window:Tag({
	Title = "v" .. WindUI.Version,
	Icon = "github",
	Color = Color3.fromHex("#1c1c1c"),
	Border = true,
})

-- Warna dasar
local Green = Color3.fromHex("#10C550")
local Blue  = Color3.fromHex("#257AF7")
local Purple = Color3.fromHex("#7775F2")
local Yellow = Color3.fromHex("#ECA201")

-- =============================================
--                  TABS
-- =============================================

-- Tab Overview (contoh layout)
local OverviewTab = Window:Tab({
	Title = "Overview",
	Icon = "solar:home-2-bold",
	IconColor = Color3.fromHex("#83889E"),
	IconShape = "Square",
	Border = true,
})

local Group1 = OverviewTab:Group({})
Group1:Button({
	Title = "Test Button 1",
	Justify = "Center",
	Callback = function()
		print("Button 1 clicked")
		WindUI:Notify({ Title = "Clicked", Content = "Button 1" })
	end,
})

Group1:Space()

Group1:Toggle({
	Title = "Example Toggle",
	Callback = function(v)
		print("Toggle:", v)
	end,
})

-- Tab Toggles
local ToggleTab = Window:Tab({
	Title = "Toggles",
	Icon = "solar:check-square-bold",
	IconColor = Green,
	IconShape = "Square",
	Border = true,
})

ToggleTab:Toggle({ Title = "Normal Toggle" })
ToggleTab:Space()
ToggleTab:Toggle({ Title = "Toggle with Desc", Desc = "Ini contoh dengan deskripsi" })
ToggleTab:Space()
ToggleTab:Toggle({ Title = "Checkbox Style", Type = "Checkbox" })

-- Tab Buttons
local ButtonTab = Window:Tab({
	Title = "Buttons",
	Icon = "solar:cursor-square-bold",
	IconColor = Blue,
	IconShape = "Square",
	Border = true,
})

ButtonTab:Button({
	Title = "Primary Button",
	Callback = function()
		WindUI:Notify({ Title = "Hello", Content = "Ini notifikasi dari button!" })
	end,
})

ButtonTab:Space()

ButtonTab:Button({
	Title = "Colored Button",
	Color = Color3.fromHex("#305dff"),
	Callback = function() end,
})

-- Tab Input
local InputTab = Window:Tab({
	Title = "Input",
	Icon = "solar:password-minimalistic-input-bold",
	IconColor = Purple,
	IconShape = "Square",
	Border = true,
})

InputTab:Input({ Title = "Normal Input", Icon = "mouse" })
InputTab:Space()
InputTab:Input({ Title = "Textarea", Type = "Textarea" })

-- Tab Slider
local SliderTab = Window:Tab({
	Title = "Slider",
	Icon = "solar:square-transfer-horizontal-bold",
	IconColor = Green,
	IconShape = "Square",
	Border = true,
})

SliderTab:Slider({
	Title = "Example Slider",
	Desc = "Slider dengan tooltip",
	IsTooltip = true,
	Value = { Min = 0, Max = 200, Default = 100 },
	Step = 1,
	Callback = function(v) print("Slider value:", v) end,
})

-- Tab Dropdown
local DropdownTab = Window:Tab({
	Title = "Dropdown",
	Icon = "solar:hamburger-menu-bold",
	IconColor = Yellow,
	IconShape = "Square",
	Border = true,
})

DropdownTab:Dropdown({
	Title = "Simple Dropdown",
	Values = { "Option 1", "Option 2", "Option 3", "Option 4" },
	Value = 1,
	Callback = function(val)
		print("Dipilih:", val)
	end,
})

DropdownTab:Space()

DropdownTab:Dropdown({
	Title = "Multi Select",
	Values = { "A", "B", "C", "D", "E" },
	Multi = true,
	AllowNone = true,
	Callback = function(selected)
		print("Multi selected:", selected)
	end,
})

-- =============================================
--                  CONTOH TAMBAHAN
-- =============================================

-- Contoh large dropdown (bisa kamu pakai untuk list player dll)
local ExampleTab = Window:Tab({
	Title = "Example Tab",
	Icon = "bird",
})

local mainCategory = ExampleTab:Dropdown({
	Title = "Main Category",
	Values = { "All", "Weapons", "Scripts", "Others" },
	Value = "All",
})

local targetDropdown = ExampleTab:Dropdown({
	Title = "Target / Item",
	Values = {}, -- akan di-refresh lewat callback
	Multi = true,
})

mainCategory:OnChanged(function(option)
	if option == "All" then
		targetDropdown:Refresh({"Item 1", "Item 2", "Item 3", ...}) -- ganti dengan list kamu
	else
		targetDropdown:Refresh({"Specific 1", "Specific 2"})
	end
end)

print("WindUI Example Script siap! ✅")
