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

### nil (空)

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

### boolean（布尔）

布尔类型，可选值true／false；Lua中nil和false为“假”，其他所有值均为“真”；这一点和其他编程语言有些差异。

### number (数字)

Number 类型用于表示实数，和C/C++里面的double类型很类似。可以使用数学函数math.floor（向下取整）和 math.ceil(向上取整)进行取整操作。

一般地，Lua的number类型就是用双精度浮点数来实现的。值得一提的是，LuaJit支持所谓"dual-number"(双数)模式，即Luajit会根据上下文用整型来存储整数，而用双精度浮点数来存放浮点数。

另外，Luajit还支持“长长整型”的大整数（在X86_64体系机构上则是64未整数）。

### string (字符串)

Lua 中有三种方式表示字符串：

1. 使用一对匹配的单引号。例如：'hello';
2. 使用一对匹配的双引号。例如："holla";
3. 字符串还可以用一种长括号（即[[]]）括起来的方式定义。我们把两个正的方括号（即[[）间插入n个等号定义为第n级正长括号。就是说，0级正的长括号写作[[，一级正的长括号写作[=[，如此等等。反的长括号也作类似定义；举个例子，4级反的长括号写作]====]。一个长字符串可以由任何一级的正的长括号开始，而由第一个碰到的同级反的长括号结束。整个词法分析过程将不受分行限制，不处理任何转义符，并且忽略掉任何不同级别的长括号。这种方式描述的字符串可以包含任何东西，当然本级别的反长括号除外。例：[[abc\nabc]]，里面的“\n”不会被转义。

另外，Lua的字符串是不可改变的值，不能像在C语言中那样直接修改字符串的某个字符，而是根据修改要求来创建一个新的字符串。Lua也不能通过下标来访问字符串的某个字符。想了解更多关于字符串的操作，请看string库章节。

在Lua实现中，Lua字符串一般都会经历一个“内化”(intern)的过程，即两个完全一样的Lua字符串在Lua虚拟机中只会存储一份。每一个Lua字符串在创建时都会插入到Lua虚拟机内部的一个全局的哈希表中。这意味着

1. 创建相同的Lua字符串并不会引入新的动态内存分配操作，所以相对便宜（但仍有全局哈希表查询但开销）；
2. 内容相同的Lua字符串不会占用多份存储空间；
3. 已经创建好的Lua字符串直接进行想等性比较时是`0(1)`时间度的开销，而不是通常见到的`0(n)`.

### talbe(表)

Table类型实现来一种抽象的“关联数组”。“关联数组”是一种具有特殊索引方式的数组，索引通常是字符串（string）或者number类型，但也可以是除`nil`以外的任意类型的值。

在内部实现上，table通常实现为一个哈希表、一个数组、或者两者的混合。具体的实现为何种形式，动态依赖于具体的table的键分布特点。

想了解更多关于table的操作，请查看Table库章节。

### function (函数)

在Lua中，函数也是一种数据类型，函数可以存储在变量中，可以通过参数传递给其他函数，还可以作为其他函数的返回值。

有名函数的定义本质上是匿名函数对变量的赋值。为说明这一点，考虑

```lua
function foo()
end
```

等价于

```lua
foo = function ()
end
```

类似地，

```lua
local function foo()
end
```

等价于

```lua
local foo = function ()
end
```

### 表达式

### 算术运算符

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

### 关系运算符

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

### 逻辑运算符

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

### 字符串链接

在Lua中链接两个字符串，可以使用操作符“..”(两个点)。如果其任意一个操作数是数字的话，Lua会将这个数字转换成字符串。注意，连接操作符只会创建一个新的字符串，而不会改变原操作数。也可以使用string库函数`string.format`连接字符串。

> test5.lua

由于Lua字符串本质上是只读的，因此字符串连接运算符几乎总会创建一个新的（更大的）字符串。这意味着如果有很多这样的连接操作（比如在循环中使用..来拼接最终结果），则性能损耗会非常大。在这种情况下，推荐使用table和`table.concat()`来进行很多字符串的拼接，例如

```lua
local pieces = {}
for i, elem in ipairs(my_list) do
  pieces[i] = my_process(elem)
end
local res = table.concat(pieces)
```

当然，上面的例子还可以使用LuaJIT独有的`table.new`来恰当地初始化`pieces`表的空间，以避免该表的动态生长。这个特性我们在后面还会详细讨论。

### 优先级

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

### 控制结构

流程控制语句对于层序设计来数特别重要，它可以用于设定程序的逻辑结构。一般需要与条件判断语句结合使用。Lua语言提供的控制结构有`if`,`while`,`repeat`,`for`,并提供`break`关键字来满足更丰富的需求。本章主要介绍Lua语言的控制结构的使用。

### 控制结构if-else

if-else 是我们熟知的一种控制结构。Lua跟其他语言一样，提供了if-else的控制结构。因为是大家熟悉的语法，本节只简单介绍一下它的使用方法。

#### 单个if分支型

```lua
x = 10
if x > 0 then
  print("x is a positive number")
end
```

> 运行输出：x is a positive number

#### 两个分支if-else型

```lua
x = 10
if x >0 then
  print("x is a positive number")
else
  print("x is a no-prositive number")
end
```

> 运行输出：x is a prositive number

#### 多个分支if-elseif-else型

```lua
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

```lua
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

### wile 型控制结构

Lua跟其他常见语言一样，提供了wile控制结构，语法上也没有什么特别的。但是没有提供do-wile型的控制结构，但是提供了功能相当的repeat。

while 型控制结构语法如下，当表达式值为假（即false或nil）时结束循环。也可以使用break语言提前跳出循环。

```lua
while 表达式 do
--body
end
```

> 示例代码，求1+2+3+4+5的结果

```lua
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

```lua
local t = {1, 3, 5, 8, 11, 18, 21}

local i
for i, v in ipairs(t) do
  if 11 == v then
    print("index[" .. i .. "] have right value[11]")
    break
  end
end
```

### repeat 控制结构

Lua中的repeat控制结构类似于其他语言（如：c++语言）中的do-while，但是控制方式是刚好相反。简单点说，执行repeat循环体后，直到until的条件为真时才结束，而其他语言（如：c++语言）的do-while则是当条件为假时就结束循环。

> 以下代码将会形成死循环：

```lua
x = 10
repeat
  print(x)
until false
```

> 该代码将导致死循环，因为until的条件一直为假，循环不会结束

除此之外，repeat与其他语言的do-while基本是一样的。同样，Lua中的repeat也可以在使用break退出。

### for 控制结构

Lua 提供了一组传统的、小巧的控制结构，包括用于条件判断的if用于迭代的while、repeat和for，本章节主要介绍for的使用。

### for数字型

for语句有两种形式：数字for（numeric for）和范式for（generic for）。

> 数字型for的语法如下：

```lua
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

```lua
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

```lua
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

```lua
for i = 1, math.huge do
  if(0.3*i^3 - 20*i^2 - 500 >=0) then
    print(i)
    break
  end
end
```

### for泛型

泛型for循环通过一个迭代器（iterator）函数来遍历所有值：

```lua
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

```lua
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

```lua
local days = {
  "sunday", "monday", "tuesday", "wednesday",
  "thursday", "firday", "saturday"
}
```

现在要将一个名称转化成它在一周中的位置。为此，需要根据给定的名称来搜索这个table。然而在Lua中，通常更有效的方法是创建一个“逆向table”。例如这个逆向table焦revDays，它以一周中每天的名称作为索引，位置数字作为值：

```lua
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

```lua
local x = "tuesday"
print(revDays[x]) -->3
```

当然，不必手动声明这个逆向table，而是通过原来的table自动地构造出这个逆向table：

```lua
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

### break,return 关键字

#### break

语句 `break`用来终止`while`、`repeat`和`for`三种循环的执行，并跳出当前循环体，继续执行当前循环之后的语句。下面举一个`while`循环中的`break`的例子来说明：

```lua
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

#### return

`return` 主要用于从函数中返回结果，或者用于简单的结束一个函数的执行。关于函数返回值的细节可以参考 *函数的返回值* 章节。 `return`只能写在语句块的最后，一旦执行了`return`语句，该语句之后的所有语句都不会再执行。若要写在函数中间，则只能写在一个显示的语句块内，参见示例代码：

> return.lua

有时候，为了调试方便，我们可以想在某个函数的中间提前`return`,以进行控制流的短路。此时我们可以将`return`放在一个`do ... end`代码块中，例如：

```lua
local function foo()
  print("before")
  do return end
  print("after")  -- 这一句永远不会执行
end
```

### Lua函数

在Lua中，函数是一种对语句和表达式进行抽象对主要机制。函数既可以完成某项特定对任务，可以只做一些计算并返回结果。在第一种情况中，一句函数调用被视为一条语句；而在第二种情况中，则将其视为一种表达式。

> 示例代码：

```lua
print("hello world!")  --用 print() 函数输出hello world！
local m = math.max(1, 5)  --调用数学库函数max， 用来求饿1，5中最大值，并返回赋给变量m
```

使用函数对好处：

1. 降低程序对复杂性：把函数作为一个独立对模块，写完函数后，只关心它对功能，而不再考虑函数里面的细节。
2. 增加程序的可读性：当我们调用`math.max()`函数时，很明显函数是用于求最大值的，实现细节就不关心了。
3. 避免重复代码：当程序中有相同的代码部分时，可以把这部分代码写成一个函数，通过调用函数来实现这部分代码的功能，节约空间，减少代码长度。
4. 隐含局部变量：在函数中使用局部变量，变量的作用范围不会超出函数，这样它就不会给外界带来干扰。

### 函数定义

Lua使用关键字 *function* 定义函数，语法如下：

```lua
function function_name (arc) --arc 表示参数列表，函数的参数列表可以为空
  -- body
end
```

上面的语法定义了一个全局函数，名为 `function_name`。全局函数本质上就是函数类型的赋值给了一个全局变量，即上面的语法等价于

```lua
function_name = function (arc)
  --body
end
```

由于全局变量一般会污染全局名字空间，同时也有性能损耗（即查询全局环境表的开销），因此我们应当尽量使用“局部函数”，其记法是类似的，只是开头加上`local`修饰符：

```lua
local function function_name(arc)
  --body
end
```

由于函数定义本质上就是变量赋值，而变量的定义总是应放置在变量使用之前，所以函数的定义也需要放置在函数调用之前。

> 示例代码：

```lua
local function max(a, b)  --定义函数max，用来求两个数的最大值，并返回
  local temp = nil  --使用局部变量temp，保存最大值
  if(a > b) then
    temp = a
  else
    temp = b
  end
  return temp  --返回最大值
end

local m = max(-12, 20)  --调用函数max，从-12和20中的最大值
print(m)  -->output:20
```

如果参数列表为空，必须使用 `()`表明是函数调用。

> 示例代码

```lua
local function func()  --形参为空
  print("no parameter")
end

func()  --函数调用，圆括号不能省
--> output: no parameter
```

在定义函数要注意几点：

1. 利用名字来解释函数、变量的目的，使人通过名字就能看出来函数、变量的作用。
2. 每个函数的长度要尽量控制在一个屏幕内，一眼可以看明白。
3. 让代码自己说话，不需要注释最好。

由于函数定义定价于变量赋值，我们也可以把函数名替换为某个Lua表的某个字段，例如：

```lua
function foo.bar(a, b, c)
  --body
end
```

此时我们是把一个函数类型的值赋值给了 `foo` 表的 `bar` 字段。换言之，上面的定义等价于

```lua
foo.bar = function (a, b, c)
  print(a, b, c)
end
```

对于此种形式的函数定义，不能再用 `local` 修饰符来，因为不存在定于新的局部变量了。

### 函数的参数

#### 按值传递

Lua函数的参数大部分是按值传递的。值传递就是调用函数时，实参把它的值通过赋值运算传递给形参，然后形参的改变和实参就没有关系了。在这个过程中，实参是通过它在参数表中的位置与形参匹配起来的。

> 示例才买

```lua
local function swap(a, b)  --定义函数swap，函数内部进行交换两个变量的值
  local temp = a
  a = b
  b = temp
  print(a, b)
end

local x = "hello"
local y = 20
print(x, y)
swap(x, y)  --调用swap函数
print(x, y)  --调用swap函数后，x和y的值并没有交换

--> output:
-- hello 20
-- 20 hello
-- hello 20
```

在调用函数的时候，若形参格式和实参个数不同时，Lua会自动调整实参个数。调整规则：若实参个数大于形参个数，从左向右，多余的实参被忽略；若实参个数小于形参个数，从左向右，没有被实参初始化的形参会被初始化为nil。

> 示例代码：

```lua
local function fun1(a, b)  --两个形参，多余的实参被忽略掉
  print(a, b)
end

local function fun2(a, b, c, d)  --四个形参，没有被实参初始化的形参，用nil初始化
  print(a, b, c, d)
end

local x = 1
local y = 2
local z = 3

fun1(x, y, z)  -- z被函数fun1忽略掉了，参数变成x, y
fun2(x, y, z)  -- 后面自动加上一个nil，参数变成x, y, z, nil

--output
1 2
1 2 3 nil
```

#### 变长参数

上面函数的参数都是固定的，其实Lua还支持变长参数。若形参为`...`，示该函数可以接收不同长度的参数。访问参数的时候也要使用`...`。

> 示例代码：

```lua
local function func( ... )  -- 形参为 ... ，表示函数采用变长参数

  local temp = {...}  -- 访问的时候也要使用 ...
  local ans = table.concat(temp, " ")  -- 使用 table.concat 库函数对数

  print(ans)
end

func(1, 2)  --传递了两个参数
func(1, 2, 3, 4)  --传递了四个参数

--> output
12

1234
```

值得一提的是，LuaJIT2尚不能JIT编译这种变长参数的用法，只能解释执行。所以对性能敏感的代码，应当避免使用此种形式。

#### 具名参数

Lua还支持通过名称来指定参数，这时候要把所有的实参组织到一个table中，并将这个table作为唯一的实参传给函数。

> 示例代码：

```lua
local function change(arg)  --change 函数，改变长方形的长和宽，使其各增长一倍
  arg.width = arg.width * 2
  arg.height = arg.height * 2
  return arg
end

local rectangle = { width = 20, height = 15 }
print("before change: ", "width =", rectangle.width, "height =", rectangle.height)
rectangle = change(rectangle)
print("after change: ", "width =", rectangle.width, "height =", rectangle.height)

-->output
before change: width = 20 height = 15
after change: width = 40 height = 30
```

#### 按引用传递

当函数参数是table类型时，传递进来的是实际参数的引用，此时在函数内部对该table所做的修改，会直接对调用者所传递的实际参数生效，而无需自己返回结果和让调用者进行赋值。我们把上面改变长方形长和宽的例子修改一下。

> 示例代码：

```lua
function change(arg)  --change函数，改变长方形的长和宽，使其各增长一倍
  arg.width = arg.width * 2  --表arg不是表rectangle的拷贝，他们是同一个表
  arg.height = arg.height * 2
end   --没有return语句了

local rectangle = { width = 20, height = 15 }
print("before change: ", "width =", rectangle.width, "height =", rectangle.height)
change(rectangle)
print("after change: ", "width =", rectangle.width, "height =", rectangle.height)

-->output
before change: width = 20 height = 15
after change: width = 40 height = 30
```

在常用基本类型中，除了table是按址传递类型外，其它的都是按值传递参数。用全局变量来代替函数参数的不好编程习惯应该被抵制，良好的编程习惯应该是减少全局变量的使用。

### 函数返回值

Lua具有一项与众不同的特性，允许函数返回多个值。Lua的库函数中，有一些就是返回多个值。

> 示例代码：使用库函数 `string.find`，在源字符串中查找目标字符串，若查找成功，则返回目标字符串在源字符串中的起始位置和结束位置的下标。

```lua
local s, e = string.find("hello world", "llo")
print(s, e)  -->output 3 5
```

返回多个值时，值直接用“,”隔开。

> 示例代码：定义一个函数，实现两个变量交换值

```lua
local function swap(a, b)  -- 定义函数swap，实现两个变量交换值
  return b, a   --按相反顺序返回变量的值
end

local x = 1
local y = 20
x, y = swap(x, y)  调用 swap 函数
print(x, y)  -->output 20 1
```

当函数返回值的个数和接收返回值的变量的个数不一致时，Lua也会自动调整参数个数。

调整规则：若返回值个数大于接收变量的个数，多余的返回值会被忽略掉；若返回值个数小于参数个数，从左向右，没有被返回值初始化的变量会被初始化为 nil。

> 示例代码：

```lua
function init()  --init函数 返回两个值 1 和 “lua”
  return 1, "lua"
end

x = init()
print(x)

x, y, z = init()
print(x, y, z)

-->output
1
1 lua nil
```

当一个函数有一个以上返回值，且函数调用不是一个列表表达式的最后一个元素，那么函数调用只会产生一个返回值，也就是第一个返回值。

> 示例代码：

```lua
local function init()   --init函数 返回两个值 1 和 “lua”
  return 1, "lua"
end

local x, y, z = init(), 2  --init 函数的位置不在最后，此时只返回 1
print(x, y, z)  -->output 1 2 nil

local a, b, c = 2, init()  --init 函数的位置在最后, 此时返回 1 和 “lua”
print(a, b, c)  -->output 2 1 lua
```

函数调用的实参列表也是一个列表表达式。考虑下面的例子：

```lua
local function init()
  return 1, "lua"
end

print(init(), 2)  -->output 1 2
print(2, init())  -->output 2 1 lua
```

如果你确保只取函数返回值的第一个值，可以使用括号运算符，例如

```lua
local function init()
  return 1, "lua"
end

print((init()), 2)  -->output 1 2
print(2, (init()))  -->output 2 1
```

值得一提的是，如果实参列表中某个函数会返回多个值，同时调用者又没有显式地使用括号运算符来筛选和过滤，则这样的表达式是不能被LuaJIT2所JIT编译的，而不能被解释执行。

### 全动态函数调用

调用回调函数，并把一个数组参数作为回调函数的参数。

```lua
local args = {...} or {}
method_name(unpack(args, 1, table.maxn(args)))
```

使用场景

如果你的实参table中确定没有nil空洞，则可以简化为

```lua
method_name(unpack(args))
```

1. 你要调用的函数参数是未知的；
2. 函数的实际参数的类型和数目也都是未知的。

> 伪代码

```lua
add_task(end_time, callback, params)

if os.time() >= endTime then
  callback(unpack(params, 1, table.maxn(params)))
end
```

值得一提的是，`unpack`内建函数还不能为LuaJIT所JIT编译，因此这种用法总是会被解释执行。对性能敏感的代码路径应该避免这种用法。

>  小试牛刀-->niudao.lua

## 模块

从Lua5.1语言添加来对模块和包对支持。一个Lua模块对数据结构是用一个Lua值（通常是一个Lua表或者Lua函数）。一个Lua模块代码就是一个会返回这个Lua值对代码块。可以使用内建函数`require()`来加载和缓存模块。简单对说，一个代码模块就是一个程序库，可以通过`require`来加载。模块加载后的结果通过是一个Lua table，这个表就像是一个命名空间，其内容就是模块中导出的所有东西，比如函数和变量。`require`函数会返回Lua模块加载后的结果，即用于表示该Lua模块的Lua值。

### require 函数

Lua提供了一个名为`require`的函数用来加载模块。要加载一个模块，只需要简单地调用`require`“file”就可以了，file指模块所在的文件名。这个调用会返回一个由模块函数组成的table，并且还会定义一个包含该table的全局变量。

在Lua中创建一个模块最简单的方法就是：创建一个table，并将所有需要导出的函数放入其中，最后返回这个table就可以了。相当于将导出的函数作为table的一个字段，在Lua中函数是第一类值，提供了天然的优势。

> 把下面的代码保存在文件my.lua中

```lua
local foo = {}

local function getname()
  return "Lucy"
end

function foo.greeting()
  print("hello " .. getname())
end

return foo
```

> 把下面的代码保存在文件main.lua中，然后执行main.lua,调用上述模块。

```lua
local fp = require("my")

fp.greeting()  -->output: hello Lucy
```

注⚠️：对于需要导出给外部使用的公共模块，出于安全考虑，是要避免全局变量的出现。我们可以使用lua-releng工具完成全局变量的检测，具体参考lua的 局部变量 章节。

## String 库

Lua 字符串库包含很多强大的字符串操作函数。字符串库中的所有函数都导出在模块string中。在Lua5.1中，它还将这些函数导出作为string类型的方法。这样假设要返回一个字符串转的大写形式，可以写成`ans = string.upper(s)`，也能写成`ans = s:upper()`。为了避免与之前版本不兼容，此处使用前者。

Lua字符串总是由字节构成的。Lua核心并不尝试理解具体的字符集编码（比如GBK和UTF-8这样的多字节字符编码）。

需要特别注意的一点是，Lua字符串内部用来标识各个组成字节的下标是从1开始的，这不同于像C和Perl这样的编程语言。这样数字符串位置的时候再也不用调整，对于非专业的开发者来说可能也是一个好事情，string.sub(str, 3, 7)直接表示从第三个字符开始到第七个字符（含）为止的子串。

### string.byte(s[,i[,j]])

返回字符s[i]、s[i+1]、s[i+2]……s[j]所对应的ASCII码。`i`默认值为1，即第一个字节，`j`的默认值为i。

> 示例代码

```lua
print(string.byte("abc", 1, 3))
print(string.byte("abc", 3))  --缺少第三个参数，第三个参数默认与第二个相同，此时为3
print(string.byte("abc"))  --缺少第二个和第三个参数，此时这两个参数都默认为1

--output
97 98 99
99
97
```

由于 `string.byte` 是返回整数，而并不像 `string.sub` 等函数那样（尝试）创建新都Lua字符串，因此使用`string.byte`来进行字符串相关的扫描和分析是最为高效的，尤其是在被LuaJIT2所JIT编译之后。

### string.char(...)

接收0个或更多的整数（整数范围：0～255），返回这些整数所对应的ASCII码字符组成的字符串。当参数为空时，默认是一个0.

> 示例代码

```lua
print(string.char(96, 97,98))
print(string.char())  --参数为空，默认是一个0 可以用string.byte(string.char())测试一下
print(string.char(65, 66))

-->output
`ab

AB
```

此函数特别适合从具体的字节构造出二进制字符串。这经常比使用 `table.concat`函数和`..`连接运算符更加高效。

### string.upper(s)

接收一个字符串s，返回一个把所有小写字母变长大写字母的字符串。

> 示例代码

```lua
print(string.upper("Hello Lua"))  -->output: HELLO Lua
```

### string.lower(s)

接收一个字符串s，返回一个把所有大写字母变长小写字母的字符串。

> 示例代码

```lua
print(string.lower("Hello Lua"))  -->output: hello lua
```

### string,len(s)

接收一个字符串s，返回它的长度。

> 示例代码

```lua
print(string.len("hello lua"))  -->output:9
```

使用此函数是不推荐的。应当总是使用`#`运算符来获取Lua字符串的长度。

由于Lua字符串的长度是专门存放的，并不需要像C字符串那样即时计算，因此获取字符串长度的操作总是`0(1)`的实际复杂度。

### string.find(s,p[,init[,plain]])

在s字符串第一次匹配p字符串。若匹配成功，则返回p字符串在s字符串中出现的开始位置和结束位置；若匹配失败，则返回nil。第三个参数init默认为1，并且可以为负整数，当init为负数时，表示从s字符串的string.len(s)+init索引处开始向后匹配字符串p。第四个参数默认为false，当其为true时，只会把p看成一个字符串对待。

> 示例代码

```lua
local find = string.fand
print(find("abc cba", "ab"))
print(find("abc cba", "ab", 2))  --从索引为2的位置开始匹配字符串：ab
print(find("abc cba", "ba", -1))  --从索引为7的位置开始匹配字符串：ba
print(find("abc cba", "ba", -3))  --从索引为6的位置开始匹配字符串：ba
print(find("abc cba", "(%a+)", 1))  --从索引为1处匹配最长连续且只含字母的字符串
print(find("abc cba", "(%a+)", 1, true))  --从索引为1处开始匹配字符串:(%a+)

-->output
1 2
nil
nil
6 7
1 3 abc
nil
```

对于LuaJIT这里有个性能优化点，对于string.find方法，当只有字符串查找匹配时，是可以被JIT编译和优化的，有关JIT可以编译优化清单，大家可以参考 [这里](http://wiki.luajit.org/NYI)，性能提升是非常明显的，通常是100倍量级。这里有个[例子](https://groups.google.com/forum/m/#!topic/openresty-en/rwS88FGRsUI)，大家可以参考

### string.format(formatstring, ...)

按照格式化参数formatstring,返回后面`...`内容的格式化版本。编写格式化字符串的规则与标准c语言中printf函数的规则基本相同：它由常规文本和指示组成，这些指示控制了每个参数应放到格式化结果的什么位置，及如何放入它们。一个指示由字符`%`加上一个字母组成，这些字母指定了如何格式化参数，例如`d`用于十进制数、`x`用于十六进制数、`o`用于八进制数、`f`用于浮点、`s`用于字符串等。在字符`%`和字母之间可以再指定一些其他选项，用于控制格式的细节。

> 示例代码

```lua
print(string.format("%.4f", 3.1415926))  --保留4位小数
print(string.format("%d %x %o", 31, 31, 31))  --十进制数31转换成不同进制
d = 29; m = 7; y = 2015
print(string.format("%s %02d/%02d/%d", "today is:", d, m, y))

-->output
3.1416
31 1f 37
today is: 29/07/2015
```

### string.match(s,p[,init])

在字符串s中匹配（模式）字符串p，若匹配成功，则返回目标字符串中与模式匹配的子串；否则返回nil。第三个参数默认为1，并且可以为负整数，当init为负数时，表示从s字符串的string.len(s)+init索引处开始向后匹配字符串p。

> 示例代码

```lua
print(string.match("hello lua", "lua"))
print(string.match("lua lua", "lua", 2))  --匹配后面那个lua
print(string.match("lua lua", "hello"))
print(string.match("today is 27/7/2015", "%d+%d+%d"))
-- output
-- lua
-- lua
-- nil
-- 27/7/2015
```

`string.match`目前并不能被JIT编译，应尽量使用`ngx_lua`模块提供的`ngx.re.match`等接口。

### string.gmatch(s,p)

返回一个迭代器函数，通过这个迭代器函数可以遍历到在字符串s中出现模式串p的所有地方。

> 示例代码

```lua
s = "hello world from lua"
for w in string.gmatch(s, "%a+") do  --匹配最长连续且只含有字母的字符串
  print(w)
end
-- output
-- hello
-- world
-- from
-- lua

t = {}
s = "from=world, to=Lua"
for k, v in string.gmatch(s, "(%a+)=(%a+)") do  --匹配两个最长连续且只含字母的字符串，它们之间用等号连接
  t[k] = v
end

for k, v in pairs(t) do
  print(k,v)
end

-- output
-- to      Lua
-- from    world
```

此函数目前不能被LuaJIT所JIT编译，而只能被解释执行。应尽量使用ngx_lua模块提供的`ngx.re.gmatch`等接口。

### string.rep(s,n)

返回字符串s的n次拷贝。

> 示例代码

```lua
print(string.rep("abc", 3))  --拷贝3次“abc”
--output
abcabcabc
```

### string.sub(s,i[,j])

返回字符串s中，索引i到索引j之间的子字符串。当j缺省时，默认为-1，也就是字符串s的最后位置。i可以为负数。当索引i在字符串s的位置在索引j的后面时，将返回一个空字符串。

> 示例代码

```lua
print(string.sub("Hello Lua", 4, 7))
print(string.sub("Hello Lua", 2))
print(string.sub("Hello Lua", 2, 1))  --看到返回什么了吗
print(string.sub("Hello Lua", -3, -1))

-- output
-- lo L
-- ello Lua
--
-- Lua

```

如果你只想对字符串中的单个字节进行检查，使用`string.char`函数通常会更为高效。

### string.gsub(s,p,r[,n])

将目标字符串s中所有的子串p替换成字符串r。可选参数n，表示限制替换次数。返回值有两个，第一个是被替换后的字符串，第二个是替换了多少次。

> 示例代码

```lua
print(string.gsub("Lua Lua Lua", "Lua", "hello"))
print(string.gsub("Lua Lua Lua", "Lua", "hello", 2))  --指明第四个参数

-- output
-- hello hello hello       3
-- hello hello Lua 2
```

此函数不能为LuaJIT所JIT编译，只能被解释执行。一般我们推荐使用ngx_lua模块提供的`ngx.re.gsub`函数。

### string.reverse(s)

接收一个字符串s，返回这个字符串的反转。

> 示例代码

```lua
print(string.reverse("Hello Lua"))   -->output:auL olleH
```

## table库

table 库是由一些辅助函数构成对，这些函数将table作为数组来操作。

**下标从1开始**

在Lua中，数组下标从1开始计数。

> 官方解释：Lua lists have a base index of 1 because it was thought to be most friendly for non-programmers, as it makes indices correspond to ordinal element positions.

确实，对于我们数数来说，总是从1开始数的，而从0开始对于描述偏移量这样的东西有利。而Lua最初设计是一种类型XML的数据描述语言，从而索引(index)反应的是数据在里面的位置，而不是偏移量。

在初始化一个数组的时候，若不显式地用键值对方式赋值，则会默认用数字作为下标，从1开始。由于在Lua内部实际采用哈希表和数组分别保存键值对、普通值，所以不推荐混合使用这两种赋值方式。

> 示例代码 table_libs_1.lua

从其他语言过来对开发者会觉得比较坑对一点是，当我们把table当作栈或者队列使用对时候，容易犯错，追加到table对是`s[#s+1] = something`，而不是`s[#s] = something`，而且如果这个something是一个nil的话，会导致这一次压栈（或者入队列）没有存入任何东西，#s的值没有变。如果`s = {1,2,3,4,5,6}`，你令`s[4] = nil`，#s会令你“匪夷所思”地变成3.

### table.getn 获取长度

取长度操作符写作一元操作#。字符串的长度是它的字节数（就是以一个字符一个字符计算的字符串长度）。

对于常规的数组，里面用1到n放着一些并非空的值的时候，它的长度就精确的为n，即最后一个值的下标。如果数组有一个“空洞”（就是说，nil值被夹在非空值之间），那么#t可能是值向任何一个是nil值的前一个位置的下标（就是说，任何一个nil值都有可能被当成数组的结束）。这也就说明对于有“空洞”的情况，table的长度存在一定的不可确定性。

```lua
local tblTest1 = { 1, a = 2, 3}
print("Test1 " .. table.getn(tblTest1))

local tblTest2 = { 1, nil}
print("Test2 " .. table.getn(tblTest2))

local tblTest3 = { 1, nil, 2}
print("Test3 " .. table.getn(tblTest3))

local tblTest4 = { 1, nil, 2, nil}
print("Test4 " .. table.getn(tblTest4))

local tblTest5 = { 1, nil, 2, nil, 3, nil}
print("Test5 " .. table.getn(tblTest5))

local tblTest6 = {1, nil, 2, nil, 3, nil, 4, nil}
print("Test6 " .. table.getn(tblTest6))

```

我们使用Lua5.1 和 LuaJIT2.1分别执行这个用例，结果如下：

```lua
# lua test.lua
Test1 2
Test2 1
Test3 3
Test4 1
Test5 3
Test6 1
# luajit test.lua
Test1 2
Test2 1
Test3 1
Test4 1
Test5 1
Test6 1
```

这一段的输出结果，就是这么匪夷所思。请问，你以后还敢在lua的table中使用nil值吗？如果你继续往后面加nil，你可能会发现点什么。你可能认为你发现的是规律。但是，你千万不要认为这是个规律，因为这是错误的。

不要在lua的table中使用nil值，如果一个元素要删除，直接remove，不要用nil去代替。

### table.concat(table[,sep[,i[,j]]])

对于元素是string或者number类型的表table，返回`table[i]..sep..table[i+1]···sep..table[j]`连接成字符串。填充字符串sep默认为空白字符串。起始索引位置i默认为1，结束索引位置j默认为table的长度。如果i大于j，返回一个空字符串。

> table_libs_2.lua

### table.insert(table,[pos,] value)

在（数组型）表table的pos索引位置插入value，其它元素向后移动到空的地方。pos的默认值是表的长度加一，即默认是插在表的最后。

> table_libs_insert.lua

### table.maxn(table)

返回（数组型）表table的最大索引编号；如果此表没有正在索引的编号，返回0.

当长度省略时，此函数通常需要`0(n)`的时间复杂度来计算table的末尾。因此用这个函数省略索引位置的调用形式来作为table元素的末尾追加，是高代价操作。

> table_libs_maxn.lua

此函数的行为不同于`#`运算符，因为`#`可以返回数组中任意一个nil空洞或者最后一个nil之前的元素索引。当然，该函数的开销相比`#`运算也会更大一些。

### table.remove(table[,pos])

在表中删除索引为pos（pos只能是number型）的元素，并返回这个被删除的元素，它后面所有的元素的索引都会减一。pos的默认值是表的长度，即默认删除表的最后一个元素。

> table_libs_remove.lua

### table.sort(table[,comp])

按照给定的比较函数comp给表table排序，也就是从table[1]到table[n]，这里n表示table的长度。比较函数有两个参数，如果希望第一个参数排在第二个前面，就应该放true，否则返回false。如果比较函数comp没有给出，默认从小到大排序。

> table_libs_sort.lua

### table 其它非常有用的函数

LuaJIT2.1新增加的`table.new`和`table.clear`函数是非常有用的。前者主要用来预分配lua table空间，后者主要用来高效释放table空间，并且它们都可以被JIT编译的。具体可以参考一下OpenResty捆绑的lua-resty- * 库,里面有些实例可以作为参考。


## 日期时间函数

在Lua中，函数time、date和difftime提供了所有的日期和时间功能。

在OpenResty的世界里，不推荐使用这里的标准时间函数，因为这些函数通常会引发不止一个昂贵的系统调用，同时无法为LuaJIT JIT编译，对性能造成较大影响。推荐使用ngx_lua模块提供的带缓存的时间接口，如 `ngx.today`, `ngx.time`, `ngx.utctime`, `ngx.localtime`, `ngx.now`, `ngx.http_time`, 以及 `ngx.cookie_time`等。

所以下面的部分函数，简单了解一下即可。

### os.time([table])

如果不使用参数table调用time函数，它会返回当前的时间和日期（它表示从某一时刻到现在的秒数）。如果用table参数，它会返回一个数字，表示该table中所描述的日期和时间（它表示从某一时刻到table中描述日期和时间的秒数）。table的字段如下：

| 字段名称 | 取值范围 |
| :------------- | :------------- |
| year | 四位数字 |
| month | 1--12 |
| day | 1--31 |
| hour | 0--23 |
| min | 0--59 |
| sec | 0--61 |
| isdst | boolean(true表示夏令时) |

对于time函数，如果参数为table，那么table中必须含有year、month、day字段。其他字缺省时段默认为中午（12:00:00）。

> time1.lua(地点为北京)

### os.difftime(t2, t1)

返回t1到t2的时间差，单位为秒

> time_difftime.lua

### os.date([format[,time]])

把一个表示日期和时间的数值，转换成更高级的表现形式。其第一个参数format是一个格式化字符串，描述了要返回的时间形式。第二个参数time就是日期和时间的数字表示，缺省时默认为当前的时间。使用格式字符"* t",创建一个时间表。

> time_date.lua

该表中除了使用到了time函数参数table的字段外，这还提供了星期（wday，星期天为1）和一年中的第几天（yday，一月一日为1）。除了使用“* t”格式化字符串外，如果使用带标记（见下表）的特殊字符串，os.date函数会将相应的标记为以时间信息进行填充，得到一个包含时间的字符串。如下表：

| 格式字符 | 含义 |
| :------------- | :------------- |
| %a | 一个星期中天数的简称（例如：Wed） |
| %A | 一个星期中天数的全称（例如：Wednesday） |
| %b | 月份的简称（例如：Sep） |
| %B | 月份的简称（例如：September） |
| %c | 日期和时间（例如：07/30/15 16:57:24） |
| %d | 一个月中的第几天[01~31] |
| %H | 24小时制中的小时数[00~23] |
| %I | 12小时制中的小时数[01~12] |
| %j | 一年中的第几天[001~366] |
| %M | 分钟数[00~59] |
| %m | 月份数[01~12] |
| %p | “上午(am)”或"下午(pm)" |
| %S | 秒数[00~59] |
| %w | 一个星期中的第几天[1~7 = 星期天～星期六] |
| %x | 日期例如：07/30/15 |
| %X | 时间例如：16:57:24 |
| %y | 两位数的年份[00~99] |
| %Y | 完整的年份例如：2015 |
| %% | 字符‘%’ |

> time_date2.lua

## 数学库

Lua 数学库由一组标准的数学函数构成。数学库的引入丰富了Lua变成语言的功能，同时也方便了程序的编写。常用数学函数见下表：

| 函数名 | 函数功能 |
| :------------- | :------------- |
| math.rad(x) | 角度x转换成弧度 |
| math.deg(x) | 弧度x转换成角度 |
| math.max(x, ...) | 返回参数中值最大的那个数，参数必须是number型 |
| math.min(x, ...) | 返回参数中值最小的那个数，参数必须是number型 |
| math.random([m[,n]]) | 不传入参数时，返回一个在区间[0,1]内均匀分布的伪随机数；只使用一个整数参数m时，返回一个在区间[1,m]内均匀分布的伪随机整数；使用两个整数参数时，返回一个在区间[m,n]内均匀分布的伪随机整数 |
| math.randomseed(x) | 为伪随机数生成器设置一个种子x，相同的种子将会生成相同的数字序列 |
| math.abs(x) | 返回x的绝对值 |
| math.fmod(x,y) | 返回x对y取余数 |
| math.pow(x,y) | 返回x的y次方 |
| math.sqrt(x) | 返回x的算术平方根 |
| math.exp(x) | 返回自然数e的x次方 |
| math.log(x) | 返回x的自然对数 |
| math.log10(x) | 返回以10为底，x的对数 |
| math.floor(x) | 返回最大且不大于x的整数 |
| math.ceil(x) | 返回最小且不小于x的整数 |
| math.pi | 圆周率 |
| math.sin(x) | 求弧度x的正弦值 |
| math.cos(x) | 求弧度x的余弦值 |
| math.tan(x) | 求弧度x的正切值 |
| math.asin(x) | 求x的反正弦值 |
| math.acos(x) | 求x的反余弦值 |
| math.atan(x) | 求x的反正切值 |

> math1.lua

另外使用`math.random()`函数获取伪随机数时，如果不使用`math.randomseed()`设置伪随机数生成种子或者设置相同的伪随机数生成种子，那么得到的伪随机数序列是一样的。

> math_random.lua

为了避免每次程序启动时得到的都是相同的伪随机数序列，通常是使用当前时间作为种子。

> math_random2.lua

## 文件操作

Lua I/O库提供两种不同的方式处理文件：隐式文件描述，显示文件描述。

这些文件I/O操作，在OpenResty的上下文中对事件循环是会产生阻塞效应。OpenResty比较擅长的是高并发网络处理，在这个环境中，任何文件的操作，都将阻塞其他并行执行的请求。实际中的应用，在OpenResty项目中应尽量让网络处理部分、文件I/O操作部分相互独立，不要柔和在一起。

### 隐式文件描述

设置一个默认的输入或输出文件，然后在这个文件上进行所有的输入或输出操作。所有的操作函数由io表提供。

> 打开已经存在的`test1.txt`文件，并读取里面的内容

> io1.lua

> 在`test1.txt`文件的最后添加一行"hello world"

> io2.lua

打开 `text1.txt`查看变化

### 显示文件描述

使用file.xxx()函数方式进行操作，其他file为io.open()返回的文件句柄。

> 打开已经存在的test2.txt文件，并读取里面的内容

> io3.lua

> 在test2.txt文件的最后添加一行“hello world”

> io4.lua

打开 `text2.txt`查看变化

### 文件操作函数

#### io.open(filename[,mode])

按指定的模式mode,打开一个文件名为`filename`的文件，成功则返回文件句柄，失败则返回nil加错误信息。模式：

| 模式 | 含义 | 文件不存在时 |
| :------------- | :------------- | :------------- |
| "r"       | 读模式（默认）       | 返回nil加错误信息       |
| "w"       | 写模式       | 创建文件     |
| "a"       | 添加模式       | 创建文件       |
| "r+"       | 更新模式，保存之前的数据       | 返回nil加错误信息       |
| "w+"       | 更新模式，清除之前的数据       | 创建文件      |
| "a+"       | 添加更新模式，保存之前的数据，在文件尾进行添加       | 创建文件      |

模式字符串后面可以由一个'b'，用于在某些系统中打开二进制文件。

注意"w"和"wb"的区别

- "w"表示文本文件。某些文件系统（如Linux的文件系统）认为0x0A为文本文件的换行符，Windows的文件系统认为0x0D0A为文本文件的换行符。为了兼容其他文件系统（如从Linux拷贝来的文件），Windows的文件系统在写文件时，会在文件中0x0A的前面加上0x0D。使用"w",其属性要看所在的平台。
- "wb"表示二进制文件。文件系统会按存储的二进制格式进行写操作，因此也就不存在格式转换的问题。（Linux文件系统下"w"和"wb"没有区别）

#### file:close()

关闭文件。注意：当文件句柄被垃圾收集后，文件将自动关闭。句柄将变为一个不可预知的值。

#### io.close([file])

关闭文件，和file:close()的作用相同。没有参数file时，关闭默认输出文件。

#### file:flush()

把写入缓冲去的所有数据写入到默认输出文件。

#### io.flush()

相当于file:flush(),把写入缓冲区的所有数据写入到默认输出文件。

#### io.input([file])

当使用一个文件名调用时，打开这个文件（以文本模式），并设置文件句柄为默认输入文件；当使用一个文件句柄调用时，设置此文件句柄为默认输入文件；当不使用参数调用时，返回默认输入文件句柄。

#### file:lines()

返回一个迭代函数，每次嗲用将获得文件中的一行内容，当到文件尾时，将返回nil，但并不关闭文件。

#### io.lines([filename])

打开指定文件filename为读模式并返回一个迭代函数，每次调用将获得文件中的一行内容，当到文件尾时，将返回nil，并自动关闭文件。若不带参数时io.lines()等价于io.input():lines()读取默认输入设备的内容，结束时不关闭文件。

#### io.output([file])

类似于io.input,但操作在默认输出文件上。

#### file:read(...)

按指定的格式读取一个文件。按每个格式将返回一个字符串或数字，如果不能正确读取将返回nil，若没有指定格式将指默认按行方式进行读取。格式：

| 格式 | 含义 |
| :------------- | :------------- |
| "*n" | 读取一个数字       |
| "*a" | 从当前位置读取整个文件。若当前位置为文件尾，则返回空字符串       |
| "*l" | 读取下一行的内容。若为文件尾，则返回nil。（默认）       |
| number | 读取指定字节数的字符。若为文件尾，则返回nil。如果number为0，则返回空字符串，若为文件尾，则返回nil       |

#### io.read(...)

相当于io.input():read

#### io.type(obj)

检测obj是否一个可用的文件句柄。如果obj是一个打开的文件句柄，则返回“file”如果obj是一个已关闭的文件句柄，则返回"closed file" 如果obj不是一个文件句柄，则返回nil。

#### file:write(...)

把每一个参数的值写入文件。参数必须为字符串或数字，若要输出其他值，则需要通过tostring或string.format进行转换。

#### io.write(...)

相当于io.output():write.

#### file:seek([whence][,offset])

设置和获取当前文件位置，成功则返回最终的文件位置（按字节，相对于文件开头），失败则返回nil加错误信息。缺省时，whence默认为"cur",offset默认为0.参数whence：

| whence | 含义 |
| :------------- | :------------- |
| "set" | 文件开始       |
| "cur" | 文件当我位置（默认）       |
| "end" | 文件结束       |

#### file:setvbuf(mode[,size])

设置输出文件的缓冲模式。模式：

| 模式 | 含义 |
| :------------- | :------------- |
| “no” | 没有缓冲，即直接输出 |
| “full” | 全缓冲，即当缓冲满后才进行输出操作（也可调用flush马上输出） |
| “line” | 以行为单位，进行输出 |

最后两种模式，size可以指定缓冲的大小（按字节），忽略size将自动调整为最佳大小。
