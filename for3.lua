local days = {
  "sunday", "monday", "tuesday", "wednesday",
  "thursday", "firday", "saturday"
}

local revDays = {}
for k, v in pairs(days) do
  revDays[v] = k
end

-- print value
for k, v in pairs(revDays) do
  print("k:", k, " v:", v)
end

-- output
-- k:      firday   v:     6
-- k:      monday   v:     2
-- k:      sunday   v:     1
-- k:      thursday         v:     5
-- k:      tuesday  v:     3
-- k:      wednesday        v:     4
-- k:      saturday         v:     7
