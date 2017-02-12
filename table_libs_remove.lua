local a = {1,2,3,4}
print(table.remove(a,1))  --删除索引为1的元素
print(a[1],a[2],a[3],a[4])

print(table.remove(a))  --删除最后一个元素
print(a[1],a[2],a[3],a[4])

-- output
-- 1
-- 2       3       4       nil
-- 4
-- 2       3       nil     nil
