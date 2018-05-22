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
    指定地址、用户、数据库和sql脚本；
2. `mysql -h主机地址 –u用户名 –p`
    登录后，`use 数据库名；`
    `source sql脚本路径` 制定sql脚本位置。
