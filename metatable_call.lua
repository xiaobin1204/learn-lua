functor = {}
function func1(self, arg)
  print("called form", arg)
end

setmetatable(functor, {__call = func1})

functor("functor")  --called from functor
print(functor)

-- output
-- called form     functor
-- table: 0x08e98eb8
