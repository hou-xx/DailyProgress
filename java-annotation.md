# java 注解（annotation）
Java 5.0 版本之后引入注解，至此就被广泛使用。

## 何为注解
什么是注解呢？简单说，注解就是描述数据的数据（Data that describes other data），即 **元数据**；     
就像注释一样，注解也能对源代码进行描述；除描述外注解还能实现对数据的分类；        
在元数据方面，XML 被大量使用（过去和现在，估计未来也是如此）。
XML 和注解的共同点：都只是描述性内容，**本身不具备任何业务处理能力**。
XML 和注解的不同点：XML 和代码是松耦合的；注解和代码在物理距离上更近（紧耦合）。
很多情况下，XML 配置其实就是为了分离代码和配置而使用的。但有些场景，我们更希望与代码紧密结合。

## 最常见的两个 java 注解
- @Override
```
    @Override
    public String toString() {
        return super.toString();
    }
```
点进 `@Override` 后去掉注释是这样的：
```
package java.lang;

import java.lang.annotation.*;

@Target(ElementType.METHOD)
@Retention(RetentionPolicy.SOURCE)
public @interface Override {
}
```
这妥妥就是一个空的注解，没有属性！没有方法！  
但 @Override 注解本身就标识了其所标注的方法是
