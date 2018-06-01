# ![MongoDB][1] MongoDB 学习笔记 
> MongoDB 是由C++语言编写的，是一个基于分布式文件存储的开源数据库系统。
> MongoDB 将数据存储为一个文档，数据结构由键值(key=>value)对组成。MongoDB 文档类似于 JSON 对象。字段值可以包含其他文档，数组及文档数组。
## 安装

官网下载地址

```
https://www.mongodb.com/download-center#community
```
### windows 版安装

1. 选择对应的版本下载预编译二进制包即可

> Ⅰ. 在 MongoDB 2.2 版本后已经不再支持 Windows XP 系统。最新版本也已经没有了 32 位系统的安装文件。           
> Ⅱ. 在 `Choose Setup Type` 时选择 `Custom` 可指定安装目录            
> Ⅲ. `MongoDB Compass` 是 MongoDB 可视化管理工具，可选择是否安装         
> Ⅳ. 安装后在系统环境变量中添加 MongDB 安装目录下的 `bin` 目录         

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
另一命令行执行 `mongo` 即可连接该服务，不指定地址和端口默认尝试连接`localhost` 的 27017 端口。

### Linux 版安装
1. 根据系统版本下载对应版本的压缩包，解压即可
2. MongoDB 的可执行文件位于 bin 目录下，所以可以将其添加到 PATH 路径中（类似 windows 系统添加到环境变量）    
```
export PATH=MongoDB 安装目录/bin:$PATH
```

## 创建数据库
> `show dbs;` 查看所有数据库；      
> `show users;` 查看用户；
> `db` 查看当前数据库；     
> `use` 指定要使用的数据库，数据库不存在则创建，并且插入数据后才会显示；        
> `db.dropDatabase` 删除数据库；      
> `db.createCollection` 创建集合，集合不需要手动创建，插入数据时会自动创建；      
> `show collections` 显示集合列表；        
> `db.COLLECTION_NAME.drop()` 删除集合；     
> `db.COLLECTION_NAME.insert(document)` 插入数据        
> `db.COLLECTION_NAME.save(document)` 不指定`_id` 时插入数据同 insert ，指定时更新数据；     
> `db.version()` 查看数据库版本；

ps：     
1. Mongdb shell 是 javascripte 环境，语句结束符`;`可省略；   
2. 数据库名全小写，最多64字节，不能是空字符串（"")，不得含有' '（空格)、.、$、/、\和\0 (空字符)；

## 用户管理 
- MongoDB 没有默认管理员用户，所以要先添加管理员用户，再开启权限认证;
- 切换到 admin 数据库，添加的账号才是管理员用户;
- 用户只能在用户所在数据库登录，包括管理员用户;
- 管理员可以管理所有数据库，但是不能直接管理其他数据库，要先在 admin 数据库认证后才可以。

### 添加管理员用户
1. 连接数据库 --> `mongo` 或 `mongo --host=127.0.0.1 --port=27017` ;
2. 切换到 admin 库 --> `use admin;`
3. 插入 admin 用户
```
db.createUser(
   {
     user: "admin",//用户名
     pwd: "admin",//密码
     roles: [ { role: "userAdminAnyDatabase", db: "admin" } ]
   }
)
```
输入输出示例：
```
C:\Users\tal>mongo
MongoDB shell version v3.6.5
connecting to: mongodb://127.0.0.1:27017
MongoDB server version: 3.6.5
//省略 warning 日志
> use admin;
switched to db admin
> show collections;
system.version
> db.createUser({"user":"admin","pwd":"admin","roles":[{"role":"userAdminAnyDatabase","db":"admin"}]})
Successfully added user: {
        "user" : "admin",
        "roles" : [
                {
                        "role" : "userAdminAnyDatabase",
                        "db" : "admin"
                }
        ]
}
> show users;
{
        "_id" : "admin.admin",
        "user" : "admin",
        "db" : "admin",
        "roles" : [
                {
                        "role" : "userAdminAnyDatabase",
                        "db" : "admin"
                }
        ]
}

```





[1]: https://raw.githubusercontent.com/tianqing2117/DailyProgress/master/image/MongoDB/mongoDB.png


