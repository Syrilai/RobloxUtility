<h1>DevForum Module: API Documentation</h1>
<h2>Module Information</h2>
The module has 9 functions in total right now, `:IsNewMember()`, `:IsMember()`, `:IsLeader()`, `:IsInForum()`, `:GetGroups()`, `:IsInGroup()`, `:GetData()`, `:GetTrustLevel()` and `:PerformRequest()`.

<hr>
<h2>Request Parameter</h2>
Every function (except `:PerformRequest()`) requires you to supply it with a request parameter, this can be either a `string` (username), `number` (userId) or `Instance` (Player Object).

<hr>
<h2>Functions</h2>
```lua
--[[
	@param {string} username The players username
	@param {boolean} bypassCache Should the function bypass the cache
]]
DevForum:PerformRequest(username, bypassCache)
```