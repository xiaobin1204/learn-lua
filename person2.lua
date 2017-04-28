local person = { name = "Bob", sex = "M" }

-- do something
person = nil
-- do something
if person ~= nil and person.name ~= nil then
  print(person.name)
else
  print("nothing~~")
end
