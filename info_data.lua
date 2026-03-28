-- // WNDS HUB - ACCOUNT & SERVER DATA (ULTIMATE)
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local Market = game:GetService("MarketplaceService")

local info = {}

-- Ambil Foto Profil
local userId = LP.UserId
local thumbType = Enum.ThumbnailType.HeadShot
local thumbSize = Enum.ThumbnailSize.Size150x150
local content, isReady = Players:GetUserThumbnailAsync(userId, thumbType, thumbSize)

-- Ambil Info Game
local success, gameInfo = pcall(function() return Market:GetProductInfo(game.PlaceId) end)
info.GameName = success and gameInfo.Name or "Unknown Game"

-- Data Akun & Sistem
info.Avatar = content or "rbxassetid://0"
info.DisplayName = LP.DisplayName
info.Username = LP.Name
info.UserId = LP.UserId
info.AccountAge = LP.AccountAge
info.Executor = (identifyexecutor and identifyexecutor()) or "Unknown"
info.Platform = (game:GetService("UserInputService"):GetPlatform() == Enum.Platform.Windows) and "PC" or "Mobile"

return info
