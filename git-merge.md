## git 合并两个远程分支
#### 场景：
最初只有一个分支，随着业务发展，分化出不同的分支，分化出的分支又要合并最初分支的修改。

#### 实例：
github 上 fork 别人的项目，别人的项目有更新，自己 fork 的分支也有修改（不能删除后重新fork），需要合并原分支的修改（可能也是 merge 其他人的修改）。

#### 实验准备：
本机已安装好 git 命令行，且配置好 ssh 密钥，可以向自己的 gitbub 提交。

#### 实验材料：
分支地址：       

- `git@github.com:tianqing2117/flexbox-layout.git`  
自己的仓库地址，有 pull、push 的权限，最终也是更新到这个仓库；
- `https://github.com/google/flexbox-layout.git`        
fork 的原项目地址，有 pull 的权限；        

> 两年前 fork 了 google 的项目，google 这两年持续在更新这个项目，一直没有合并 google 的更新。          

![更新前，自己仓库的状态][1]
<br/>
![更新前，google 仓库的状态][2]

### 操作步骤

1. 本地 clone 自己的远程仓库             
```
git clone git@github.com:tianqing2117/flexbox-layout.git
```
clone 后需要 cd 到 flexbox-layout 文件夹里才进入 git 项目目录。
2. 添加原项目地址为远程仓库地址
```
git remote add google git@github.com:google/flexbox-layout.git
```
这里给这个远程仓库地址起名叫 google
3. 新建本地分支接受 google 仓库地址的内容
```
git checkout -b tmp
```
这里创建了一个本地分支叫 tmp ，并切换过去了
4. 从 google 远程分支更新修改到 本地 tmp 分支 
```
git pull google master:tmp
```
这里把 google 远程仓库的修改同步到了本地 tmp 分支
5. 切换回本地 master 分支
```
git checkout master
```
6. 从本地 tmp 分支合并修改到 master 分支
```
git merge tmp
```
7. 提交变更到自己的远程仓库
```
git push origin master
```

#### 实验结果

![更新后自己远程仓库][3]







[1]:https://raw.githubusercontent.com/tianqing2117/DailyProgress/master/image/git/mine-before.png
[2]: https://raw.githubusercontent.com/tianqing2117/DailyProgress/master/image/git/google.png
[3]: https://raw.githubusercontent.com/tianqing2117/DailyProgress/master/image/git/mine-after.png