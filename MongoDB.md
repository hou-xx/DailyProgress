# MongoDB 学习笔记
> MongoDB 是由C++语言编写的，是一个基于分布式文件存储的开源数据库系统。
> MongoDB 将数据存储为一个文档，数据结构由键值(key=>value)对组成。MongoDB 文档类似于 JSON 对象。字段值可以包含其他文档，数组及文档数组。
## 安装

官网下载地址

```
https://www.mongodb.com/download-center#community
```
### windows 版安装

1. 选择对应的版本下载预编译二进制包即可

> 在 MongoDB 2.2 版本后已经不再支持 Windows XP 系统。最新版本也已经没有了 32 位系统的安装文件。
> 在 `Choose Setup Type` 时选择 `Custom` 可指定安装目录
> `MongoDB Compass` 是 MongoDB 可视化管理工具，可选择是否安装
> 安装后在系统环境变量中添加 MongDB 安装目录下的 `bin` 目录

2. 创建数据目录
MongoDB 将数据目录存储在 `db` 目录下，但`db` 目录不会自动创建需要手动创建
```
cd e:/
mkdir MongoDB
cd MongoDB
mkdir db
```

3. 命令行启动 MongoDB 服务
命令行执行 `mongod --dbpath e:/MongoDB/db` 启动服务；
另一命令行执行 `mongo` 即可连接该服务。

### Linux 版安装

## 创建数据库
> `show dbs;` 查看所有数据库；
> `db` 查看当前数据库；
> `use` 指定要使用的数据库；

ps： 
1. Mongdb shell 是 javascripte 环境，语句结束符`;`可省略；
2. 数据库名全小写，最多64字节，不能是空字符串（"")，不得含有' '（空格)、.、$、/、\和\0 (空字符)；







