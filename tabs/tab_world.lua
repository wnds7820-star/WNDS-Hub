-- // WNDS HUB v6.5 - ADVANCED WORLD & OPTIMIZER
-- // Developer: Raize

local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

-- // Ambil referensi dari Global yang ada di Main.lua
local Window = _G.WNDS_Window
local Fluent = _G.WNDS_Fluent

-- // --- INTERNAL VARIABLES ---
_G.FullBright = false
local OriginalGravity = Workspace.Gravity

-- // --- CORE FUNCTIONS ---

-- FPS Booster Logic
local function OptimizeGame(state)
    if state then
        for _, obj in pairs(game:GetDescendants()) do
            if obj:IsA("BasePart") then
                obj.Material = Enum.Material.SmoothPlastic
                if obj:IsA("MeshPart") then obj.TextureID = "" end
            elseif obj:IsA("Decal") or obj:IsA("Texture") then
                obj.Transparency = 1
            elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") then
                obj.Enabled = false
            end
        end
    end
end

-- Full Bright Loop
RunService.RenderStepped:Connect(function()
    if _G.FullBright then
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.FogEnd = 100000
        Lighting.GlobalShadows = false
    end
end)

-- // --- UI RENDERING (Fluent Version) ---

local WorldTab = Window:AddTab({ Title = "World", Icon = "globe" })

-- SECTION: ATMOSPHERE
local LightSec = WorldTab:AddSection("Atmosphere Control")

LightSec:AddToggle("FullBright", {
    Title = "Full Bright",
    Description = "Menghilangkan kegelapan",
    Default = false,
    Callback = function(v) _G.FullBright = v end
})

LightSec:AddButton({
    Title = "Remove Fog",
    Description = "Hapus kabut map",
    Callback = function()
        Lighting.FogEnd = 9e9
        for _, v in pairs(Lighting:GetDescendants()) do
            if v:IsA("Atmosphere") or v:IsA("Clouds") then v:Destroy() end
        end
    end
})

-- Tambahan: Time of Day Slider
LightSec:AddSlider("TimeSlider", {
    Title = "Time of Day",
    Description = "Atur waktu dunia",
    Default = 12,
    Min = 0,
    Max = 24,
    Rounding = 1,
    Callback = function(Value)
        if not _G.FullBright then
            Lighting.ClockTime = Value
        end
    end
})

-- SECTION: PERFORMANCE
local PerfSec = WorldTab:AddSection("Performance Booster")

PerfSec:AddToggle("PotatoMode", {
    Title = "Potato Mode",
    Description = "Boost FPS (Material Plastic)",
    Default = false,
    Callback = function(v) OptimizeGame(v) end
})

-- SECTION: PHYSICS
local PhysSec = WorldTab:AddSection("World Physics")

PhysSec:AddSlider("GravitySlider", {
    Title = "Gravity",
    Description = "Default: 196.2",
    Default = 196,
    Min = 0,
    Max = 1000,
    Rounding = 1,
    Callback = function(v) Workspace.Gravity = v end
})

PhysSec:AddButton({
    Title = "Reset Gravity",
    Callback = function() Workspace.Gravity = OriginalGravity end
})
