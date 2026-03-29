local Window = _G.Window
local Fluent = _G.Fluent

-- JANGAN PAKAI Window:Tab! Pakai AddTab:
local VisualTab = Window:AddTab({ Title = "Visuals", Icon = "eye" })

VisualTab:AddToggle("EspToggle", {Title = "Enable ESP", Default = false})
-- Tambahin fitur lainnya di sini...
