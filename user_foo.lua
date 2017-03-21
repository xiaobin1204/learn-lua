A = 360  --定义全局变量
local foo = require("foo")

local b = foo.add(A, A)

print("b = ", b)

foo.update_A()

print("a = ", A)
