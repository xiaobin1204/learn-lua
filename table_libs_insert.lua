local a = {1, 8}    --a[1] =1, a[2]=8
table.insert(a, 1, 3)  --在索引为1处插入3
print(a[1], a[2], a[3])
table.insert(a, 10)  --在表的最后插入10
print(a[1], a[2], a[3], a[4])

-- output
-- 3       1       8
-- 3       1       8       10
