## 索引
#### createIndex() 
用途：创建索引                 
语法：
```
db.collectionName.createIndex(keys, options);
// keys ：创建索引的字段
// options：可选，索引参数
```
示例：
```
// 在`product`文档，对 `name` 字段升序创建索引
db.product.createIndex({'name':1});
// 在`product`文档，对 `name` 字段升序 `type` 字段降序 创建复合索引
db.product.createIndex({'name':1,'type':-1});
```
##### options 可选参数
|参数名|取值类型|参数含义|
|:--:|:--:|:--:|
|background|Boolean|建索引过程会阻塞其它数据库操作，background可指定以后台方式创建索引，默认为false|
|name|string|索引的名称。如果未指定，MongoDB的通过连接索引的字段名和排序顺序生成一个索引名称。|
|unique|Boolean|建立的索引是否唯一，指定为true创建唯一索引，默认为false。|
|dropDups|Boolean|在建立唯一索引时是否删除重复记录。默认值为 false。|
|sparse|Boolean|对文档中不存在的字段数据不启用索引；这个参数需要特别注意，如果设置为true的话，在索引字段中不会查询出不包含对应字段的文档.。默认值为 false。|
|expireAfterSeconds|integer|指定一个以秒为单位的数值，完成 TTL设定，设定集合的生存时间。|
|weights|document|索引权重值，数值在 1 到 99,999 之间，表示该索引相对于其他索引字段的得分权重。|
|default_language|string|对于文本索引，该参数决定了停用词及词干和词器的规则的列表。 默认为英语。|
|language_override|string|对于文本索引，该参数指定了包含在文档中的字段名，语言覆盖默认的language，默认值为 language。|

示例：
```
// 创建索引
> db.product.createIndex({'name':1});
{
        "createdCollectionAutomatically" : false,
        "numIndexesBefore" : 1,
        "numIndexesAfter" : 2,
        "ok" : 1
}
> db.product.createIndex({'name':1,'type':-1});
{
        "createdCollectionAutomatically" : false,
        "numIndexesBefore" : 2,
        "numIndexesAfter" : 3,
        "ok" : 1
}
```