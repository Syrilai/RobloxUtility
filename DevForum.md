# DevForum Module: Retrieve DevForum User Data with ease
---

The DevForum Module is a very simple module: It allows you to retrieve a player's DevForum Data (everything that is public to anyone that is). It also offers some very basic functions that don't require you to write long functions, including `:IsNewMember()`, `:IsMember()` and `:GetGroups()`. A full list can be found below.

---
## Module Functions
The module has 9 functions in total right now, `:IsNewMember()`, `:IsMember()`, `:IsLeader()`, `:IsInForum()`, `:GetGroups()`, `:IsInGroup()`, `:GetData()`, `:GetTrustLevel()` and `:PerformRequest()`.<br>

All functions except `:PerformRequest()` take the same type of argument, `request`.
The `request` argument can be one of the following types: `username (string)`, `userId (number)` or an `Player` Instance. The `:PerformRequest()` function only accepts the `username (string)` as it's parameter.

The module receives the information over `HttpService`, so make sure you enabled HTTP Requests in the game you want to use it in.

---
## Documentation
The documentation is the function name and what it returns, like shown in the example below. `DiscourseUser` and `DiscourseGroup` is **always** the JSON provided below. The `:PerformRequest()` function will not be documented since `:GetData()` should be used instead. If it can't find the user you specified, then `system` will be used as fallback. Please note that it will return nil if it can't find any results at all or if an error happened. 

All requests are cached, but you can bypass it by using the `PerformRequest()` function. Example: `PerformRequest(username, true)`. `true` tells the module to bypass the cache and get the latest version.

**Quick Navigation:**
- [:GetData()](#heading--getdata)
- [:GetTrustLevel()](#heading--gettrustlevel)
- [:IsNewMember()](#heading--isnewmember)
- [:IsMember()](#heading--ismember)
- [:IsLeader()](#heading--isleader)
- [:IsInForum()](#heading--isinforum)
- [:GetGroups()](#heading--getgroups)
- [:IsInGroup()](#heading--isingroup)

**Discourse Responses:**
[details="DiscourseUser"]
```json
{
  "user_badges": [
    {}
  ],
  "user": {
    "id": 0,
    "username": "string",
    "avatar_template": "string",
    "name": {},
    "last_posted_at": "string",
    "last_seen_at": "string",
    "created_at": "string",
    "website_name": {},
    "can_edit": true,
    "can_edit_username": true,
    "can_edit_email": true,
    "can_edit_name": true,
    "can_send_private_messages": true,
    "can_send_private_message_to_user": true,
    "trust_level": 0,
    "moderator": true,
    "admin": true,
    "title": {},
    "uploaded_avatar_id": {},
    "badge_count": 0,
    "custom_fields": {},
    "pending_count": 0,
    "profile_view_count": 0,
    "primary_group_name": {},
    "primary_group_flair_url": {},
    "primary_group_flair_bg_color": {},
    "primary_group_flair_color": {},
    "invited_by": {},
    "groups": [
      {
        "id": 0,
        "automatic": true,
        "name": "string",
        "user_count": 0,
        "alias_level": 0,
        "visible": true,
        "automatic_membership_email_domains": {},
        "automatic_membership_retroactive": true,
        "primary_group": true,
        "title": {},
        "grant_trust_level": {},
        "notification_level": {},
        "has_messages": true,
        "is_member": true,
        "mentionable": true,
        "flair_url": {},
        "flair_bg_color": {},
        "flair_color": {}
      }
    ],
    "featured_user_badge_ids": [
      {}
    ],
    "card_badge": {}
  }
}
```
[/details]
[details="DiscourseGroup"]
```json
{
  "id": 0,
  "automatic": true,
  "name": "string",
  "user_count": 0,
  "mentionable_level": 0,
  "messageable_level": 0,
  "visibility_level": 0,
  "primary_group": true,
  "title": "string",
  "grant_trust_level": null,
  "has_messages": true,
  "flair_url": "string",
  "flair_bg_color": "string",
  "flair_color": "string",
  "bio_cooked": "string",
  "bio_excerpt": "string",
  "public_admission": true,
  "public_exit": true,
  "allow_membership_requests": true,
  "full_name": "string",
  "default_notification_level": 0,
  "membership_request_template": "string",
  "members_visibility_level": 0,
  "can_see_members": true,
  "publish_read_state": true
},
```
[/details]

**Documentation Example:**
```lua
function DevForum:FunctionName(parameter)
    return string or nil
end
```

---
<h3 id="heading--getdata"><code>:GetData()</code></h3>

```lua
function DevForum:GetData(request)
	return DiscourseUser or nil
	-- Returns their entire Data
end
```
<h3 id="heading--gettrustlevel"><code>:GetTrustLevel()</code></h3>

```lua
function DevForum:GetTrustLevel(request)
	return number or nil
	-- Returns the users current trust level
end
```
<h3 id="heading--isnewmember"><code>:IsNewMember()</code></h3>

```lua
function DevForum:IsNewMember(request)
	return boolean or nil
	-- Only returns true if they are a New Member
end
```
<h3 id="heading--ismember"><code>:IsMember()</code></h3>

```lua
function DevForum:IsMember(request)
	return boolean or nil
	-- Only returns true if they are a Member
end
```
<h3 id="heading--isleader"><code>:IsLeader()</code></h3>

```lua
function DevForum:IsLeader(request)
	return boolean or nil
	-- Only returns true if they are a Leader
end
```
<h3 id="heading--isinforum"><code>:IsInForum()</code></h3>

```lua
function DevForum:IsInForum(request)
	return boolean or nil
	-- Only returns true if they are a New Member or higher
end
```
<h3 id="heading--getgroups"><code>:GetGroups()</code></h3>

```lua
function DevForum:GetGroups(request)
    return DiscourseGroup[] or nil
    -- Returns an Array of DiscourseGroups the user is in
end
```
<h3 id="heading--isingroup"><code>:IsInGroup()</code></h3>

```lua
-- groupName accepts the group name or group id
function DevForum:IsInGroup(request, groupName)
	return boolean, DiscourseGroup or nil
	-- Warning: This returns both a boolean and a DiscourseGroup
	-- Only returns true if they are in the group
	-- Returns nil instead of DiscourseGroup if they are not in the group
end
```

---
## Where can I get the module
 - [Module @ GitHub](https://github.com/RealSimplyData/RobloxUtility/blob/master/DevForum.lua)
 - [Module @ Roblox](https://www.roblox.com/library/4728831510/DevForum) (Can also be loaded with `require(4728831510)` for auto updates)