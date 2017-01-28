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
