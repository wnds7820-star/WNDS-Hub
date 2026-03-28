local Fluent = _G.Fluent
local UserInputService = game:GetService("UserInputService")
local isMobile = (UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled)

-- // 1. BUAT WINDOW UTAMA
local Window = Fluent:CreateWindow({
    Title = "WNDS Hub v5.4",
    SubTitle = "by Raize",
    TabWidth = isMobile and 125 or 160,
    Size = isMobile and UDim2.fromOffset(450, 320) or UDim2.fromOffset(580, 460),
    Acrylic = true, 
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.RightControl 
})

local Tabs = {
    Info = Window:AddTab({ Title = "Info", Icon = "info" }),
    Combat = Window:AddTab({ Title = "Combat", Icon = "sword" }),
    Player = Window:AddTab({ Title = "Player", Icon = "user" }),
    Visuals = Window:AddTab({ Title = "Visuals", Icon = "eye" }),
    Teleport = Window:AddTab({ Title = "Teleport", Icon = "map" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

_G.WNDS_UI = { Window = Window, Tabs = Tabs, Fluent = Fluent }

-- // 2. FUNGSI SMART LOAD (Bisa Deteksi Link Lengkap vs Nama File)
local function LoadModule(inputName)
    local finalUrl = ""

    -- Jika input sudah berupa link lengkap (seperti yang kamu minta), gunakan langsung.
    -- Jika cuma nama (contoh: "tab_info.lua"), gabungkan dengan base URL.
    if inputName:find("http") then
        finalUrl = inputName .. "?t=" .. tostring(math.random(1, 1000))
    else
        finalUrl = "https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/refs/heads/main/main.lua" .. inputName .. "?t=" .. tostring(math.random(1, 1000))
    end

    local s, content = pcall(function() return game:HttpGet(finalUrl) end)
    
    if s and content and not content:find("404") then
        local func, err = loadstring(content)
        if func then
            local execSuccess, execError = pcall(func)
            if execSuccess then
                print("✅ [WNDS Success]: Loaded module from " .. inputName)
            else
                warn("❌ [WNDS Exec Error]: " .. inputName .. " | " .. tostring(execError))
            end
        else
            warn("❌ [WNDS Syntax Error]: " .. inputName .. " | " .. tostring(err))
        end
    else
        warn("⚠️ [WNDS Gagal Load]: " .. finalUrl)
        _G.Fluent:Notify({
            Title = "Module Error",
            Content = "Gagal memuat tab: " .. inputName,
            Duration = 5
        })
    end
end

-- // 3. PANGGIL MODUL DENGAN LINK LENGKAP (Sesuai Permintaanmu)
LoadModule("https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/refs/heads/main/tab_info.lua")
LoadModule("https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/refs/heads/main/tab_player.lua")
LoadModule("https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/refs/heads/main/tab_teleport.lua")
LoadModule("https://raw.githubusercontent.com/wnds7820-star/WNDS-Hub/refs/heads/main/tab_visuals.lua")
LoadModule("raw.githubusercontent.com/wnds7820-star/WNDS-Hub/refs/heads/main/tab_teleport.lua")
LoadModule("raw.githubusercontent.com/wnds7820-star/WNDS-Hub/refs/heads/main/tab_settings.lua")

-- // 4. FLOATING BUTTON MOBILE
if isMobile then
    local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
    local Button = Instance.new("TextButton", ScreenGui)
    local UICorner = Instance.new("UICorner", Button)
    ScreenGui.Name = "WNDSToggle"; ScreenGui.ResetOnSpawn = false
    Button.Size, Button.Position = UDim2.new(0, 50, 0, 50), UDim2.new(0, 10, 0.5, 0)
    Button.BackgroundColor3, Button.Text = Color3.fromRGB(120, 117, 242), "W"
    Button.TextColor3, Button.Draggable = Color3.new(1,1,1), true
    UICorner.CornerRadius = UDim.new(0, 15)
    Button.MouseButton1Click:Connect(function()
        game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.RightControl, false, game)
        task.wait(0.05)
        game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.RightControl, false, game)
    end)
end

Fluent:Notify({ Title = "WNDS Hub", Content = "Semua modul berhasil diproses!", Duration = 3 })
