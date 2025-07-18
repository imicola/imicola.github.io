Find命令在linux里用于在指定的目录下**搜索文件和目录**,可以根据各种条件来查找

---
### 基本用法

以下是一些基本的用法
`find [路径] [表达式]`
- `[路径]`:开始搜索的目录,如果不指定则默认为当前目录
- `[表达式]`: 告诉`find`你需要查找什么文件(文件名,类型,大小写) 以及找到之后要执行什么操作
---
常用搜索条件
#### 按名称搜索
参数 `-name` 
用于根据文件名称搜索,支持 shell 通配符
- 搜索名为 test.txt 的文件:
```zsh
find . -name "test.txt"
```
> 在当前目录与子目录查找 `test.txt`

- 搜索所有 `.log` 结尾的文件
```zsh
find /var/log -name "*.log"
```
> 在 `/var/log` 目录下查找所有 `.log` 文件

- 忽略大小写搜索
```zsh
find . -iname "report.pdf"
```
> 会匹配 `Report.pdf` `REPORT.pdf` ...

---
#### 按类型搜索
参数 `-type`
用来指定要搜索的是文件、目录、符号链接等。
- `f`：普通文件
- `d`：目录
- `l`：符号链接 (symbolic link)
搜索名字为 `imicola` 的目录
```zsh
find . -type d -name imicola
```

---

#### 按大小搜索
参数 `-size` 
可以根据文件大小搜索文件
单位: 
- `c` 字节bytes
- `k` 千字节 即KB
- `M` 即MB
- `G` 即GB

---
找到文件后执行操作 (`-exec`)
语法规则 : `... -exec [cmd] {} \;`
- `[cmd]` 是执行的命令
- `{}` 是占位符,会将find找到的每一个文件路径替换
- `\;` 是 `-exec` 命令的结束符,必须存在
```zsh
find /tmp -name "*.tmp" -exec rm {} \;
```
> 找到所有 .tmp后缀文件并删除

---
