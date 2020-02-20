# DevForum Module: API Documentation
## Module Information
The module has 9 functions in total right now, `:IsNewMember()`, `:IsMember()`, `:IsLeader()`, `:IsInForum()`, `:GetGroups()`, `:IsInGroup()`, `:GetData()`, `:GetTrustLevel()` and `:PerformRequest()`.

<hr>

## Request Parameter
Every function (except `:PerformRequest()`) requires you to supply it with a request parameter, this can be either a `string` (username), `number` (userId) or `Instance` (Player Object).

<hr>

## Functions
<b>Please note:</b> `DiscourseUser` its values can be found [here](https://docs.discourse.org/#tag/Users/paths/~1users~1{username}.json/get).
### `DevForum:PerformRequest()`
![devforum#performrequest](/docs/DevForum#PerformRequest.png?raw=true)

### `DevForum:GetData()`
```lua
--[[
	@function PerformRequest
	@param {string|number|Player} The username, userId or Player Object
	@returns {DiscourseUser|nil} The Discourse User or nil
]]
function DevForum:GetData(request)
	return DiscourseUser or nil
end
```

### `DevForum:GetData()`
```lua
--[[
	@function PerformRequest
	@param {string|number|Player} The username, userId or Player Object
	@returns {DiscourseUser|nil} The Discourse User or nil
]]
function DevForum:GetData(request)
	return DiscourseUser or nil
end
```