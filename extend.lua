----- s_base.lua
local _M = {}

local mt = { __index = _M }

function _M.upper (s)
  return string.upper(s)
end

return _M

------- s_more.lua
local s_base = require "s_base"

local _M = {}
_M = setmetatable(_M, { __index = s_base })

function _M.lower (s)
  return string.lower(s)
end

return _M

--- test.lua
local s_more = require "s_more"

print(s_more.upper("Hello"))  -- output HELLO
print(s_more.lower("Hello"))  -- output hello
