local tab1 = os.date("*t")  -- 返回一个描述当前日期和时间的表
local ans1 = "{"
for k, v in pairs(tab1) do  -- 把tab1转换成一个字符串
  ans1 = string.format("%s %s = %s", ans1, k, tostring(v))
end

ans1 = ans1 .. "}"
print("tab1 = ", ans1)

local tab2 = os.date("*t", 360)  --返回一个描述日期和时间数为360秒的表
local ans2 = "{"
for k, v in pairs(tab2) do  --把tab2转换成一个字符串
  ans2 = string.format("%s %s = %s,", ans2, k, tostring(v))
end

ans2 = ans2 .. "}"

print("tab2 = ", ans2)


-- output
-- tab1 =  { sec = 2 min = 47 day = 19 isdst = false wday = 1 yday = 50 year = 2017 month = 2 hour = 12}
-- tab2 =  { sec = 0, min = 6, day = 1, isdst = false, wday = 5, yday = 1, year = 1970, month = 1, hour = 8,}
