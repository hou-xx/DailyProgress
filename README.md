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
- **javascript**      
**Date对象**    
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
**forEach**   
js数组forEach方法无法使用break/return 跳出循环。
- **css计算width、height需要减去margin、padding**     
如果没有减去（比如同时写了width 100%和padding，在手机上宽度就会超过一屏而错动）   
- **ES6 箭头函数**    
箭头函数 能写出漂亮的匿名函数 ，很适合于微信小程序开发。不过，箭头函数里的 this 句柄 指向调用者，生命周期的函数如果需要使用this 不能使用箭头函数。
- **微信小程序**     
{{}} 会先于页面渲染 执行，image标签 src中链接可以部分是计算出来然后拼接的    
target指代 触发事件的源组件；currentTarget指代 事件绑定的当前组件。 在外层view绑定的事件 想要响应内层view的事件 必须使用currentTarget才能正常得到传递的数据


