# ![MongoDB][1] MongoDB 学习笔记 
> MongoDB 是由C++语言编写的，是一个基于分布式文件存储的开源数据库系统。
> MongoDB 将数据存储为一个文档，数据结构由键值(key=>value)对组成。MongoDB 文档类似于 JSON 对象。字段值可以包含其他文档，数组及文档数组。
## 安装

官网下载地址

```
https://www.mongodb.com/download-center#community
```
#### windows 版安装

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

#### Linux 版安装
1. 根据系统版本下载对应版本的压缩包，解压即可
2. MongoDB 的可执行文件位于 bin 目录下，所以可以将其添加到 PATH 路径中（类似 windows 系统添加到环境变量）    
```
export PATH=MongoDB 安装目录/bin:$PATH
```

## 常用命令
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
> `db.cloneDatabase("127.0.0.1")`   将指定机器上的数据库的数据克隆到当前数据；     
> `db.copyDatabase("mydb", "temp", "127.0.0.1")`  将本机的mydb的数据复制到temp数据库中；

## 用户管理 
- MongoDB 没有默认管理员用户，所以要先添加管理员用户，再开启权限认证;
- 切换到 admin 数据库，添加的账号才是管理员用户;
- 用户只能在用户所在数据库登录，包括管理员用户;
- 管理员可以管理所有数据库，但是不能直接管理其他数据库，要先在 admin 数据库认证后才可以。

#### 添加管理员用户
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

#### 开启权限认证
a. 权限认证方式启动服务  

- 新建 MongoDB 配置文件 `e:/MongoDB/MongoDB.conf`     
- 向配置文件添加配置

```
dbpath = e:/MongoDB/db  # 指定dbpath ，需要手动创建文件夹
logpath = e:/MongoDB/logs/MongoDB.log  # 指定日志输出路径，需手动创建文件
logappend =  # 制定日志是追加
journal = # 表示启动日志
auth = true # 指定开启权限认证
```

- 使用配置文件启动方式启动服务 `mongod -f e:/MongoDB/MongoDB.conf` 或 `mongod --config e:/MongoDB/MongoDB.conf`
   
b.  用户验证  
- `mongo` 连接数据库；
- `show dbs;` 会有 `"Unauthorized"` 错误，说明权限认证已开启；
- `use admin` 切换到 admin 库，`db.auth('admin','admin')` 用户授权，授权成功 显示 1 ，失败显示 0 和错误信息；

#### 添加普通数据库用户
1. admin 库管理登陆；
2. 切换到业务数据库 `use demo;` , demo是数据库名；
3. 创建用户 `db.createUser({"user":"demoUser","pwd":"demoUser","roles":[{"role":"readWrite","db":"demo"}]});`
4. 使用新建的用户登陆对应的数据库即可。

#### 数据库角色
角色类型|角色名称
:---:|:---:
数据库用户角色|read、readWrite;
数据库管理角色|dbAdmin、dbOwner、userAdmin；
集群管理角色|clusterAdmin、clusterManager、clusterMonitor、hostManager；
备份恢复角色|backup、restore；
所有数据库角色|readAnyDatabase、readWriteAnyDatabase、userAdminAnyDatabase、dbAdminAnyDatabase
超级用户角色|root #这里还有几个角色间接或直接提供了系统超级用户的访问（dbOwner 、userAdmin、userAdminAnyDatabase）
内部角色|__system

角色名称|角色说明
:---:|:---:
Read|允许用户读取指定数据库
readWrite|允许用户读写指定数据库
dbAdmin|允许用户在指定数据库中执行管理函数，如索引创建、删除，查看统计或访问system.profile
userAdmin|允许用户向system.users集合写入，可以找指定数据库里创建、删除和管理用户
dbOwner|具有 readWrite、dbAdmin、userAdmin 角色的权限
clusterAdmin|只在admin数据库中可用，赋予用户所有分片和复制集相关函数的管理权限。
readAnyDatabase|只在admin数据库中可用，赋予用户所有数据库的读权限
readWriteAnyDatabase|只在admin数据库中可用，赋予用户所有数据库的读写权限
userAdminAnyDatabase|只在admin数据库中可用，赋予用户所有数据库的userAdmin权限
dbAdminAnyDatabase|只在admin数据库中可用，赋予用户所有数据库的dbAdmin权限。
root|只在admin数据库中可用。超级账号，超级权限


