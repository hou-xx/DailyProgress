# ![Redis][1] Redis 学习笔记
> Redis是一个开源的使用ANSI C语言编写、遵守BSD协议、支持网络、可基于内存亦可持久化的日志型、Key-Value数据库，并提供多种语言的API 。

## 安装 Redis
### Windows 版
下载地址：`https://github.com/MSOpenTech/redis/releases`     
解压后，命令行 cd 到安装目录，执行`redis-server.exe redis.windows.conf ` 启动即可服务；        
另一命令行 cd 到安装目录，执行`redis-cli.exe -h 127.0.0.1 -p 6379` 即可连接数据库 。     
PS：
1. 添加至环境变量则不必再 cd 至安装目录，但制定 conf 文件需要是全路径；   
2. redis 官方并不支持windows。这里仅作为测试使用，生产应使用 Linux 环境。

```
C:\Users\tal>redis-cli.exe -h 127.0.0.1 -p 6379
127.0.0.1:6379> set abc 123
OK
127.0.0.1:6379> get abc
"123"
127.0.0.1:6379>
```

### Linux 版
下载地址：`http://redis.io/download`











[1]: https://raw.githubusercontent.com/tianqing2117/DailyProgress/master/image/redis/redis2.png