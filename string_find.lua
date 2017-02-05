local find = string.find
print(find("abc cba", "ab"))
print(find("abc cba", "ab", 2))
print(find("abc cba", "ba", -1))
print(find("abc cba", "ba", -3))
print(find("abc cba", "(%a+)", 1))
print(find("abc cba", "(%a+)", 1, true))
