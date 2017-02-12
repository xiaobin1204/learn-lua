local function compare(x, y) --从大到小排序
  return x > y --如果第一个参数大于第二个就返回true，否则返回false
end

local a = { 1, 7, 3, 4, 25}
table.sort(a)  -- 默认从小到大
print(a[1], a[2], a[3], a[4], a[5])
table.sort(a, compare)  --使用比较函数进行排序
print(a[1], a[2], a[3], a[4], a[5])

-- output
-- 1       3       4       7       25
-- 25      7       4       3       1
