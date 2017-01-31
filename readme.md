# learn lua

### Lua 的特性

1. 变量名没有类型，值才有类型，变量名在运行时可与任何类型的值绑定；
2. 语言只提供唯一一种数据结构，称为（table），它混合了数组、哈希，可以用任何类型的值作为key和value。提供了一致且富有表达力的表构造语法，使得Lua很适合描述复杂的数据。
3. 函数是一等类型，支持匿名函数和正则尾递归（proper tail recursion）；
4. 支持词法定界(lexical scoping)和闭包(closure);
5. 提供thread类型和结构化的协程(coroutine)机制，在此基础上可方便实现协作试多任务；
6. 运行期间能编译字符串形式的程序文本并载入虚拟机执行；
7. 通过元表(metatable)和元方法(metamethod)提供动态元机制(dynamic metamechanism)，从而允许程序运行时根据需要改变或扩充语法设施的内定语义；
8. 能方便地利用表和动态元机制实现基于原型(prototype-based)的面向对象模型；
9. 从5.1版开始提供了完善的模块机制，从而更好地支持开发大型的应用程序；

### Lua 基础数据类型

函数type能够返回一个值或一个变量所属的类型。

```
> print(type("hello world"))
string
> print(type(print))
function
> print(type(true))
boolean
> print(type(360.0))
number
> print(type(nil))
nil
```

nil (空)

nil 是一种类型，Lua将nil用于表示“无效值”。一个变量在第一次赋值前的默认值是nil，将nil 赋予给一个全局变量就等于删除它。

```
> local num
> print(num)
nil
> num=100
> print(num)
100
> num = nil
> print(num)
nil
```

OpenResty的Lua接口还提供了一种特殊的空值，即 `ngx.null` ，用来表示不同于nil的“空值”。

boolean（布尔）

布尔类型，可选值true／false；Lua中nil和false为“假”，其他所有值均为“真”；这一点和其他编程语言有些差异。

number (数字)

Number 类型用于表示实数，和C/C++里面的double类型很类似。可以使用数学函数math.floor（向下取整）和 math.ceil(向上取整)进行取整操作。

一般地，Lua的number类型就是用双精度浮点数来实现的。值得一提的是，LuaJit支持所谓"dual-number"(双数)模式，即Luajit会根据上下文用整型来存储整数，而用双精度浮点数来存放浮点数。

另外，Luajit还支持“长长整型”的大整数（在X86_64体系机构上则是64未整数）。

string (字符串)

Lua 中有三种方式表示字符串：

