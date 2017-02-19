file = io.open("test1.txt", "a+")  --使用 io.open() 函数，以添加模式打开文件
io.output(file)  --使用io.output() 函数，设置默认输出文件
io.write("\nhello world")  --使用 io.write() 函数，把内容写到文件
io.close(file)
