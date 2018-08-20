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
> 每个 key 可以存储 2^32 -1 键值对（40多亿）。

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
> List（列表）是 String 类型类型的有序列表（双向链表）;
> 按照插入顺序排序,可添加一个元素到列表的头部（左边）或者尾部（右边）；
> 最多可存储 2^32 - 1 元素 。

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

### Set（集合）
> Set（集合）是 String 类型的无序集合（哈希表）;
> 元素不能重复，添加，删除，查找的复杂度都是 O(1)；
> 最多可存储 2^32 - 1 元素 。

命令格式：
```
sadd key mermber1 [mermber2 ...]
smembers key
```
示例：
```
127.0.0.1:6379> sadd dateList 20180820 20180821
(integer) 2
127.0.0.1:6379> smembers dateList
1) "20180820"
2) "20180821"
```

### zset(有序集合)
> 类似 set ，String 类型的集合，mermber 不可重复；
> 每个元素都会关联一个double类型的分数，通过分数从小到大排序；
> 成员是唯一的，但分数(score)却可以重复。

命令格式：
```
zadd key score member 
zrange key start stop
```
示例：
```
127.0.0.1:6379> zadd ageName 18 houxx
(integer) 1
127.0.0.1:6379> zadd ageName 16 wm 17 mls
(integer) 2
127.0.0.1:6379> zcard ageName
(integer) 3
127.0.0.1:6379> zrange ageName 0 1
1) "wm"
2) "mls"
```


[1]: https://raw.githubusercontent.com/tianqing2117/DailyProgress/master/image/redis/redis2.png