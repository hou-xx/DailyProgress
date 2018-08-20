# ![Redis][1] Redis 学习笔记 II
> Redis是一个开源的使用ANSI C语言编写、遵守BSD协议、支持网络、可基于内存亦可持久化的日志型、Key-Value数据库，并提供多种语言的API 。

## Redis 数据类型
### String （字符串）
> String 是 redis 最基本的数据类型；
> String 类型是二进制安全的，可以包含任何数据，如jpg图片或者序列化的对象，最大存储 **512 MB** 。 
命令格式：
```
set key value
get key
```

示例：
```
127.0.0.1:6379> set author "houxx"
OK
127.0.0.1:6379> get author
"houxx"
```

### Hash（哈希）
> Hash 是一个 String 类型的 field 和 value 的映射表，特别适合用于存储对象;
> 每个 key 可以存储 232 -1 键值对（40多亿）。

命令格式：
```
hmset key field1 value1 [field2 value2 ...]
hmget key field1 [field2 ...]
```
示例：
```
127.0.0.1:6379> hmset user name houxx phone 13412341234 gender man
OK
127.0.0.1:6379> hmget user name phone
1) "houxx"
2) "13412341234"
```

### List（列表）
> List（列表）是简单的字符串列表（双向链表）;
> 按照插入顺序排序,可添加一个元素到列表的头部（左边）或者尾部（右边）。

命令格式：
```
lpush key value1 [value2 ...]
lrange key start stop
```
示例：
```
127.0.0.1:6379> lpush nameList houxx
(integer) 1
127.0.0.1:6379> lpush nameList wm
(integer) 2
127.0.0.1:6379> lpush nameList mls
(integer) 3
127.0.0.1:6379> lrange nameList 0 1
1) "mls"
2) "wm"
```




[1]: https://raw.githubusercontent.com/tianqing2117/DailyProgress/master/image/redis/redis2.png