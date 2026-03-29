local HomeTab = Window:Tab({
    Title = "Home",
    Icon = "solar:home-2-bold",
    Border = true,
})

HomeTab:Section({ Title = "User Dashboard" })
HomeTab:Paragraph({
    Title = "Welcome, " .. game.Players.LocalPlayer.DisplayName,
    Desc = "Status: Premium\nGame ID: " .. game.PlaceId
})
