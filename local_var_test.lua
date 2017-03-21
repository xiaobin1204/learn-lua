x = 10
local i = 1  --程序块中的局部变量

while i <=x do
  local x = i * 2  -- while 循环体中的局部变量 x
  print(x)  -- output 2,4,6,8...
  i = i + 1
end

if i > 20 then
  local x  -- then 中的局部变量 x
  x = 20
  print(x + 2)  -- 如果 i > 20 将会打印出22,此处的 x 是局部变量
else
  print(x)  -- 打印 10, 这里 x 是全部变量
end

print(x)  -- 打印 10