1. 使用一对匹配的单引号。例如：'hello';
2. 使用一对匹配的双引号。例如："holla";
3. 字符串还可以用一种长括号（即[[]]）括起来的方式定义。我们把两个正的方括号（即[[）间插入n个等号定义为第n级正长括号。就是说，0级正的长括号写作[[，一级正的长括号写作[=[，如此等等。反的长括号也作类似定义；举个例子，4级反的长括号写作]====]。一个长字符串可以由任何一级的正的长括号开始，而由第一个碰到的同级反的长括号结束。整个词法分析过程将不受分行限制，不处理任何转义符，并且忽略掉任何不同级别的长括号。这种方式描述的字符串可以包含任何东西，当然本级别的反长括号除外。例：[[abc\nabc]]，里面的“\n”不会被转义。

另外，Lua的字符串是不可改变的值，不能像在C语言中那样直接修改字符串的某个字符，而是根据修改要求来创建一个新的字符串。Lua也不能通过下标来访问字符串的某个字符。想了解更多关于字符串的操作，请看string库章节。

在Lua实现中，Lua字符串一般都会经历一个“内化”(intern)的过程，即两个完全一样的Lua字符串在Lua虚拟机中只会存储一份。每一个Lua字符串在创建时都会插入到Lua虚拟机内部的一个全局的哈希表中。这意味着

1. 创建相同的Lua字符串并不会引入新的动态内存分配操作，所以相对便宜（但仍有全局哈希表查询但开销）；
2. 内容相同的Lua字符串不会占用多份存储空间；
3. 已经创建好的Lua字符串直接进行想等性比较时是`0(1)`时间度的开销，而不是通常见到的`0(n)`.

talbe(表)

Table类型实现来一种抽象的“关联数组”。“关联数组”是一种具有特殊索引方式的数组，索引通常是字符串（string）或者number类型，但也可以是除`nil`以外的任意类型的值。

在内部实现上，table通常实现为一个哈希表、一个数组、或者两者的混合。具体的实现为何种形式，动态依赖于具体的table的键分布特点。

想了解更多关于table的操作，请查看Table库章节。

function (函数)

在Lua中，函数也是一种数据类型，函数可以存储在变量中，可以通过参数传递给其他函数，还可以作为其他函数的返回值。

有名函数的定义本质上是匿名函数对变量的赋值。为说明这一点，考虑

```
function foo()
end
```

等价于

```
foo = function ()
end
```

类似地，

```
local function foo()
end
```

等价于

```
local foo = function ()
end
```

表达式

算术运算符

Lua的算术运算符如下表所示：

算术运算符 | 说明
---|---
+ | 加法
- | 减法
* | 乘法
/ | 除法
^ | 指数
% | 取模

> test1.lua

关系运算符

关系运算符 | 说明
---|---
< | 小于
> | 大于
<= | 小于等于
>= | 大于等于
== | 等于
~= | 不等于

> test2.lua

注意：Lua语言中“不等于”运算符的写法为： ~=

> 在使用“==”作等于判断时，要注意对于table，userdate和函数，Lua是作引用比较的。也就是说，只有当两个变量引用同一个对象时，才认为它们相等。可以看test3.lua

由于Lua字符串总是会被“内化”，即相同内容的字符串只会被保存一份，因此Lua字符串之间的相等性比较可以简化为其内部存储地址的比较。这意味着Lua字符串的相等性比较总是为0（1）。而在其他编程语言中，字符串的相等性比较则通常为0（n），即需要逐个字节（或者按若干个连续字节）进行比较。

逻辑运算符

逻辑运算符 | 说明
---|---
and | 逻辑与
or | 逻辑或
not | 逻辑非

Lua 中的and和or是不同于c语言的。在c语言中，and和or只得到连个值1和0，其中1表示真，0表示假。而Lua中的and的执行过程是这样的：

- `a and b` 如果a为nil，则返回a，否则返回b；
- `a or b` 如果a为nil，则返回b，否则返回a。

> test4.lua

注意：所有逻辑操作符将false和nil视作假，其他任何值视作真，对于and和or，“短路求值”，对于not，永远只返回true或者false

字符串链接

在Lua中链接两个字符串，可以使用操作符“..”(两个点)。如果其任意一个操作数是数字的话，Lua会将这个数字转换成字符串。注意，连接操作符只会创建一个新的字符串，而不会改变原操作数。也可以使用string库函数`string.format`连接字符串。

> test5.lua

由于Lua字符串本质上是只读的，因此字符串连接运算符几乎总会创建一个新的（更大的）字符串。这意味着如果有很多这样的连接操作（比如在循环中使用..来拼接最终结果），则性能损耗会非常大。在这种情况下，推荐使用table和`table.concat()`来进行很多字符串的拼接，例如

```
local pieces = {}
for i, elem in ipairs(my_list) do
  pieces[i] = my_process(elem)
end
local res = table.concat(pieces)
```

当然，上面的例子还可以使用LuaJIT独有的`table.new`来恰当地初始化`pieces`表的空间，以避免该表的动态生长。这个特性我们在后面还会详细讨论。

优先级

Lua操作符的优先级如下表所示（从高到低）：

优先级 |
---|
^ |
not  #  - |
*  /  % |
+  - |
.. |
< |

> test6.lua

若不确定某些操作符的优先级，就应显示地用括号来指定运算顺序。这样作可以提高代码的可读性。

控制结构

流程控制语句对于层序设计来数特别重要，它可以用于设定程序的逻辑结构。一般需要与条件判断语句结合使用。Lua语言提供的控制结构有`if`,`while`,`repeat`,`for`,并提供`break`关键字来满足更丰富的需求。本章主要介绍Lua语言的控制结构的使用。

控制结构if-else

if-else 是我们熟知的一种控制结构。Lua跟其他语言一样，提供了if-else的控制结构。因为是大家熟悉的语法，本节只简单介绍一下它的使用方法。

单个if分支型

```
x = 10
if x > 0 then
  print("x is a positive number")
end
```

> 运行输出：x is a positive number

两个分支if-else型

```
x = 10
if x >0 then
  print("x is a positive number")
else
  print("x is a no-prositive number")
end
```

> 运行输出：x is a prositive number

多个分支if-elseif-else型

```
score = 90
if score == 100 then
  print("Very good!Your score is 100")
elseif score >= 60 then
  print("Congratulations, you have passed it, your score greater or equal to 60")
--此处可以添加多个elseif
else
  print("Sorry, you do not pass the exam! ")
end
```

> 运行输出：Congratulations, you have passed it, your score greater or equal to 60

与C语言的不同之处是else与if是连在一起的，若将else与if写成“else if” 则相当于在else里嵌套另一个if语句，如下代码：

```
score = 0
if score == 100 then
  print("Very good! Your score is 100")
elseif score >= 60 then
  print("Congratulations, you have passed it, your score greater or equal to 60")
else
  if score > 0 then
    print("Your score is better than 0")
  else
    print("My God, your score turned out to be 0")
  end  --与上一示例代码不同的是，此处要添加一个end
end
```

> 运行输出： My God, your score turned out to be 0

wile 型控制结构

Lua跟其他常见语言一样，提供了wile控制结构，语法上也没有什么特别的。但是没有提供do-wile型的控制结构，但是提供了功能相当的repeat。

while 型控制结构语法如下，当表达式值为假（即false或nil）时结束循环。也可以使用break语言提前跳出循环。

```
while 表达式 do
--body
end
```

> 示例代码，求1+2+3+4+5的结果

```
x = 1
sum = 0

while x <= 5 do
  sum = sum + x
  x = x + 1
end
print(sum)  -->output 15
```

值得一提的是，Lua并没有像许多其他语言那样提供类似`continue`这样的控制语句用来立即进入下一个循环迭代（如果有的话）。因此，我们需要仔细地安排循环体里的分支，以避免这样的需求。

没有提供`continue`，却也提供了另外一个标准控制语句`break`，可以跳出当前循环。例如我们遍历table，查找值为11的数组下标索引：

```
local t = {1, 3, 5, 8, 11, 18, 21}

local i
for i, v in ipairs(t) do
  if 11 == v then
    print("index[" .. i .. "] have right value[11]")
    break
  end
end
```

repeat 控制结构

Lua中的repeat控制结构类似于其他语言（如：c++语言）中的do-while，但是控制方式是刚好相反。简单点说，执行repeat循环体后，直到until的条件为真时才结束，而其他语言（如：c++语言）的do-while则是当条件为假时就结束循环。

> 以下代码将会形成死循环：

```
x = 10
repeat
  print(x)
until false
```

> 该代码将导致死循环，因为until的条件一直为假，循环不会结束

除此之外，repeat与其他语言的do-while基本是一样的。同样，Lua中的repeat也可以在使用break退出。

for 控制结构

Lua 提供了一组传统的、小巧的控制结构，包括用于条件判断的if用于迭代的while、repeat和for，本章节主要介绍for的使用。

for数字型

for语句有两种形式：数字for（numeric for）和范式for（generic for）。

> 数字型for的语法如下：

```
for var = begin, finish, step do
  --body
end
```

关于数字for需要注意以下几点：

1. var从begin变化到finish，每次变化都以step作为步长递增var
2. begin、finish、step三个表达式只会在循环开始时执行一次
3. 第三个表达式step是可选的，默认为1
4. 控制变量var的作用域仅在for循环内，需要在外面控制，则需要将值赋给一个新的变量
5. 循环过程中不要改变控制变量的值，那样会带来不可预知的影响

> 示例

```
for i =1, 5 do
  print(i)
end
--output
1
2
3
4
5

for i=1, 10, 2 do
  print(i)
end

--output
1
3
5
7
9
```

> 以下是这种循环的一个典型示例：

```
for i = 10, 1, -1 do
  print(i)
end
--output
10
9
8
7
6
5
4
3
2
1
```

如果不想给循环设置上限的话，可以使用常量math.huge:

```
for i = 1, math.huge do
  if(0.3*i^3 - 20*i^2 - 500 >=0) then
    print(i)
    break
  end
end
```

for泛型

泛型for循环通过一个迭代器（iterator）函数来遍历所有值：

```
-- 打印数组a的所有值
local a = {"a", "b", "c", "d"}
for i, v in ipairs(a) do
  print("index:", i, " value:", v)
end
--output
-- index:  1        value: a
-- index:  2        value: b
-- index:  3        value: c
-- index:  4        value: d
```

Lua的基础库提供了impairs，这是一个用于遍历数组的迭代器函数。在每次循环中，i会被赋予一个索引值，同时v被赋予一个对应于该索引的数组元素值。

> 下面是另一个类型的示例，演示了如何遍历一个table中所有的key

```
-- 打印table t中所有的key
for k in pairs(t) do
  print(k)
end
```

从外观上看泛型for比较简单，但其实它是非常强大但。通过不同的迭代器，几乎可以遍历所有但东西，而且写出但代码极具可读性。标准库提供了集中迭代器，包括用于迭代文件中每行的（io.lines）、迭代table元素的（pairs）、迭代数组元素的（ipairs）、迭代字符串中单词的（string.gmatch）等。

泛型for循环与数字型for循环有两个相同点：

1. 循环变量是循环体的局部变量；
2. 绝不应该对循环变量作任何赋值；

对于泛型for的使用，再来看一个更具体的示例。建设有一个table，它的内容是一周中每天的名称：

```
local days = {
  "sunday", "monday", "tuesday", "wednesday",
  "thursday", "firday", "saturday"
}
```

现在要将一个名称转化成它在一周中的位置。为此，需要根据给定的名称来搜索这个table。然而在Lua中，通常更有效的方法是创建一个“逆向table”。例如这个逆向table焦revDays，它以一周中每天的名称作为索引，位置数字作为值：

```
local revDays = {
  ["sunday"] = 1,
  ["monday"] = 2,
  ["tuesday"] = 3,
  ["wednesday"] = 4,
  ["thursday"] = 5,
  ["friday"] = 6,
  ["saturday"] = 7,
}
```

接下来，要找出一个名称所对应的需要，只需用名字来索引这个reverse table即可：

```
local x = "tuesday"
print(revDays[x]) -->3
```

当然，不必手动声明这个逆向table，而是通过原来的table自动地构造出这个逆向table：

```
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
```

这个循环会为每个元素进行赋值，其中变量k为key（1、2、……），变量v为value（“Sunday”、“Monday”、……）。

值得一提的是，在LuaJIT2.1中，`ipairs()`内建函数是可以被JIT编译的，而`pairs()`则只能被解释执行。因此在性能敏感的场景，应该合理安排数据结构，避免对哈希表进行遍历。事实上，即使未来`pairs`可以被JIT编译，哈希表的遍历本身也不会有数组遍历那么高效，毕竟哈希表就不是为遍历而设计的数据结构。

break,return 关键字

break

语句 `break`用来终止`while`、`repeat`和`for`三种循环的执行，并跳出当前循环体，继续执行当前循环之后的语句。下面举一个`while`循环中的`break`的例子来说明：

```
-- 计算最小的x，使从1到x的所有数相加和大于100
sum = 0
i = 1
while true do
  sum = sum + i
  if sum > 100 then
    break
  end
  i = i + 1
end
print("The result is " .. i)

--output:The result is 14
```

在实际应用中，`break` 经常用于嵌套循环中。
