### shell是什么？
在开始之前，我们需要了解 *shell* 是什么？
 > *shell*是一种文字交互界面，与GUI(用户图形化界面)不同，shell==允许你执行程序，输入并获取某种半结构化的输出==

在以下的演示中，我们使用*manjaro in wsl*来使用shell,这里我们使用bash，既*Bourne Again SHell*来作为演示终端

### 使用shell
当我们打开终端时候，我们会看到类似下面的提示符
```bash
[imicola@LAPTOP-1R3FN2QL ~]$ 
```
这是 shell 最主要的文本接口
这个提示符告诉我们一些基本信息：
- imicola 是笔者用户名
- LAPTOP-1R3FN2QL 是电脑名称
- ~ 表示工作目录，至于'~',实际上表示的是一整个目录结构，但是经常使用便被简写[^1]
- $ 表示目前身份不是root用户

我们可以输入命令并被shell解析，比如我们输入
```bash
[imicola@LAPTOP-1R3FN2QL ~]$ date
Sun Jun  1 02:45:48 PM CST 2025
```
shell就会告诉我们时间与日期

我们同样可以使用shell去输入带有参数的命令，比如对`echo`命令，这个命令会打印你给它的参数，如下
```bash
[imicola@LAPTOP-1R3FN2QL ~]$ echo hello
hello
```
则`echo`或输出hello
- 当我们输入的参数本身带有空格的时候我们可以使用"hello world"来为`echo`传入一个字符串参数，我们还可以使用 hello\ world来转译空格符号

> [!note] 扩展:shell是如何找到命令并且运行的
>
> - 类似于 Python 或 Ruby，shell 是一个编程环境，所以它具备变量、条件、循环和函数。当你在 shell 中执行命令时，您实际上是在执行一段 shell 可以解释执行的简短代码。如果你要求 shell 执行某个指令，但是该指令并不是 shell 所了解的编程关键字，那么它会去咨询 *环境变量* `$PATH`，它会列出当 shell 接到某条指令时，进行程序搜索的路径
> - 我们可以使用来查询我们的环境变量有什么
> ```bash
> [imicola@LAPTOP-1R3FN2QL ~]$ echo $PATH
> ```
> - 比如当我们执行echo指令时候，shell会在环境变量里通过`$PATH`搜索由`：`划分的一系列目录，基于名字搜索这个程序，当找到该程序后便执行程序
> - 我们也可以使用which指令确定某个程序名代表的是哪个具体的程序，这样可以绕过`$PATH`直接执行这个程序

