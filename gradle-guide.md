# productFlavors + buildTypes + signingConfigs 构建差异化 Android 应用
gradle 脚本作为 AndroidStudio 使用的打包控制语言，有其独特的优势。
##　常见功能
和其他脚本语言一样，gradle 脚本也支持实现常见的功能和操作
- `def` 定义变量和方法
```
def getConfigs(environment,fileName) {
    //断言变量不为空
    assert environment!=null
    assert fileName!=null
    Properties props = new Properties()
    //加载文件内容为 Properties，方便使用
    props.load(new FileInputStream(file("conf/$environment/$fileName")))
    return props
}
```
- `${}` 引用变量
- `ext` 暴露变量（或方法）
-  引入其他脚本文件 
```
apply from: "${rootProject.projectDir}/dependency/dependency.gradle"
```
##　productFlavors　指定打包风味
- productFlavors　下可以新增　flavor　，每个　flavor　都可以覆盖defaultConfig下的属性实现差异化。如：包名、应用名、编译版本；
- flavor　里也可以执行脚本代码，实现特殊逻辑。
- productFlavors.all 的代码所有 flavor 都会执行
```
productFlavors.all{
            flavor ->
            ……
}
```
- buildConfigField 可以为 java 程序提供差异化的变量，在代码中借助
 BuildConfig 类得到这些变量。比如： `BuildConfig.FLAVOR` 的值是当前的
 flavor
- manifestPlaceholders 可以给清单文件里的变量赋值，清单文件里 `"${变量名}" `获取值。常用于包名传递，及不同 flavor 不同的第三方 key


```
android {
　　productFlavors {
　　　dev{
　　　}
　　　prod{
　　　}
　　　...............
    　productFlavors.all{
            flavor ->
                def props = getConfigs(name,'conf.properties')
                props.propertyNames().each { name ->
                    buildConfigField valueType(props.getProperty(name.toString())), name, props.getProperty(name.toString())
                }
                manifestPlaceholders = [
                        JPUSH_PKGNAME : "${applicationId}"                        
                ]
        }
　　}
}
```
## signingConfigs 签名配置
signingConfigs  用于声明签名配置，使用自定义配置前必须先定义
- signingConfigs  下可以定义多个签名配置供不同 falvor 和 buildType 使用
- 变量可以在项目根目录的 `gradle.properties` 文件定义，gradle 脚本直接按变量名使用即可

```
signingConfigs {
        demo{
            storeFile file(DEMO_STORE_FILE)
            storePassword DEMO_STORE_PASSWORD
            keyAlias DEMO_KEY_ALIAS
            keyPassword DEMO_KEY_PASSWORD
        }
       .......
    }
```
## buildTypes 打包配置
buildTypes 下可以制定多个打包方式，一般会有debug、release，可以指定不同的签名方式、混淆逻辑等
- 与 productFlavors 类似 applicationVariants.all 是所有配置都会执行的代码
- debug 打包方式不指定 signingConfig ，则使用默认签名（系统默认的签名证书）

```
    buildTypes {
        debug {
            minifyEnabled false
            zipAlignEnabled false
            shrinkResources false       
            signingConfig signingConfigs.debug    
        }
        release {
            //是否混淆
            minifyEnabled true
            zipAlignEnabled true
            // 移除无用的resource文件
            shrinkResources false
            proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
            signingConfig signingConfigs.release    
        }

        applicationVariants.all {
            variant ->
                variant.outputs.all {
                    outputFileName = "DEMO_${variant.name}_${variant.versionName}.apk"
                }
        }
    }

```

# 不同 flavor 使用不同签名配置
- 在 flavor 里指定 signingConfig （使用前先定义）就可以指定 release 包的签名配置，但对 debug 包无效
```
android {
　　productFlavors {
　　　dev{
                signingConfig signingConfigs.dev
　　　}
　　　prod{
                signingConfig signingConfigs.prod
　　　}
　　　...............
      ｝
}
```
- 如果想 debug 包也使用不同的签名配置，可以显示的指定 debug 使用release 的签名配置
```
    buildTypes {
        debug {
            // 指定 debug 使用release的签名
            signingConfig release.signingConfig
        }
        release {
        }
    }
```
这样就可以完成 gradle 脚本控制不同 flavor 使用不同的签名
