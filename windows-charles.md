# 为什么使用 charles-windows
在实际开发、测试中需要通过代理截取 app 的网络请求报文来快速定位问题。https 双向认证的 app 越来越多，fiddler在这方面并不好用。由于开发、测试的同学使用 windows 系统较多，所以编写此文档作为 Windows 版 charles 使用指南。

# 所需材料
- Windows 系统电脑
- 手机 （android 或 ios ，本文以 android 系统手机为例）

# 安装配置步骤

## 1.安装 windows 版charles

官网下载地址：
` https://www.charlesproxy.com/download/ `

本文使用为4.1.4版本（最新版），下载地址： 

> https://www.charlesproxy.com/assets/release/4.1.4/charles-proxy-4.1.4-win64.msi

下载后，双击，选择软件保存目录安装即可。

## 2. 配置 windows 版charles
### 2.1 设置不代理计算机的请求（**推荐**）
proxy -> windows proxy   （勾选则抓取计算机的请求）    
  proxy -> Mozilla Firefox proxy （勾选则抓取计算机上 Mozilla、Firefox浏览器的请求）    
  对 app 进行数据抓取的场景，这两项  **不勾选**  。  

### 2.2 设置代理 https 请求并添加证书
proxy -> SSL Proxy Settings 弹出一个 ssl代理设置界面    
    1). Enable SSL Proxying **复选框打勾**    
    2).添加你想要的设置代理的域名,端口默认 443    
    3).添加域名的证书,端口默认 443,选择证书文件（双向认证必须添加证书）    
    ![charles1][1]    
    ![charles2][charles2] 

### 2.3 关心域名重点显示（可选）
View -> Foucused Hosts 用于设置重点关心域名，在列表中会独立显示    
![charles3][charles3]

### 2.4 安装 charles 根证书
Help -> ssl proxy -> Install Charles Root Certificate 
    跳转至系统证书安装流程 安装 charles 根证书

### 2.5 查看手机所需配置
Help -> ssl proxy -> Install Charles Root Certificate on a Moblie Device or Remote Browser    
![charles5][charles5]    
弹窗提示 [手机的配置](/Systems/GAP/Charles-Windows#手机设置/)    
![charles4][charles4]

## 3.手机设置
1、 手机连上同一网段的网络，设置代理。    
2、 手机浏览器（android 手机使用系统浏览器）访问 chls.pro/ssl 安装证书    

## 开始使用
打开 app 即可开始抓取网络通讯，界面如下：
![charles6][charles6]


ps:  

1. 手机连上代理是时，Charlescharles 会弹窗提醒是否允许，同意即可；
2. https 双向认证的抓包需要有该域名的证书文件（.p12文件）；     
3. 第一个抓取的请求会要求输入证书密码，输入密码保存即可，输入密码后如果解析不了请求内容重启 charles 即可；    
4. charles 为收费软件，免费版会有限制（比如：开启时等待 10s 、使用半个小时后提示重启）。    














[1]:http://upload-images.jianshu.io/upload_images/4669070-3637cb8819f00840.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240
[charles2]:http://upload-images.jianshu.io/upload_images/4669070-490375f2da1995bf.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240
[charles3]:http://upload-images.jianshu.io/upload_images/4669070-de2607de354822f0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240
[charles4]:http://upload-images.jianshu.io/upload_images/4669070-2ffc33d1b3e0d487.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240
[charles5]:http://upload-images.jianshu.io/upload_images/4669070-440488d3646855b9.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240
[charles6]:http://upload-images.jianshu.io/upload_images/4669070-92210e2f19ab66ab.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240