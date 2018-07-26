
- **Date对象**    
new Date(year,month,day) 时, year 是当前年减去 1900 ; month 从 0 计数。    
getDay 获取的是星期几， *getDate才是当月日期* ；getMonth 月份从0开始 ^v^
```
var now = new Date();
now; // Wed Jun 24 2015 19:49:22 GMT+0800 (CST)
now.getFullYear(); // 2015, 年份
now.getMonth(); // 5, 月份，注意月份范围是0~11，5表示六月
now.getDate(); // 24, 表示24号
now.getDay(); // 3, 表示星期三
now.getHours(); // 19, 24小时制
now.getMinutes(); // 49, 分钟
now.getSeconds(); // 22, 秒
now.getMilliseconds(); // 875, 毫秒数
now.getTime(); // 1435146562875, 以number形式表示的时间戳
```
- **Exception**  
Exception 的 getMessage 方法得到的有可能是 null ，比如空指针等运行时异常

- **hibernate**

> 使用 spring-hibernate 时 model 的包名在 AnnotationSessionFactoryBean 的 *packagesToScan* 属性指定，多个包名以 *,* 分割。不包含在内的话，无法操作对应的表。

> 使用 hibernate 的 *Query* 更新表时，datatime 类型的字段应用 **setTimestamp** 赋值，`setData` 会损失时间（只剩下日期）。

- spring AOP
    + 使用 XML 配制的 AOP advice 的 pointcut expression 用 `and`,`or`,`not` 取代`&&`,`||`,`not`；     
    + expression 的 this(interface_name) 和 `or` 连接时，被排除类的自有方法和继承且实现（可以是直接调用父类的空实现）的方法有效，父类方法无效。     

- utils       
  
[数字金额转大写汉字][1]

[1]:https://github.com/tianqing2117/DailyProgress/blob/master/utils/MoneyUtils.java

