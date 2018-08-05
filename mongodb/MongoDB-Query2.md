## 文档查询 II
### 分页查询
#### Limit() 
含义：读取指定数量的数据记录。
语法：
```
db.collectionName.find(query).limit(NUMBER);
//query ：可选，使用查询操作符指定查询条件
//NUMBER 限制查询的记录数
```
示例：
```
db.product.find().limit(2);
```
#### Skip()
含义：跳过指定数量的数据
语法：
```
db.collectionName.find(query).limit(NUMBER1).skip(NUMBER2);
//query ：可选，使用查询操作符指定查询条件
//NUMBER1 限制查询的记录数
//NUMBER2 指定跳过的记录数
```
示例：
```
db.product.find().limit(2).skip(2);
```

### 排序

#### sort() 
含义：指定字段进行排序
语法：
```
db.collectionName.find(query).sort({key:value});
//query ：可选，使用查询操作符指定查询条件
//key:排序的字段名
//value：排序方式 （1--> 升序； -1--> 降序）
```
示例：
```
db.product.find().limit(2).sort({type:1});
```


示例：
```
// 查询所有
> db.product.find().pretty();
{ "_id" : ObjectId("5b0a9577eeff060b14fe4025"), "name" : "一家亲" }
{ "_id" : ObjectId("5b0a961aeeff060b14fe4026"), "name" : "多利宝" }
{
        "_id" : ObjectId("5b13eb28e9229a0378cfdec1"),
        "name" : "aaa",
        "type" : "fund"
}
{
        "_id" : ObjectId("5b13eb52e9229a0378cfdec2"),
        "name" : "aaa",
        "type" : "fund"
}
{
        "_id" : ObjectId("5b13ebd6e9229a0378cfdec3"),
        "name" : "bbb",
        "type" : "deposit"
}
{
        "_id" : ObjectId("5b13ec0be9229a0378cfdec4"),
        "name" : "bbb",
        "type" : "deposit"
}
{
        "_id" : ObjectId("5b13ec0be9229a0378cfdec5"),
        "name" : "bbb",
        "type" : "deposit"
}
{
        "_id" : ObjectId("5b13ec0be9229a0378cfdec6"),
        "name" : "bbb",
        "type" : "deposit"
}
{ "_id" : ObjectId("5b65db1f6e6cee897db4b2b6"), "amount" : 100 }
{ "_id" : ObjectId("5b65db346e6cee897db4b2b7"), "amount" : 101 }

// 限制查询条数
> db.product.find().limit(2).pretty();
{ "_id" : ObjectId("5b0a9577eeff060b14fe4025"), "name" : "一家亲" }
{ "_id" : ObjectId("5b0a961aeeff060b14fe4026"), "name" : "多利宝" }

// 跳过指定条数
> db.product.find().limit(2).skip(2).pretty();
{
        "_id" : ObjectId("5b13eb28e9229a0378cfdec1"),
        "name" : "aaa",
        "type" : "fund"
}
{
        "_id" : ObjectId("5b13eb52e9229a0378cfdec2"),
        "name" : "aaa",
        "type" : "fund"
}

// 排序（按照 type 降序排列）
> db.product.find().limit(3).sort({type:-1}).pretty();
{
        "_id" : ObjectId("5b13eb28e9229a0378cfdec1"),
        "name" : "aaa",
        "type" : "fund"
}
{
        "_id" : ObjectId("5b13eb52e9229a0378cfdec2"),
        "name" : "aaa",
        "type" : "fund"
}
{
        "_id" : ObjectId("5b13ebd6e9229a0378cfdec3"),
        "name" : "bbb",
        "type" : "deposit"
}
```