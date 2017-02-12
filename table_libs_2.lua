local a = {1,3,5, "hello"}
print(table.concat(a))
print(table.concat(a, "|"))
print(table.concat(a, " ", 4, 2))
print(table.concat(a, "", 2, 4))

-- output
-- 135hello
-- 1|3|5|hello
--
-- 35hello
