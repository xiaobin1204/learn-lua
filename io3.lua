file = io.open("test2.txt", "r")  --使用io.open()函数，以只读模式打开文件

for line in file:lines() do  --使用file:lines() 函数逐行读取文件
  print(line)
end

file:close()

-- output
-- my test file
-- hella
-- lua
