-- array test
local tblTest1 = { 1, a = 2, 3 }
print("Test1 " .. #(tblTest1))

local tblTest2 = { 1, nil }
print("Test2 " .. #(tblTest2))

local tblTest3 = { 1, nil, 2 }
print("Test3 " .. #(tblTest3))

local tblTest4 = { 1, nil, 2, nil }
print("Test4 " .. #(tblTest4))

local tblTest5 = { 1, nil, 2, nil, 3, nil }
print("Test5 " .. #(tblTest5))

local tblTest6 = { 1, nil, 2, nil, 3, nil, 4, nil }
print("Test6 " .. #(tblTest6))

-- ➜ luajit test.lua
-- Test1 2
-- Test2 1
-- Test3 1
-- Test4 1
-- Test5 1
-- Test6 1
--
-- ➜ lua test.lua
-- Test1 2
-- Test2 1
-- Test3 3
-- Test4 1
-- Test5 3
-- Test6 1
