local Window = _G.Window
local Fluent = _G.Fluent

if not Window then return end

local CombatTab = Window:AddTab({ Title = "Combat", Icon = "target" })

CombatTab:AddParagraph({
    Title = "Combat Features",
    Content = "Coming soon for more updates."
})

CombatTab:AddToggle("AimToggle", {Title = "Enable Aimbot (Demo)", Default = false})
