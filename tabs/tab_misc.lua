local MiscTab = Window:Tab({
    Title = "Misc",
    Icon = "solar:widget-bold",
    Border = true,
})

local ServerSection = MiscTab:Section({ Title = "Server Utilities" })
ServerSection:Button({
    Title = "Server Hop",
    Desc = "Cari server lain yang aktif",
    Callback = function()
        -- Logika Server Hop
    end
})

local PlayerSection = MiscTab:Section({ Title = "Character Extras" })
PlayerSection:Toggle({
    Title = "Anti-AFK",
    Callback = function(v)
        _G.AntiAFK = v
        -- Logika Anti-AFK
    end
})
