# love

#1、Fragment
  fragment可以接受onActivityResult 只需要所附着的Activity专递给它即可，比如拍照结果
#2、view
自定义View有生命周期 可以在生命周期做相应逻辑 ，比如组合控件的数据存储
#3、ImageView
setImageResource、setImageBitmap、setImageDrawable；
代码中设置drawable相当于src；bitmap相当于background 。
background会放大，而src受scrollType影响。
#4、Android字体
android默认字体是冬青黑体，与微软雅黑相似。也可以把字体ttf文件打包到asset中使用typeface设置自定义的字体。
countdowntimer
