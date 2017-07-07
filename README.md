# Tips ![like][1]

## Android

-  **Fragment**    
fragment可以接受onActivityResult 只需要所附着的Activity专递给它即可，比如拍照结果
- **view**    
自定义View有生命周期 可以在生命周期做相应逻辑 ，比如组合控件的数据存储
- **ImageView**    
setImageResource、setImageBitmap、setImageDrawable；
代码中设置drawable相当于src；bitmap相当于background 。
background会放大，而src受scrollType影响。
- **状态栏**    
6.0+手机上沉浸式状态栏后若为白色背景 状态栏会出现灰框 可调整状态栏颜色为黑色
```
if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M){
            getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR| View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN);
        }
```
- **Android字体**    
android默认字体是冬青黑体，与微软雅黑相似。也可以把字体ttf文件打包到asset中使用typeface设置自定义的字体。
- **xutils 与 CircleImageView 冲突**   
使用xutils bindimageview时修改CircleImageView代码
```
 @Override 
 public ScaleType getScaleType() { return SCALE_TYPE; }
 
 
 @Override
 public void setScaleType(ScaleType scaleType) { return; } 
```
- **倒计时 countdowntimer**    
Android 提供 `CountDownTimer` 类能非常方便的实现倒计时
## JAVA

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

## javascript

- **forEach**   
js数组forEach方法无法使用break/return 跳出循环。
- **css计算width、height需要减去margin、padding**     
如果没有减去（比如同时写了width 100%和padding，在手机上宽度就会超过一屏而错动）   
- **ES6 箭头函数**    
箭头函数 能写出漂亮的匿名函数 ，很适合于微信小程序开发。不过，箭头函数里的 this 句柄 指向调用者，生命周期的函数（微信小程序）如果需要使用this 不能使用箭头函数。


## 微信小程序

-  {{}} 会先于页面渲染 执行，image标签 src中链接可以部分是计算出来然后拼接的    ;
-  target指代 触发事件的源组件；currentTarget指代 事件绑定的当前组件。 在外层view绑定的事件 想要响应内层view的事件 必须使用currentTarget才能正常得到传递的数据;
-  在App() 的生命周期中使用this，一定不要使用 getApp() 。此时通过getApp()获得的实例 无法访问全局数据（可能是尚未准备好），而this可以；
-  色值使用6位，使用8位色值控制颜色变淡 在android上有效，在IOS上会显示奇怪的颜色。
-  小程序修改窗口背景色，在json配置文件中设置窗口背景色在IOS上无效（页面背景未改边  弹跳效果展示该颜色），可以借助page标签实现。
```
page {
  display: block;
  min-height: 100%;
  background-color: #f4f4f4;
}
```

## kotlin

[1]:https://raw.githubusercontent.com/tianqing2117/DailyProgress/master/heart-hollow.png