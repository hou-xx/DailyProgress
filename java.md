
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

- 数字格式化
```
// BigDecimal 指定格式格式化为字符串
String result = new DecimalFormat(pattern).format(bigDecimal);
//pattern 为 正则表达式 如 "#.00" 、 "0.00"
```
`#` 和 `0` 的区别
DecimalFormat 类主要靠 # 和 0 两种占位符号来指定数字长度。0 表示如果位数不足则以 0 填充，# 表示只要有可能就把数字拉上这个位置。           
例如：
```
new DecimalFormat("#.00").format(new BigDecimal("0.3456")) --> .35
new DecimalFormat("0.00").format(new BigDecimal("0.3456")) --> 0.35
```

- utils       
  
[数字金额转大写汉字][1]

- springBoot RestTemplate
> 正常配置 RestTemplate

```
    @Bean
    RestTemplate restTemplate() throws KeyStoreException, NoSuchAlgorithmException, KeyManagementException {
        SimpleClientHttpRequestFactory requestFactory = new SimpleClientHttpRequestFactory();
        requestFactory.setConnectTimeout(1000);
        requestFactory.setReadTimeout(1000);
        return new RestTemplate(requestFactory);
    }
```

> 配置 RestTemplate 忽略证书错误

```
     @Bean
    RestTemplate restTemplate() throws KeyStoreException, NoSuchAlgorithmException, KeyManagementException {
        TrustStrategy acceptingTrustStrategy = (X509Certificate[] chain, String authType) -> true;
        SSLContext sslContext = org.apache.http.ssl.SSLContexts.custom()
                .loadTrustMaterial(null, acceptingTrustStrategy)
                .build();

        SSLConnectionSocketFactory csf = new SSLConnectionSocketFactory(sslContext);

        CloseableHttpClient httpClient = HttpClients.custom()
                .setSSLSocketFactory(csf)
                .build();
        HttpComponentsClientHttpRequestFactory requestFactory =
                new HttpComponentsClientHttpRequestFactory();
        requestFactory.setHttpClient(httpClient);
        RestTemplate restTemplate = new RestTemplate(requestFactory);
        return restTemplate;
    }
```

> 使用时

```
    @Autowired
    private RestTemplate restTemplate;

    // post
    restTemplate.postForObject(url, order, Object.class);
    //get
    restTemplate.getForObject(url, EsignDownLoadResult.class);
```

- spring restful
 使用 spring (或 springboot ) 注解开放 rest 接口时， post 请求需要使用 `@ResponseBody` 注解标注方法。否则接口到达后端正常处理后， 浏览器收到 404 ，无法收到返回。



[1]:https://github.com/tianqing2117/DailyProgress/blob/master/utils/MoneyUtils.java

