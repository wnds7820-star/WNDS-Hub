local SettingsTab = Window:Tab({
    Title = "Settings",
    Icon = "solar:settings-bold",
    Border = true,
})

local UiSection = SettingsTab:Section({ Title = "UI Configuration" })

UiSection:Keybind({
    Title = "Hide/Show Menu",
    Value = "RightControl",
    Callback = function(key)
        Window:SetToggleKey(Enum.KeyCode[key])
    end,
})

UiSection:Button({
    Title = "Destroy UI",
    Desc = "Menutup script sepenuhnya",
    Color = Color3.fromHex("#ff4830"),
    Callback = function() Window:Destroy() end,
})

local ConfigSection = SettingsTab:Section({ Title = "Management" })

ConfigSection:Button({
    Title = "Copy JobId",
    Callback = function() setclipboard(game.JobId) end,
})
