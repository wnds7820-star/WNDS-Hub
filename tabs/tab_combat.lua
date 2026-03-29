local CombatTab = Window:Tab({
    Title = "Combat",
    Icon = "solar:shield-warning-bold",
    Border = true,
})

CombatTab:Toggle({
    Title = "Kill Aura",
    Callback = function(v) _G.KillAura = v end
})

CombatTab:Slider({
    Title = "Range",
    Value = { Min = 0, Max = 50, Default = 15 },
    Callback = function(v) _G.AuraRange = v end
})
