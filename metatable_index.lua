mytable = setmetatable({key1 = "value1"},  --原始表
  {__index = function(self, key)  --重载函数
    if key == "key2" then
      return "metatablevalue"
    end
  end
})

print(mytable.key1,mytable.key2)
