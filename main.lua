-- // WNDS HUB v5.4 - MODULAR LOADER
-- // Creator: Raize (WNDS)

local base_url = "https://raw.githubusercontent.com/UsernameKamu/RepoKamu/main/"

-- 1. Jalankan Loading Screen (Internal)
loadstring(game:HttpGet(base_url .. "loader_intro.lua"))() 
task.wait(4.5)

-- 2. Load Data Detection (Info Akun/Server)
_G.WNDS_Data = loadstring(game:HttpGet(base_url .. "info_data.lua"))()

-- 3. Load UI & Tabs
_G.WNDS_UI = loadstring(game:HttpGet(base_url .. "ui_config.lua"))()

-- 4. Load Core Functions (Combat, Visual, dll)
loadstring(game:HttpGet(base_url .. "functions.lua"))()

print("WNDS Hub: All Modules Loaded Successfully!")
