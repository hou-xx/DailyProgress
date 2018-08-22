# ![Redis][1] Redis 学习笔记 III
> Redis是一个开源的使用ANSI C语言编写、遵守BSD协议、支持网络、可基于内存亦可持久化的日志型、Key-Value数据库，并提供多种语言的API 。

## key（键）操作
命令(key代表键名)|作用|说明
:--:|:--:|:--:
del key|key 存在时删除 key|返回数字代表受影响记录数
dump key|序列化 key 对应的值|返回序列化结果
exists key|检查 key 是否存在|


[1]: https://raw.githubusercontent.com/tianqing2117/DailyProgress/master/image/redis/redis2.png