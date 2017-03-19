# Tips

-  **Fragment**    
fragment可以接受onActivityResult 只需要所附着的Activity专递给它即可，比如拍照结果
- **view**    
自定义View有生命周期 可以在生命周期做相应逻辑 ，比如组合控件的数据存储
- **ImageView**    
setImageResource、setImageBitmap、setImageDrawable；
代码中设置drawable相当于src；bitmap相当于background 。
background会放大，而src受scrollType影响。
- **Android字体**    
android默认字体是冬青黑体，与微软雅黑相似。也可以把字体ttf文件打包到asset中使用typeface设置自定义的字体。
- **倒计时 countdowntimer**    
JAVA提供CountDownTimer类能非常方便的实现倒计时
- **javascript Date对象**     
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