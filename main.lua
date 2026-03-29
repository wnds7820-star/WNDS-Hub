-- [[ WNDS HUB MASTER LOADER - FIXED VERSION ]]
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local Window = Fluent:CreateWindow({
    Title = "WNDS HUB v6.0",
    SubTitle = "Hello " .. game.Players.LocalPlayer.DisplayName,
    TabWidth = 160, Size = UDim2.fromOffset(580, 460),
    Acrylic = true, Theme = "Dark"
})

_G.Window = Window -- Ini kunci biar file tab nggak bingung
_G.Fluent = Fluent

local function SafeLoad(fileName)
    local url = "https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/refs/heads/main/tabs/" .. fileName
    local s, content = pcall(function() return game:HttpGet(url) end)
    if s then
        local func, err = loadstring(content)
        if func then 
            pcall(func) 
        else 
            warn("Syntax Error di " .. fileName .. ": " .. err)
        end
    else
        warn("Gagal download: " .. fileName)
    end
end

-- Panggil semua tab satu-satu
SafeLoad("tab_player.lua")
SafeLoad("tab_combat.lua")
SafeLoad("tab_visual.lua")
SafeLoad("tab_misc.lua")

Window:SelectTab(1)
