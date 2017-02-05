print(string.gsub("Lua Lua Lua", "Lua", "hello"))
print(string.gsub("Lua Lua Lua", "Lua", "hello", 2))  --指明第四个参数

-- output
-- hello hello hello       3
-- hello hello Lua 2
