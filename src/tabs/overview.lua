-- src/tabs/overview.lua
local Init = loadstring(game:HttpGet("https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/src/init.lua"))()
local Window = Init.Window

local Tab = Window:Tab({
    Title = "Overview",
    Icon = "solar:home-2-bold",
    IconColor = Color3.fromHex("#83889E"),
    Border = true,
})

Tab:Section({ Title = "Welcome to WNDS-Hub" })

Tab:Button({
    Title = "Test Notification",
    Callback = function()
        WindUI:Notify({
            Title = "Success",
            Content = "WNDS-Hub is working perfectly!",
            Duration = 5
        })
    end,
})
