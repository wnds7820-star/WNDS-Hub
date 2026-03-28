-- // WNDS HUB v5.4 - OFFICIAL MASTER LOADER
_G.Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local function SafeLoad(fileName)
    local url = "https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/refs/heads/main/main.lua" .. fileName .. "?t=" .. tostring(math.random(1, 10000))
    local s, content = pcall(function() return game:HttpGet(url) end)
    if s and content and not content:find("404") then
        local func = loadstring(content)
        if func then return func() end
    end
    warn("WNDS Gagal Load: " .. fileName)
end

-- Ambil Data Intro & Jalankan UI
task.spawn(function() SafeLoad("loader_intro.lua") end)
task.wait(4.5)
SafeLoad("ui_config.lua")
