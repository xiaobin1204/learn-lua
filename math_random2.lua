math.randomseed(os.time())  -- 把种子设置为os.time()
print(math.random())
print(math.random(100))
print(math.random(100, 360))

-- output1
-- 0.7765934616338
-- 69
-- 284
--
-- output2
-- 0.81263416589226
-- 93
-- 357
