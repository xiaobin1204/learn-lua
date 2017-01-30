print(1 + 2)  --output: 3
print(5 / 10)  --output:0.5 这是Lua不同于c语言
print(5.0 / 10)  --output:0.5 浮点数相除的结果是浮点数
-- print(10 / 0)  --注意除数不能为0，计算的结果会出错
print(2 ^ 10)  --output: 1024 求2的10次方

local num = 1357
print(num % 2)  --output:1
print((num % 2) == 1) --output: true 判断num是否为奇数
print((num % 5) == 0)  --output: false 判断num是否能被5整除
