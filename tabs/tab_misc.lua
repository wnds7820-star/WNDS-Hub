local MiscTab = _G.WNDS_Window:AddTab({ Title = "Misc", Icon = "box" })
MiscTab:AddButton({
    Title = "Reload WNDS Hub",
    Callback = function()
        _G.WNDS_Window:Destroy()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/main/main.lua"))()
    end
})
