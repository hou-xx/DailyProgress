# Tips ![like][1]

## [Gradle:productFlavors + buildTypes + signingConfigs 构建差异化 Android 应用][2]
## [JAVA 调用 matlab 程序 & 输入输出数据转换][3]
## [java 篇][4]
## ![mysql][12][mysql 篇][6]
## ![MongoDB][9] [MongoDB 学习篇][8]
## ![redis][13][redis 学习篇][14]
## [windows 版 charles 使用指南][7]
## [git 篇][10]
## [linux 篇][11]
## ![AirDroid ICON][16][安卓手机投影][15]
#### [win10 激活][5]

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

## Tomcat
tomcat 默认的 302 重定向是跳转到 80 端口（http），在 https 的请求过程中需要通过 tomcat 重定向时为保持重定向到 443 端口（https），需要修改 tomcat conf 目录下的 `server.xml`，在 对外的 Connector 里 添加
```
proxyPort="443"
scheme="https"
secure="true"
```
例如：
```
<Connector  port="8080" protocol="HTTP/1.1"
            proxyPort="443"
            scheme="https"
            secure="true"
            connectionTimeout="20000"
            redirectPort="8443" URIEncoding="utf-8" />
```

签名命令：
`jarsigner -verbose -keystore demo.jks -signedjar sign.apk unsign.apk alias
`

[1]:https://raw.githubusercontent.com/tianqing2117/DailyProgress/master/image/heart-hollow.png
[2]: https://github.com/tianqing2117/DailyProgress/blob/master/gradle-guide.md
[3]: https://github.com/tianqing2117/DailyProgress/blob/master/java-matlab.md
[4]: https://github.com/tianqing2117/DailyProgress/blob/master/java.md
[5]: https://github.com/tianqing2117/DailyProgress/blob/master/win10/active_win10.md
[6]: https://github.com/tianqing2117/DailyProgress/blob/master/mysql/mysql.md
[7]: https://github.com/tianqing2117/DailyProgress/blob/master/windows-charles.md
[8]: https://github.com/tianqing2117/DailyProgress/blob/master/mongodb/MongoDB.md
[9]: https://raw.githubusercontent.com/tianqing2117/DailyProgress/master/image/MongoDB/mongo-db.png
[10]: https://github.com/tianqing2117/DailyProgress/blob/master/git-merge.md
[11]: https://github.com/tianqing2117/DailyProgress/blob/master/linux.md
[12]: https://raw.githubusercontent.com/tianqing2117/DailyProgress/master/image/mysql/mysql.png
[13]: https://raw.githubusercontent.com/tianqing2117/DailyProgress/master/image/redis/redis.png
[14]: https://github.com/tianqing2117/DailyProgress/blob/master/redis/redis.md
[15]: https://github.com/tianqing2117/DailyProgress/blob/master/AirDroid.md
[16]: https://raw.githubusercontent.com/tianqing2117/DailyProgress/master/image/Airdroid/icon.png