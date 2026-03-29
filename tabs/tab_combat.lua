local CombatTab = Window:Tab({ Title = "Combat", Icon = "solar:sword-bold", Border = true })
local Section = CombatTab:Section({ Title = "Main Combat" })

Section:Toggle({
    Title = "Aimbot",
    Desc = "Otomatis mengunci target ke kepala musuh",
    Callback = function(v) _G.Aimbot = v end
})

Section:Toggle({
    Title = "Kill Aura",
    Desc = "Otomatis memukul musuh di sekitar",
    Callback = function(v) _G.KillAura = v end
})

Section:Slider({
    Title = "Aura Range",
    Value = { Min = 5, Max = 50, Default = 15 },
    Callback = function(v) _G.AuraRange = v end
})
