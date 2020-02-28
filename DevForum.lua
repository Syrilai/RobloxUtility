local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
Cache = {}

local DevForum = {} do

	DevForum.Version = "1.1"
	DevForum.BaseString = "https://cors-anywhere.herokuapp.com/https://devforum.roblox.com/u/%s.json"
	DevForum.OriginBaseString = "https://www.roblox.com/games/%s/game"

	function DevForum:nullify(tbl)
		for i,v in pairs(tbl) do
			if typeof(v) == "number" then
				tbl[i] = 0
			elseif typeof(v) == "string" then
				tbl[i] = ""
			elseif typeof(v) == "boolean" then
				tbl[i] = false
			elseif typeof(v) == "table" then
				tbl[i] = self:nullify(tbl[i])
			else
				tbl[i] = nil
			end
		end
		return tbl
	end

	function DevForum:PerformRequest(username, bypassCache)
		if Cache[username] and not bypassCache then return Cache[username] end
		local url = string.format(self.BaseString, username)
		local response = HttpService:RequestAsync({
			Url = url,
			Method = 'GET',
			Headers = {
				['Origin'] = string.format(self.OriginBaseString, game.PlaceId),
				['X-Requested-With'] = string.format(self.OriginBaseString, game.PlaceId)
			}
		})
		if response.Success then
			Cache[username] = HttpService:JSONDecode(response.Body)
			return Cache[username]
		else
			if Cache['__fallback'] then
				return Cache['__fallback']
			end
			local rawResponse = HttpService:RequestAsync({
				Url = string.format(self.BaseString, 'system'),
				Method = 'GET',
				Headers = {
					['Origin'] = string.format(self.OriginBaseString, game.PlaceId),
					['X-Requested-With'] = string.format(self.OriginBaseString, game.PlaceId)
				}
			})
			if rawResponse.Success then
				local decoded = HttpService:JSONDecode(rawResponse.Body)
				decoded = self:nullify(decoded)
				Cache['__fallback'] = decoded
				return Cache['__fallback']
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
			if v[keyToCheck] == param then return true, v end
		end
		return false, nil
	end

	function DevForum:IsMember(request)
		return self:GetTrustLevel(request) == 1
	end

	function DevForum:IsRegular(request)
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

local UpdateChecker
local data, err = pcall(function()
	return HttpService:JSONDecode(HttpService:GetAsync("https://raw.githubusercontent.com/RealSimplyData/RobloxUtility/master/UpdateChecker.json"))
end)
if UpdateChecker and UpdateChecker["DevForum"] then
	if UpdateChecker.DevForum ~= DevForum.Version then
		warn("DevForum has a new version: " .. UpdateChecker.DevForum)
		warn("Module is running on: " .. DevForum.Version)
	end
end

return DevForum
