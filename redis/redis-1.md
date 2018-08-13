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
1. 下载后，解压至安装目录，如`tar -zxvf redis-4.0.11.tar.gz redis-4.0.11/`；
2. cd 至安装目录，执行 make 命令；   
```
cd redis-4.0.11/
make
```
3. make 后在 src 目录下会生成 redis-server（服务端） 和 redis-cli（客户端）程序； 
4. cd 到 src 目录，`./redis-server` 即可启动服务，若要指定启动配置可 `./redis-server ../redis.conf`

### Mac 版
下载地址：`http://redis.io/download`  
1. 下载后解压，进入解压目录；
2. `sudo make test` 测试编译;
3. `sudo make install ` 安装。         
ps: 仅用于测试。

## Redis 参数配置
conf 文件路径：安装目录下 redis.conf 文件（Linux）；安装目录下 redis.windows.conf 文件（Windows）。      
### 查看配置
连接后，`CONFIG GET configName` 可查看配置；      
`CONFIG GET *` 查看所有配置。  
```
10.96.5.4:6379> CONFIG GET dir
1) "dir"
2) "/home/redis/redis"
```

### 修改配置
1. 修改配置文件；
2. 连接后，命令修改配置。
`CONFIG SET configName value` 修改指定配置。
```
10.96.5.4:6379> config set loglevel debug
OK
10.96.5.4:6379> config get loglevel
1) "loglevel"
2) "debug"
```

### 常见参数

|参数名|说明|可选值|
|:--:|:--:|:--:|
|daemonize|是否以守护进程的方式运行|yes\no 默认 no|







[1]: https://raw.githubusercontent.com/tianqing2117/DailyProgress/master/image/redis/redis2.png