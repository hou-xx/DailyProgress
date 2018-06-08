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
grant usage,select,insert,update,delete on `demodb`.* to 'demodbuser'@'%' identified by 'demodbadmin';
```

## mysqldump 命令
语法
```
mysqldump [OPTIONS] database [tables]   //到处指定数据库的制定表
mysqldump [OPTIONS] --databases [OPTIONS] DB1 [DB2 DB3...] //导出指定的数据库们
mysqldump [OPTIONS] --all-databases [OPTIONS]   //导出所有的数据库
```