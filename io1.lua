file = io.input("test1.txt")  -- 使用io.input()函数打开文件

repeat
  line = io.read()  -- 逐行读取内容，文件结束时返回nil
  if nil == line then
    break
  end
  print(line)
until (false)

io.close(file)

-- output
-- my test file
-- hella
-- lua
