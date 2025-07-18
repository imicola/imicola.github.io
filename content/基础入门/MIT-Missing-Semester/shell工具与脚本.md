### shell脚本
对于shell语言，我们已经在[[Shell]]里介绍了基本情况，但是如果我们想更进一步执行更复杂的操作的时候，单纯的一行一行的终端就难以满足我们。此时我们可以使用shell脚本来帮助我们执行

shell脚本在复杂性上进一步提高

大多数shell都有自己的一套脚本语言，包括变量,控制流和自己的语法规则，同时shell脚本针对shell所进行的工作进行了优化。
在本章节我们会专注与bash脚本，因为它最流行也是用途最广泛的shell脚本语言

#### 基本语法规则
- 在bash中为变量赋值的语法是`=`，例如: `foo=bar`,访问变量中储存的数值，其语法为`$foo`
	- 值得注意的是，对于`foo = bar`(使用空格隔开)是不能工作的，因为解释器会调用`foo` 并将 `=`和 `bar` 作为参数传入
	- 所以在使用shell脚本务必要注意空格的使用，因为空格会起到**分割参数**的功能。
- bash中的字符串通过 `'` 和 `"` 分隔符来定义，但是其含义并不一致
	- 用 `'` 定义的字符串被成为原义字符串，其中字符串不会被转译
	- 用 `"` 定义的字符串会将变量值进行替换
```zsh
22:28:21 with imicola in ~ …
➜ homo=114

22:28:53 with imicola in ~ …
➜ echo '$homo'
$homo

22:29:28 with imicola in ~ …
➜ echo "$homo"
114
```

- bash通过 `#` 来进行注释

和其他大多数编程语言一样，`bash`也支持 `if` , `case` , `while` 和 `for`这些控制流关键字，同样的，`bash` 也支持函数

##### if
- 在介绍`if`语法之前，我们需要知道
	- 在shell中，表示判断的命令通常是`test`或别称`[` ,在实际应用中我们更喜欢使用其扩展 `[[` 功能更加强大
	- 在一行书写多个命令的时候，需要使用 `;` 分割。在 `if` , `case` 等结构中，`then`，`do` 等关键词前不需要 `;` 但是如果在同一行，则需要
	- if 使用 `then...fi`来定义代码快
`if`语句用于执行条件判断，根据执行结构执行不同的代码块
**基本语法**
```bash
if condition; then
	# 如果condition为真(返回0),则执行以下命令
	command1
	command2
fi
```
- 带else
```bash
if condition; then
	# condition 为真
	command1
else
	# condition 为假
	command2
fi
```
- 带elif
```bash
if condition1; then
	# condition1为真
	commandA
elif condition2; then
	# condition1为假且condition2为真
	commandB
else
	# 如果condition1 和 condition2均为假
	commandC
fi
```

###### **常用的条件判断：**
- **数值比较：**
    - `[[ $a -eq $b ]]`：等于 (equal)
    - `[[ $a -ne $b ]]`：不等于 (not equal)
    - `[[ $a -gt $b ]]`：大于 (greater than)
    - `[[ $a -ge $b ]]`：大于等于 (greater than or equal)
    - `[[ $a -lt $b ]]`：小于 (less than)
    - `[[ $a -le $b ]]`：小于等于 (less than or equal)
- **字符串比较：**
    - `[[ "$str1" = "$str2" ]]` 或 `[[ "$str1" == "$str2" ]]`：等于
    - `[[ "$str1" != "$str2" ]]`：不等于
    - `[[ -z "$str" ]]`：字符串为空 (zero length)
    - `[[ -n "$str" ]]`：字符串非空 (non-zero length)
- **文件测试：**
    - `[[ -f "file" ]]`：文件存在且是普通文件 (file)
    - `[[ -d "dir" ]]`：文件存在且是目录 (directory)
    - `[[ -e "path" ]]`：文件或目录存在 (exists)
    - `[[ -r "file" ]]`：文件可读 (readable)
    - `[[ -w "file" ]]`：文件可写 (writable)
    - `[[ -x "file" ]]`：文件可执行 (executable)
---
##### case
`case`语法通常根据一个变量的值来进入指定的代码块，标准语法如下：
```bash
case experession in
	pattern1) # 如果experession匹配1
		commandA
		;; # 匹配结束符
	pattern2)
		commandB
		;;
	pattern3 | pattern4) # 可以使用 | 连接多个匹配项 
		commandC
		;;
	*) # deflut情况
		commandD
		;;
esac
```
---
##### while
**基本语法**
```bash
while condition; do
	command1
	command2
done
```
---
##### for
基本语法
```bash
for item in list; do
 # 每次循环，item会取 list 中的一个元素
 # item是变量，list是提取的东西
 command1
 command2
done
```
扩展语法
类似与C语言
```bash
for(( initalization; condition; incement )); do
	# 循环体
	command1
done
```

