s = "hello world from lua"
for w in string.gmatch(s, "%a+") do  --匹配最长连续且只含有字母的字符串
  print(w)
end
-- output
-- hello
-- world
-- from
-- lua

t = {}
s = "from=world, to=Lua"
for k, v in string.gmatch(s, "(%a+)=(%a+)") do  --匹配两个最长连续且只含字母的字符串，它们之间用等号连接
  t[k] = v
end

for k, v in pairs(t) do
  print(k,v)
end

-- output
-- to      Lua
-- from    world
