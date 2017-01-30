local c = nil
local d = 0
local e = 100

print(c and d)  -->output:nil
print(c and e)  -->output:nil
print(d and e)  -->output:100
print(c or d)   -->output:0
print(c or e)   -->output:100
print(not c)    -->output:true
print(not d)    -->output:false
