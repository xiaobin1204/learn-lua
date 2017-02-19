file = io.open("test2.txt", "a")  --使用io.open()函数，以添加模式打开文件
file:write("\nhello world2")  --使用file.write() 函数，在文件末尾追加内容
file:close()
