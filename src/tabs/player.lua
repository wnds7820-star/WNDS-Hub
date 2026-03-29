-- src/tabs/player.lua
local Init = loadstring(game:HttpGet("https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/src/init.lua"))()
local Window = Init.Window

local Tab = Window:Tab({
    Title = "Player",
    Icon = "solar:user-bold",
    IconColor = Color3.fromHex("#10C550"),
    Border = true,
})

Tab:Section({ Title = "Local Player" })

Tab:Slider({
    Title = "WalkSpeed",
    Value = { Min = 16, Max = 300, Default = 16 },
    Step = 1,
    Callback = function(v)
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = v
        end
    end,
})

Tab:Slider({
    Title = "JumpPower",
    Value = { Min = 50, Max = 300, Default = 50 },
    Step = 1,
    Callback = function(v)
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.JumpPower = v
        end
    end,
})

Tab:Toggle({
    Title = "Infinite Jump",
    Callback = function(v)
        print("Infinite Jump:", v)
        -- Kamu bisa tambah kode infinite jump di sini nanti
    end,
})