### 在shell中导航
在谈论这些之前我们先需要认识导航是什么？
- 我们从一个目录定位到另一个目录的行为称之为导航
- 对于每个目录，其存在一个路径，在linux和macOS上使用`/`分割，在Windows上使用`\`分割
- 在linux或macOS上 `/` 也表示一个路径，代表系统的根目录，所有的文件夹都处于这个目录下
- 对于Windows，每个盘都有一个根目录，如`C:\`，`D:\`
- 对于本课程，我们从linux下考虑
如果某个路径以`/`开头，则其为*绝对路径*，其他的都是*相对路径*。
- 相对路径指的是相对于当前工作目录的路径
当前工作目录可以使用命令`pwd`获取
```bash
[imicola@LAPTOP-1R3FN2QL ~]$ pwd
/home/imicola
```
此外，切换目录可以使用`cd`命令。在路径中 `.`表示当前目录`..`表示上级目录
```bash
[imicola@LAPTOP-1R3FN2QL ~]$ pwd
/home/imicola
[imicola@LAPTOP-1R3FN2QL ~]$ cd /home
[imicola@LAPTOP-1R3FN2QL home]$ pwd
/home
[imicola@LAPTOP-1R3FN2QL home]$ cd ..
[imicola@LAPTOP-1R3FN2QL /]$ pwd
/
[imicola@LAPTOP-1R3FN2QL /]$ cd ./home
[imicola@LAPTOP-1R3FN2QL home]$ pwd
/home
[imicola@LAPTOP-1R3FN2QL home]$ cd imicola
[imicola@LAPTOP-1R3FN2QL ~]$ pwd
/home/imicola
[imicola@LAPTOP-1R3FN2QL ~]$ ../../bin/echo hello
hello
```
注意到shell会实时显示当前的路径信息，我们也可以通过配置shell提示符来显示各种有用的信息，比如笔者自己配置的zsh显示效果如下：
![[Pasted image 20250601153717.png]]

一般来说，当我们运行某个程序的时候，如果没有指定文件路径，则该程序会在当前目录下执行，比如我们需要知道一个目录下存在什么文件/文件夹，我们可以使用`ls`命令
```bash
[imicola@LAPTOP-1R3FN2QL ~]$ ls
astrbot  autojump  data  gewechat  imicola
```
除非我们使用第一个参数指定目录，否则`ls`会告诉我们这个目录下的文件
> 大多数的命令接受标记和选项（带有值的标记），它们以 `-` 开头，并可以改变程序的行为。通常，在执行程序时使用 `-h` 或 `--help` 标记可以打印帮助信息，以便了解有哪些可用的标记或选项。

比如`ls -l`可以更加详细的列出目录下文件或文件夹的信息
```bash
15:52:39 with imicola in ~ …
➜ ls -l
total 20
drwxr-xr-x 2 imicola users 4096 Mar 22 20:16 astrbot
drwxr-xr-x 6 imicola users 4096 May 27 22:25 autojump
drwxr-xr-x 9 root    root  4096 Mar 22 20:43 data
drwxr-xr-x 3 imicola users 4096 Mar 27 15:45 gewechat
drwxr-xr-x 3 imicola users 4096 Mar 23 21:37 imicola
```
对于 `ls -l` 输出的参数的含义，可以参考[[ls#-l 参数|Linux命令ls]]

同时我们应该掌握这些命令：
- `mv`(用于重命名或移动文件)
- `cp`(拷贝文件)
- `mkdir`(新建文件夹)

我们可以使用`man`这个程序来获取程序参数、输入输出的信息，了解其工作方式

### 在程序之间创建链接
在shell中，程序有两个主要的"流"——输入流和输出流
- 当程序试图读取信息的时候，它会从输入流中读取
- 当程打印信息的时候，它会将信息输出到输出流中
通常一个程序的输入和输出流都是终端，即将键盘作为输入流，显示器作为输出流，但我们也可以重定向这些流
- 我们可以使用 `< file` 和 `> file`.这两个命令将程序的输入输出重定向到文件
```bash
19:38:20 with imicola in ~/imicola/learn_test …
➜ echo hello > hello.txt && cat hello.txt
hello

19:38:53 with imicola in ~/imicola/learn_test …
➜ cat < hello.txt > hello2.txt

19:39:37 with imicola in ~/imicola/learn_test …
➜ cat hello2.txt
hello
```
> 这里解释第二条命令：我们将hello.txt的内容用cat读取然后输出流定向到hello2.txt

>==还可以使用 `>>` 来向一个文件追加内容==。使用管道(*pipes*)，我们能够更好的利用文件重定向。`|`操作符允许我们将一个程序的输出和另外一个程序的输入连接起来
```bash
19:39:43 with imicola in ~/imicola/learn_test …
➜ ls -l / | tail -n1
drwx------   2 root    root    4096 Apr  1 17:31 wslIjmBcD
```
- `tall` 命令表示显示最后几行(不加参数默认20行)，`-n <行数>` 表示显示几行，在这里我们将根目录的`ls -l`传入`tall`并且输出最后一行

### root
root是类unix系统下的一类用户，也称*根用户*，一般情况下，我们不会直接以根用户的身份登录系统，因为这可能会导致某些错误，取而代之的是我们一般使用`sudo`命令来执行一些操作，在遇到一些权限问题或者拒绝访问时候，我们可以使用`sudo`命令进行访问
>[!important] 以root用户登录系统
>在linux下，以root用户身份登录系统是非常危险的事情，请确保你确实需要再登录。
>
>我们可以使用
>```bash
>su root
>```
>命令登录，这会要求你输入root用户密码


[^1]: 实际上这个~指向的是/home/user目录
