local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
Cache = {}

local DevForum = {} do

	DevForum.BaseString = "https://devforum.roblox.com/u/%s.json"
	DevForum.OriginBaseString = "https://www.roblox.com/games/%s/game"

	function DevForum:PerformRequest(username, bypassCache)
		if Cache[username] and not bypassCache then return Cache[username] end
		local url = string.format(self.BaseString, username)
		local response = HttpService:RequestAsync(
			url,
			'GET',
			{
				['Origin'] = string.format(self.OriginBaseString, game.PlaceId),
				['X-Requested-With'] = string.format(self.OriginBaseString, game.PlaceId)
			}
		)
		if response.Success then
			Cache[username] = HttpService:JSONDecode(response.Body)
			return Cache[username]
		else
			if Cache['system'] then
				return Cache['system']
			end
			local rawResponse = HttpService:RequestAsync(
				string.format(self.BaseString, 'system'),
				'GET',
				{
					['Origin'] = string.format(self.OriginBaseString, game.PlaceId),
					['X-Requested-With'] = string.format(self.OriginBaseString, game.PlaceId)
				}
			)
			if rawResponse.Success then
				Cache['system'] = HttpService:JSONDecode(rawResponse.Body);
				return Cache['system']
			end
		end
		error(string.format("DevForum:PerformRequest() could not fetch user data, username = '%s'", username))
	end

	function DevForum:GetData(request)
		local requestType = typeof(request) == "string" and "username" or typeof(request) == "number" and "userid" or (typeof(request) == "Instance" and request:IsA("Player")) and "player"
		local username = requestType == "username" and request or nil
		if requestType == "userid" then
			username = Players:GetNameFromUserIdAsync(request)
		elseif requestType == "player" then
			username = request.Name
		end
		assert(username, "Invalid request parameter, must be either a string, number or Player")
		local userData = self:PerformRequest(username, false)
		return userData
	end

	function DevForum:GetTrustLevel(request)
		return self:GetData(request).user.trust_level
	end

	function DevForum:GetGroups(request)
		return self:GetData(request).user.groups
	end

	function DevForum:IsInGroup(request, param)
		local groups = self:GetGroups(request)
		local keyToCheck = typeof(param) == "number" and "id" or "name"
		for i,v in pairs(groups) do
			if v[keyToCheck] == param then return v end
		end
	end

	function DevForum:IsNewMember(request)
		return self:GetTrustLevel(request) == 1
	end

	function DevForum:IsMember(request)
		local trustLevel = self:GetTrustLevel(request)
		if trustLevel == 2 then return true end
		return trustLevel == 3
	end

	function DevForum:IsLeader(request)
		return self:GetTrustLevel(request) == 4
	end

	function DevForum:IsInForum(request)
		return self:GetTrustLevel(request) >= 1
	end

end

return DevForum
