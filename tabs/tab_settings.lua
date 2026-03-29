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

local ManagementSection = SettingsTab:Section({ Title = "Script Management" })

ManagementSection:Button({
    Title = "Reload WNDS Hub",
    Desc = "Memuat ulang seluruh script dari GitHub",
    Color = Color3.fromHex("#30ff6a"),
    Callback = function()
        -- Menghapus UI lama agar tidak tumpang tindih
        Window:Destroy()
        
        -- Menjalankan ulang loader utama
        task.wait(0.5)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/main.lua"))()
        
        WindUI:Notify({
            Title = "Reloaded!",
            Content = "Script berhasil diperbarui dari GitHub.",
            Duration = 3
        })
    end
})
