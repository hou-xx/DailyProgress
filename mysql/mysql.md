# ![mysql][1] Mysql 笔记
## 命令行启动本地mysql
```
mysqld --defaults-file="E:\Software\mysql-5.7.20-winx64\my.ini" --console 
```
- 其中 defaults-file 指定配置文件位置
- console 指定输出日志到命令行
- 如果安装 mysql 没有把 bin 目录配置到环境变量，mysqld 需要是全路径
- `--skip-grant-tables` 可指定跳过密码验证，用于忘记root密码时重置密码

## 命令行执行 sql 文件
1. `mysql -h主机地址 –u用户名 –p密码 –D数据库<sql脚本路径全名`
    <br>指定地址、用户、数据库和sql脚本；
2. `mysql -h主机地址 –u用户名 –p`
    <br>登录后，`use 数据库名；`
    <br>`source sql脚本路径` 指定sql脚本位置。

## 创建数据库、用户及分配权限

```
CREATE DATABASE IF NOT EXISTS `demodb` DEFAULT CHARACTER SET gbk COLLATE gbk_chinese_ci;
grant usage,select on `demodb`.* to 'demodbcxwh'@'%' identified by 'demodbcxwh';
GRANT ALL PRIVILEGES on `demodb`.* to 'demodbadmin'@'%' identified by 'demodbadmin';
grant usage,select,insert,update,delete on `demodb`.* to 'demodbuser'@'%' identified by 'demodbuser';
```
> DEFAULT CHARACTER SET gbk COLLATE gbk_chinese_ci 是设置数据库字符集和排序方式；
> grant 是授予权限；
> identified by 是指定密码。

## mysqldump 命令
语法
```
mysqldump [OPTIONS] database [tables]   //到处指定数据库的指定表
mysqldump [OPTIONS] --databases [OPTIONS] DB1 [DB2 DB3...] //导出指定的数据库们
mysqldump [OPTIONS] --all-databases [OPTIONS]   //导出所有的数据库
```
示例
1. 导出所有的数据库到文件
```
mysqldump -u用户名 -p密码 --all-databases >/tmp/all.sql
```
`/tmp/all.sql` 是指导出到的文件；            
2. 导出指定数据库的内容到文件
```
mysqldump -u用户名 -p密码 --databases db1 db2 >/tmp/db.sql
```
`db1`、 `db2` 是指定要导出的数据库名， `/tmp/db.sql` 是导出的文件路径；           
3. 导出制定数据库的指定表
```
mysqldump -u用户名 -p密码 --databases db1 --tables a1 a2  >/tmp/db.sql
```
`db1` 是指定要导出的数据库名，`a1` 、 `a2` 是指定要导出的表名， `/tmp/db.sql` 是导出的文件路径；     

> 导出的 sql 文件在导入时，对数据库会判断是否存在，不存在则新建，存在则使用；对表会删除重建再插入数据。
> 尽量显式指定字符集 "--default-character-set=utf8" ，避免导出文件无法使用
> `-- single-transaction`指定在一个事务中备份数据，保证数据一致性和完整性;
> `--lock-tables` 指定在备份过程中锁定表，只允许查询不允许修改，但每次只锁定一个数据库的表，需要同时备份多个数据库时，使用`--lock-all-tables`
> `--no-data`仅仅dump 数据库结构创建脚本;`
> `--no-create-info` 去掉 dump 文件中创建表结构的命令;
> `--ignor-table=表名` 忽略部分表（忽略多个表则写多个`--ignor-table=表名` ）


## mysqlbinlog 命令
> Mysql的binlog日志作用是用来记录mysql内部增删改查等对mysql数据库有更新的内容的记录（对数据库的改动），对数据库的查询select或show等不会被binlog日志记录;主要用于数据库的主从复制以及增量恢复。


## mysql 权限控制
MySQL 的相关权限信息主要存储在几个被称为grant tables 的系统表中，即： mysql.User，mysql.db，mysql.Host，mysql.table_priv 和 mysql.column_priv。由于权限信息数据量比较小，而且访问又非常频繁，所以Mysql 在启
动的时候，就会将所有的权限信息都Load 到内存中保存在几个特定的结构中。我
们每次手工修改了权限相关的表之后，都需要执行“FLUSH PRIVILEGES”命令重新加载MySQL
的权限信息。    
一般情况下尽量使用GRANT，REVOKE，CREATE USER 以及DROP
USER 命令来进行用户和权限的变更操作（不需要手工执行FLUSH PRIVILEGES 命令），尽量减少直接修改grant tables 来实现用户和权
限变更的操作。

### 查询用户权限
```
SHOW GRANTS FOR 'username'@'hostname'
```

### 授予权限
```
GRANT 权限1，权限2… ON 数据库名.表名 TO 'username1'@'hostname1','username2'@'hostname3'
//例如：
GRANT SELECT, INSERT, UPDATE, DELETE ON *.* TO 'def'@'localhost'
GRANT ALTER ON `test`.* TO 'def'@'localhost'
//*.* 是指全局;'databaseName'.* 是指指定数据库全库
//ALL PRIVILEGES 指代全部权限
//% 作 hostname 代表允许所有，但localhost 不包括在内（指定 -h 127.0.0.1 则支持）
```


[1]: https://raw.githubusercontent.com/tianqing2117/DailyProgress/master/image/mysql/mysql2.png
