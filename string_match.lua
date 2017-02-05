print(string.match("hello lua", "lua"))
print(string.match("lua lua", "lua", 2))
print(string.match("lua lua", "hello"))
print(string.match("today is 27/7/2015", "%d+/%d+/%d+"))


-- output
-- lua
-- lua
-- nil
-- 27/7/2015
