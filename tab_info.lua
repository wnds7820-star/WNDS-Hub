local Tabs = _G.WNDS_UI.Tabs
Tabs.Info:Section({ Title = "User Dashboard" })
Tabs.Info:Paragraph({
    Title = "Welcome, " .. game.Players.LocalPlayer.DisplayName,
    Desc = "• Account ID: " .. game.Players.LocalPlayer.UserId .. "\n• Version: 5.4 Premium\n• Status: Active",
    Image = "rbxthumb://type=AvatarHeadShot&id=" .. game.Players.LocalPlayer.UserId .. "&w=150&h=150",
    ImageSize = 64
})