## 创建数据库
MongoDB 没有创建数据库的命令，`use 数据库名` 后创建集合 `db.createCollection('集合名')` 或插入数据 `db.COLLECTION_NAME.insert('文档')` 即可新建数据库（集合本身不需要创建，插入数据会自动创建）。  

ps：     
1. Mongdb shell 是 javascripte 环境，语句结束符`;`可省略；   
2. 数据库名全小写，最多64字节，不能是空字符串（"")，不得含有' '（空格)、.、$、/、\和\0 (空字符)；

## 集合操作
#### 创建集合
MongoDB 一般不需要显式创建集合，插入文档时会自动创建。需要创建特殊属性的集合时需要手动创建。      
集合创建命令：`db.createCollection(name, options)` name --> 数据库名；options --> 数据库属性。

options 可选属性：   

字段|类型|说明
:---:|:---:|:---:
capped | boolean | （可选）是否为固定集合。固定集合是指有着固定大小的集合，当达到最大值时，它会自动覆盖最早的文档。**默认为false；当该值为 true 时，必须指定 size 参数。**
autoIndexId | boolean | （可选）是否自动在 _id 字段创建索引。默认为 false。
size | 数值 | （可选）为固定集合指定一个最大值（字节）。
max | 数值 | （可选）指定固定集合中包含文档的最大数量。

*插入文档时，MongoDB 先检查固定集合的 size 字段，然后检查 max 字段。*

#### 删除集合
集合删除命令：
```
db.collectionName.drop() # collectionName 指集合名称
```
成功删除返回 `true` ,删除失败返回 `false` 。

## 文档操作
#### 插入文档
- 插入文档：`db.collectionName.insert(document)`;
- `db.collectionName.save(document)`,若 document 不指定 _id ，则执行插入操作；
- 3.2 版本后，新增两种插入方式
```
db.collectionName.insertOne(document)  # 向指定集合中插入一条文档数据
db.collectionName.insertMany([document,...])  # 向指定集合中插入多条文档数据
```

#### 更新文档
- `update()`方法更新文档，语法格式：
```
db.collectionName.update(
   <query>,
   <update>,
   {
     upsert: <boolean>,
     multi: <boolean>,
     writeConcern: <document>
   }
)
```

参数|解释
:--:|:--:
query | 查询条件，类似 sql 的 where 语句
update | 更新对象和一些操作符（如$,$inc...），类似 sql 的 set 语句
upsert | 可选，不存在记录时是否插入，默认 false
multi | 可选，是否更新所有符合条件的记录，默认 false 只更新第一条
writeConcern | 可选，抛出异常的级别

- `save()`方法更新文档，语法格式：
```
db.collectionName.save(document)
```
根据 document 的 `_id` 替换文档
- 3.2 版本后，新增两种更新方式
```
// 更新单个文档，类似 update() multi 参数为 false
db.collectionName.updateOne() 
// 更新多个文档，类似 update() multi 参数为 true
db.collectionName.updateMany() 向指定集合更新多个文档
```

#### 删除文档
- `remove()` 删除文档（已废弃），语法
```
db.collectionName.remove(
   <query>,// 删除条件
   {
     justOne: <boolean>,// 为 true 或 1 时只删除一个文档
     writeConcern: <document>
   }
)
```
- 推荐的删除方法
```
// 删除符合条件的第一条文档
db.collectionName.deleteOne( query )
// 删除符合条件的所有文档
db.collectionName.deleteMany( query )
```
- 清空集合    
`db.collectionName.deleteMany({})`

#### 查询文档
[MongoDb 文档查询][2]
[MongoDb 文档查询 II ][3]


[1]: https://raw.githubusercontent.com/tianqing2117/DailyProgress/master/image/MongoDB/mongoDB.png
[2]: https://github.com/tianqing2117/DailyProgress/blob/master/mongodb/MongoDB-Query.md
[3]: https://github.com/tianqing2117/DailyProgress/blob/master/mongodb/MongoDB-Query2.md

