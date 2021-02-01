local Service = game:GetService("GroupService")
local Players = game:GetService("Players")

local function PagesToArray(Pages)
	local Array = { }
	while true do
		for _, Value in next, Pages:GetCurrentPage() do Array[#Array + 1] = Value end
		if Pages.IsFinished then break end
		pcall(Pages.AdvanceToNextPageAsync, Pages)
	end
	return Array
end

local function TranslateParameter(request)
	local requestType = typeof(request) == "string" and "username" or typeof(request) == "number" and "userid" or (typeof(request) == "Instance" and request:IsA("Player")) and "player"
	local userId = requestType == "userid" and request or nil
	if requestType == "username" then
		userId = Players:GetUserIdFromNameAsync(request)
	elseif requestType == "player" then
		userId = request.UserId
	end
	assert(userId, "Invalid request parameter, must be either a string, number or Player")
	return userId
end

local GroupService = {} do
	
	function GroupService:GetGroupsAsync(parameter)
		local userId = TranslateParameter(parameter)
		local Success, Groups = pcall(Service.GetGroupsAsync, Service, userId)
		return Success and Groups or { }
	end
	
	function GroupService:GetGroupAlliesAsync(GroupID)
		local Success, GroupAlliesPages = pcall(Service.GetAlliesAsync, Service, GroupID)
		local GroupAllies = Success and GroupAlliesPages and PagesToArray(GroupAlliesPages)
		return GroupAllies or {}
	end

	function GroupService:GetGroupEnemiesAsync(GroupID)
		local Success, GroupEnemiesPages = pcall(Service.GetEnemiesAsync, Service, GroupID)
		local GroupEnemies = Success and GroupEnemiesPages and PagesToArray(GroupEnemiesPages)
		return GroupEnemies or {}
	end
	
	function GroupService:GetGroupInfoAsync(GroupID)
		local Success, GroupInfo = pcall(Service.GetGroupInfoAsync, Service, GroupID)
		return Success and GroupInfo or { }
	end
	
	function GroupService:GetRankInGroupAsync(parameter, groupId)
		local Groups = self:GetGroupsAsync(parameter)
		for Index = 1, #Groups do
			if Groups[Index] and Groups[Index].Id == groupId then
				return Groups[Index].Rank
			end
		end
		return 0
	end
	
	function GroupService:GetRoleInGroupAsync(parameter, groupID)
		local Groups = self:GetGroupsAsync(parameter)
		for Index = 1, #Groups do
			if Groups[Index] and Groups[Index].Id == groupID then
				return Groups[Index].Role
			end
		end
		return "Guest"
	end
	
	function GroupService:GetPrimaryGroupAsync(parameter)
		local Groups = self:GetGroupsAsync(parameter)
		for Index = 1, #Groups do
			if Groups[Index] and Groups[Index].IsPrimary then
				return Groups[Index]
			end
		end
		return nil
	end
	
	function GroupService:IsInGroupAsync(parameter, groupID)
		local Groups = self:GetGroupsAsync(parameter)
		for Index = 1, #Groups do
			if Groups[Index] and Groups[Index].Id == groupID then
				return true
			end
		end
		return false
	end

	function GroupService:IsPrimaryGroupAsync(parameter, groupId)
		local Groups = self:GetGroupsAsync(parameter)
		for Index = 1, #Groups do
			if Groups[Index] and Groups[Index].Id == groupId and Groups[Index].IsPrimary then
				return true
			end
		end
		return false
	end
	
	function GroupService:IsGroupAlly(groupId, allyGroupId)
		local Groups = self:GetGroupAlliesAsync(groupId)
		for Index = 1, #Groups do
			if Groups[Index].Id == allyGroupId then
				return true
			end
		end
		return false
	end

	function GroupService:IsGroupEnemy(groupId, enemyGroupId)
		local Groups = self:GetGroupEnemiesAsync(groupId)
		for Index = 1, #Groups do
			if Groups[Index].Id == enemyGroupId then
				return true
			end
		end
		return false
	end
end

return GroupService
