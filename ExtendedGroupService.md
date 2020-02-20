# ExtendedGroupService Module: API Documentation
## Module Information
The module has 11 functions in total right now, `:GetGroupsAsync()`, `:GetGroupInfoAsync()`, `:GetRankInGroup()`, `:GetRoleInGroupAsync()`, `:GetPrimaryGroupAsync()`, `:IsInGroupAsync()`, `:IsPrimaryGroupAsync()`, `:GetGroupAlliesAsync()`, `:GetEnemiesAsync()`, `:IsGroupAlly()` and `:IsGroupEnemy()`.

<hr>

## Request Parameter
Some functions (which will be indicated with `request` as an argument) require you to supply it with a request parameter, this can be either a `string` (username), `number` (userId) or `Instance` (Player Object).

<hr>

## Group Object
All group objects return data in the following format:
```lua
{
	"Name": "GroupName",
	"Id": GroupID,
	"EmblemUrl": "http://www.roblox.com/asset/?id=EmblemID",
	"EmblemId": EmblemID,
	"Rank": RankId,
	"Role": "RoleName",
	"IsPrimary": Bool,
	"IsInClan": Bool
}
```

<hr>

## Functions

### `EGS:GetGroupsAsync()`
```lua
--[[
	@function GetGroupsAsync
	@param {request} request The player's name, userId or object.
	@returns {array} groups An array containing the Groups or an empty array
]]
function EGS:GetGroupsAsync(request)
	return groups or {}
end
```

### `EGS:GetGroupInfoAsync()`
```lua
--[[
	@function GetGroupInfoAsync
	@param {integer} groupId The group's Id
	@returns {array} information An array containing the group information or an empty array
]]
function EGS:GetGroupInfoAsync(groupId)
	return information or {}
end
```

### `EGS:GetRankInGroup()`
```lua
--[[
	@function GetRankInGroup
	@param {request} request The player's name, userId or object.
	@param {integer} groupId The group's Id
	@returns {integer} groupRank The user's group rank
]]
function EGS:GetRankInGroup(request, groupId)
	return groupRank or 0
end
```

### `EGS:GetRoleInGroup()`
```lua
--[[
	@function GetRoleInGroup
	@param {request} request The player's name, userId or object.
	@param {integer} groupId The group's Id
	@returns {string} groupRole The user's group role
]]
function EGS:GetRoleInGroup(request, groupId)
	return groupRole or 0
end
```

### `EGS:GetPrimaryGroupAsync()`
```lua
--[[
	@function GetPrimaryGroupAsync
	@param {request} request The player's name, userId or object.
	@returns {group} primaryGroup The user's Primary group
]]
function EGS:GetRoleInGroup(request)
	return primaryGroup or nil
end
```

### `EGS:IsInGroupAsync()`
```lua
--[[
	@function IsInGroupAsync
	@param {request} request The player's name, userId or object.
	@param {integer} groupId The group's Id
	@returns {bool} isInGroup The user's Primary group
]]
function EGS:IsInGroupAsync(request, groupId)
	return isInGroup
end
```
