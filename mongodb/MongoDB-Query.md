## 文档查询
语法：
```
db.collectionName.find(query, projection);
//query ：可选，使用查询操作符指定查询条件
//projection：可选，使用投影操作符指定返回的键。
//默认省略，返回文档中所有键值。

//查询单条记录
db.collectionName.findOne(query, projection);
```

> pretty() 方法可将结果格式化为可读模式

```
db.collectionName.find(query, projection).pretty();
```
#### query 条件
##### 字段比较
|操作|格式|示例|类比RDBMS|
|:----:|:----:|:----:|:---:|
|等于|{key:value}|{"CONTENT":"1"}|where CONTENT = '1'|
|小于|{key:{$lt:value}}|{"money":{$lt:50}}|where money < 50|
|小于或等于|{key:{$lte:value}}|{"money":{$lte:50}}|where money <= 50|
|大于|{key:{$gt:value}}|{"money":{$gt:50}}|where money > 50|
|大于或等于|{key:{$gte:value}}   |{"money":{$gte:50}}|where money >= 50|
|不等于|{key:{$ne:value}}|{"money":{$ne:50}}|where money != 50|
|类型匹配|{key:{$type:value}}|{"money":{$type:1}}|--|


##### AND 条件
格式：
```
{key1:value1, key2:value2}
//示例 db.demo.find({"AUTOR" : "houxx","CONTENT" : "1"}).pretty();
```

##### OR 条件
格式：
```
{$or: [{key1: value1}, {key2:value2}]}
//示例 
db.demo.find({$or: [{"CONTENT" : "1"}, {"CONTENT" : "2"}]},{_id:0}).pretty();
```

##### 条件组合
直接把各个条件组合使用即可
示例：
```
//AUTOR 为 houxx ，且 money 的值等于1或大于2
db.demo.find({{"AUTOR":"houxx"},{$or: [{"money":1},{"money":{$gt:2}}]}},{_id:0}).pretty();
```

#### projection 条件
格式：
```
{字段名1:1,字段名2:1} // inclusion 模式，返回指定字段
{字段名1:0,字段名2:0} // exclusion 模式，指定字段不返回
//_id 键默认返回，需要主动指定 _id:0 才会隐藏
//两种模式不能混用，全 1 或全 0
```

#### $type 类型匹配
##### $type 取值
|value|类型|
|:----:|:----:|
|1|Double|
|2|String|
|3|Object|
|4|Array|
|5|Binary data|
|6|Undefined（已废弃）|
|7|Object id|
|8|Boolean|
|9|Date|
|10|Null|
|11|Regular Expression|
|13|JavaScript|
|14|Symbol|
|15|JavaScript (with scope)|
|16|32-bit integer|
|17|Timestamp|
|18|64-bit integer|
|255|Min key（写作 -1）|
|127|Max key|

示例：
```
//插入测试数据
> db.demo.insertMany([{"CONTENT":"1","AUTOR":"houxx"},{"CONTENT":"2","AUTOR":"houxx"},{"CONTENT":"1","AUTOR":"houxx"},{},{"CONTENT":"3","AUTOR":"houxx"}]);
{
        "acknowledged" : true,
        "insertedIds" : [
                ObjectId("5b26327f2afff603f6bd2ca5"),
                ObjectId("5b26327f2afff603f6bd2ca6"),
                ObjectId("5b26327f2afff603f6bd2ca7"),
                ObjectId("5b26327f2afff603f6bd2ca8"),
                ObjectId("5b26327f2afff603f6bd2ca9")
        ]
}
//直接查找所有
> db.demo.find();
{ "_id" : ObjectId("5b26327f2afff603f6bd2ca5"), "CONTENT" : "1", "AUTOR" : "houxx" }
{ "_id" : ObjectId("5b26327f2afff603f6bd2ca6"), "CONTENT" : "2", "AUTOR" : "houxx" }
{ "_id" : ObjectId("5b26327f2afff603f6bd2ca7"), "CONTENT" : "1", "AUTOR" : "houxx" }
{ "_id" : ObjectId("5b26327f2afff603f6bd2ca8") }
{ "_id" : ObjectId("5b26327f2afff603f6bd2ca9"), "CONTENT" : "3", "AUTOR" : "houxx" }
//查找所有格式化输出
> db.demo.find().pretty();
{
        "_id" : ObjectId("5b26327f2afff603f6bd2ca5"),
        "CONTENT" : "1",
        "AUTOR" : "houxx"
}
{
        "_id" : ObjectId("5b26327f2afff603f6bd2ca6"),
        "CONTENT" : "2",
        "AUTOR" : "houxx"
}
{
        "_id" : ObjectId("5b26327f2afff603f6bd2ca7"),
        "CONTENT" : "1",
        "AUTOR" : "houxx"
}
{ "_id" : ObjectId("5b26327f2afff603f6bd2ca8") }
{
        "_id" : ObjectId("5b26327f2afff603f6bd2ca9"),
        "CONTENT" : "3",
        "AUTOR" : "houxx"
}
//指定 _id 不返回
> db.demo.find({},{_id:0});
{ "CONTENT" : "1", "AUTOR" : "houxx" }
{ "CONTENT" : "2", "AUTOR" : "houxx" }
{ "CONTENT" : "1", "AUTOR" : "houxx" }
{  }
{ "CONTENT" : "3", "AUTOR" : "houxx" }
// AND 条件示例
> db.demo.find({"AUTOR" : "houxx","CONTENT" : "1"}).pretty();
{
        "_id" : ObjectId("5b26327f2afff603f6bd2ca5"),
        "CONTENT" : "1",
        "AUTOR" : "houxx"
}
{
        "_id" : ObjectId("5b26327f2afff603f6bd2ca7"),
        "CONTENT" : "1",
        "AUTOR" : "houxx"
}

// OR 条件示例
> db.demo.find({$or: [{"CONTENT" : "1"}, {"CONTENT" : "2"}]},{_id:0}).pretty();
{ "CONTENT" : "1", "AUTOR" : "houxx" }
{ "CONTENT" : "2", "AUTOR" : "houxx" }
{ "CONTENT" : "1", "AUTOR" : "houxx" }

```