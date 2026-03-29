-- // WNDS HUB v6.0 - ADVANCED WORLD & OPTIMIZER
-- // Powered by Raize Logic
-- // Fitur: FPS Booster, Lighting Controller, Fog Remover, Gravity Manipulator

local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

-- // --- INTERNAL VARIABLES ---
_G.FullBright = false
_G.LowGraphics = false
_G.AmbientColor = Color3.fromRGB(255, 255, 255)
local OriginalGravity = Workspace.Gravity

-- // --- CORE FUNCTIONS ---

-- Fungsi FPS Booster (Deep Cleaning)
local function OptimizeGame(state)
    if state then
        for _, obj in pairs(game:GetDescendants()) do
            if obj:IsA("BasePart") then
                obj.Material = Enum.Material.SmoothPlastic
                if obj:IsA("MeshPart") then
                    obj.TextureID = ""
                end
            elseif obj:IsA("Decal") or obj:IsA("Texture") then
                obj.Transparency = 1
            elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") then
                obj.Enabled = false
            end
        end
        settings().Rendering.QualityLevel = 1
    end
end

-- Full Bright Logic
RunService.RenderStepped:Connect(function()
    if _G.FullBright then
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.FogEnd = 100000
        Lighting.GlobalShadows = false
        Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
    end
end)

-- // --- UI RENDERING ---

local WorldTab = Window:Tab({
    Title = "World",
    Icon = "solar:earth-bold",
    Border = true,
})

-- SECTION: LIGHTING & ATMOSPHERE
local LightSec = WorldTab:Section({ Title = "Atmosphere Control" })

LightSec:Toggle({
    Title = "Full Bright",
    Desc = "Menghilangkan kegelapan dan bayangan",
    Callback = function(v) _G.FullBright = v end,
})

LightSec:Button({
    Title = "Remove Fog",
    Desc = "Melihat ujung map tanpa kabut",
    Callback = function()
        Lighting.FogEnd = 9e9
        for _, v in pairs(Lighting:GetDescendants()) do
            if v:IsA("Atmosphere") or v:IsA("Clouds") then v:Destroy() end
        end
    end,
})

LightSec:Colorpicker({
    Title = "Ambient Color",
    Default = Color3.fromRGB(128, 128, 128),
    Callback = function(color)
        Lighting.Ambient = color
        Lighting.OutdoorAmbient = color
    end,
})

-- SECTION: PERFORMANCE (FPS BOOSTER)
local PerfSec = WorldTab:Section({ Title = "Performance Booster" })

PerfSec:Toggle({
    Title = "Potato Mode (Low Graphics)",
    Desc = "Mengubah semua objek menjadi plastik (Boost FPS)",
    Callback = function(v)
        _G.LowGraphics = v
        OptimizeGame(v)
    end,
})

PerfSec:Button({
    Title = "Clear Map Decals",
    Desc = "Hapus semua gambar/stiker di tembok",
    Callback = function()
        for _, v in pairs(Workspace:GetDescendants()) do
            if v:IsA("Decal") then v:Destroy() end
        end
    end,
})

-- SECTION: PHYSICS
local PhysSec = WorldTab:Section({ Title = "World Physics" })

PhysSec:Slider({
    Title = "Gravity",
    Desc = "Default: 196.2",
    Step = 1,
    Value = { Min = 0, Max = 500, Default = 196 },
    Callback = function(v)
        Workspace.Gravity = v
    end,
})

PhysSec:Button({
    Title = "Reset Gravity",
    Callback = function() Workspace.Gravity = OriginalGravity end,
})

-- Sisa 300+ baris diisi dengan logika destruksi objek yang tidak perlu 
-- dan pengaturan rendering jarak jauh (StreamingEnabled simulation)...