> [!TIPS] 遍历文件行
> 虽然不是标准的 `for` 循环语法，但通过管道和 `while read` 结合可以遍历文件的每一行。
> ```bash
> while TFS= read -r line; do
> echo "读取到行：$line"
> done < "filename.txt"
> ```

#### 函数与参数
我们通过下面这个例子了解函数
```bash
mcd(){
	mkdir -p "$1"
	cd "$1"
}
```
这个函数表示创建一个文件夹并且cd进入这个文件夹
这里的`$1`是脚本的第一个参数。与其他脚本语言不同的是，bash使用了很多特殊的变量来表示参数，错误代码和相关变量，下面列举一些例子
> - `$0` - 脚本名
> - `$1 - $9` -脚本的参数。`$1`是第一个参数，以此类推
> - `$@` -所有参数
> - `$#` -参数个数
> - `$?` -前一个命令的返回值
> - `$$` -当前脚本的进程识别码
> - `!!` -完整的上一条命令，包括参数。常见应用：当你因为权限不足执行命令失败时，可以使用 `sudo !!` 再尝试一次。
> - `$_` -上一条命令的最后一个参数。如果你正在使用的是交互式 shell，你可以通过按下 `Esc` 之后键入 . 来获取这个值。

更完整的列表可以在[这里](https://www.tldp.org/LDP/abs/html/special-chars.html)参考

---

在命令中通常使用 `STDOUT` 来返回输出值，使用 `STDERR` 来返回错误以及错误码
对错误码而言，返回值为0表示正常执行，其他所有非0返回值都表示有错误发生

退出码可以搭配 `&&` (与操作符) 和 `||` (或操作符) 使用，用来进行条件判断，决定是否可以执行其他程序。
注意，上述两个操作符号都属于[[短路运算符]]

#### 命令替换
我们可以使用命令替换的方式来将变量的形式替换为命令的输出
比如当我们通过`$(cmd)`来执行 `cmd` 指令的时候，他的输出结果会换掉 `$(cmd)` 
- 例如我们执行 `for file in $(ls)` shell会先执行 `ls` 然后遍历得到的这些返回值
>[!tips]
>还有一个小众的特性叫做*进程替换(process substitution)*,基本规则是 `<(cmd)`
>当我们使用这个的时候 `<(cmd)`会执行cmd并将结果输出到一个临时文件里,并将 `<(cmd)`替换成临时文件名

对于这个例子,我们可以通过下面的例子来解释 `$(cmd)`的作用

```zsh
#!/bin/zsh

echo "程序运行开始于 $(date)"
echo "程序 $0 在 $# 个参数下运行与进程 $$"

for file in "$@"
do
    grep 114514 "$file" > /dev/null 2> /dev/null
    if [[ $? -ne 0 ]]; then
        echo "文件 $file 不存在114514,将在最后添加"
        echo "114514" >> "$file"
    fi
done
```
> 这个脚本会遍历你输入的所有文件参数并且寻找114514,如果没有找到则会在末尾添加一行114514

#### 通配
shell的通配字符主要应用在**文件路径的展开上**,需要注意的是,通配不是[[正则表达式]],而是更简单的快速选择文件的符号
- `?` 匹配一个字符
	- 如 `file?.txt`匹配`file1.txt`,`fileA.txt`等
- `*` 匹配任意字符
	- 如 `*.py` 匹配所有 `.py` 结尾的文件
- `[]` 匹配方括号中的任意一个字符
	- 如 `[abc].txt` 匹配 `a.txt,b.txt,c.txt` 
- `{}` 列表生成,即**扩展**为逗号分隔的字符串列表
	- 如 `{test1,test2}.txt` 会被扩展成 `test1.txt test2.txt`

### shell 工具
#### 查看命令如何使用
一般而言在shell中如果要查找某一个命令如何使用以及它可以使用的参数,我们一般使用指令
- `man cmd`
但是有的时候英文解释看不懂,一般情况可以通过翻译以及搜索引擎了解,但是目前准确率相对较高且直接明了的方式是 *询问ai* 

#### 查找文件
查找文件我们一般使用[[find]]命令和[[fd]]命令,可以点击查看具体用法

#### 查找代码
查找代码与文件内容我们一般使用 [[grep]] 命令,是用于对输入文本进行匹配的通用工具,同时我们也会在[[数据整理]]这节课上升入探讨

#### 查找 shell 命令
对于以前输入的命令,shell一般会储存在 `~/.xxx_history`
我们可以使用`history`指令与 `grep` 寻找之前的指令,对于zsh与使用zsh框架的 `oh-my-zsh`都会可以使用上下键来查看历史记录
- 对于大多数shell来说,可以使用 `Ctrl + R` 来对历史记录进行回溯搜索
- 同时使用 `oh-my-zsh`的插件可以实现基于历史的补全

#### 文件夹导航
对于一般而言 `cd` 足以在文件夹中进行导航,当我们想看见树状结构与文件目录的我们可以使用 `tree` 指令
对于快速导航我们可以使用 `auto jump`这样的命令,快速跳跃到我们需要的目录里