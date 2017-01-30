local function foo()
  print("in the function")
  --dosomething()
  local x = 10
  local y = 20
  return x + y
end

local a = foo  --把函数赋给变量

print(a())

--output:
--in the function
--30
