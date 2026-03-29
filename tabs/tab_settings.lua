local SettingsTab = Window:Tab({
    Title = "Settings",
    Icon = "solar:settings-bold",
    Border = true,
})

-- FITUR RELOAD & TESTER
local ManageSection = SettingsTab:Section({ Title = "Script Management" })

ManageSection:Button({
    Title = "Reload WNDS Hub",
    Color = Color3.fromHex("#30ff6a"),
    Callback = function()
        Window:Destroy()
        task.wait(0.5)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/main.lua"))()
    end
})

ManageSection:Button({
    Title = "Run Executor Tester",
    Desc = "Cek kekuatan executor kamu",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/GmilerlolYT/ExecutorTester/refs/heads/main/Hi"))()
    end
})

local UiConfig = SettingsTab:Section({ Title = "UI Configuration" })
UiConfig:Keybind({
    Title = "Hide/Show Menu",
    Value = "RightControl",
    Callback = function(key) Window:SetToggleKey(Enum.KeyCode[key]) end,
})
