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
但 `Override` 这个单词的中文翻译就是`覆盖`，@Override 注解标识了其所标注的方法是在其父类或者其实现的接口中声明的。被 @Override 标注的方法是覆盖或实现已经被声明过的方法。      
既然，本身不具备任何业务处理能力，那 @Override 又是如何起效的呢？      
对于 @Override 来说，是编译器在检查所有背其标注的方法，检查父类或者实现的接口里是否有该方法的声明。若不存在，则编译器报错，提醒错误。

- @Deprecated   
@Deprecated 是长成这样子的：
```
package java.lang;

import java.lang.annotation.*;
import static java.lang.annotation.ElementType.*;

@Documented
@Retention(RetentionPolicy.RUNTIME)
@Target(value={CONSTRUCTOR, FIELD, LOCAL_VARIABLE, METHOD, PACKAGE, PARAMETER, TYPE})
public @interface Deprecated {
}
```
没错！这还是一个空注解。        
程序员使用这个注解是提醒调用者，被其标注的方法是不安全的或者有更好替代方案的，是被废弃的。调用方若使用了被 @Deprecated 标注的方法，在编译时会收到一个警告。

## 如何创建一个自定义注解
还是直接端上两个自定义注解再解释吧     
只有一个属性的自定义注解
```
package com.hxx.annotation;

import java.lang.annotation.*;

@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.TYPE)
public @interface Author {
    String value();
}
```
多个属性的自定义注解
```
package com.hxx.annotation;

import com.hxx.enums.UserType;

import java.lang.annotation.*;

@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.METHOD)
public @interface AnnotationDemo {
    long time() default 0;

    int count() default 0;

    String name() default "XiaoMing";

    UserType userType() default UserType.SYSTEM_ADMIN;

}
```
其中，`UserType` 是一个枚举
```
package com.hxx.enums;

public enum UserType {
    SYSTEM_ADMIN("系统管理员"),
    TOURISTS("游客");
    private String description;

    UserType(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }
}
```


### 元注解（专门注解其他注解的注解）
J2SE5.0版本在 java.lang.annotation 提供了四种元注解：   

|注解名|注解含义|
|:---:|:---:|
|@Documented|注解是否将包含在 JavaDoc 中|
|@Retention|注解的生命周期|
|@Target|注解能被用在什么地方|
|@Inherited|是否子类允许继承该注解|

#### @Documented
被 @Documented 标注的注解，注解信息会被添加在 JavaDoc 中

#### @Retention
@Retention 定义了其标记注解的生命周期。       
可选的值有：      
- RetentionPolicy.SOURCE        
在编译阶段丢弃，只作用于编译阶段，不会写入字节码。比如：@Override, @SuppressWarnings。       
- RetentionPolicy.CLASS         
在类加载的时候丢弃，字节码文件的处理中有用。**注解默认使用这种方式**        
- RetentionPolicy.RUNTIME       
始终不会丢弃，运行期也保留该注解，因此可以使用反射机制读取该注解的信息。**自定义注解时常用**        

#### @Target
@Target 表示该注解用于什么地方。如果不明确指出，该注解可以放在任何地方。      
可选的值有：  

|值|描述场景|
|:--:|:--:|
|ElementType.TYPE|类、接口或枚举声明|
|ElementType.FIELD|属性（变量）声明|
|ElementType.METHOD|方法声明|
|ElementType.PARAMETER|形参声明|
|ElementType.CONSTRUCTOR|构造函数声明|
|ElementType.LOCAL_VARIABLE|局部变量声明|
|ElementType.ANNOTATION_TYPE|用于标注注解（如元注解）|
|ElementType.PACKAGE|包声明|

java 8.0 又新增两个可选值：ElementType.TYPE_PARAMETER、ElementType.TYPE_USE。      
可以同时指定多个取值，互相不影响（因为@Target 的属性是个ElementType数组）。

#### @Inherited
@Inherited 定义该注释和子类的关系，仅对类起效。

### 注解的属性
注解（Annotations）只支持基本类型、String及枚举类型作为其属性，且所有的属性被定义成方法，并允许提供默认值（default关键字）。      

### 注解的使用
上面定义的 @AnnotationDemo 和 @Author 的用法示例如下：
```
package com.hxx.model;

import com.hxx.annotation.*;
import com.hxx.enums.UserType;

@Author("houxx")
public class Person {
    @AnnotationDemo(time = 1, count = 2, name = "admin", userType = UserType.SYSTEM_ADMIN)
    public void work() {
        System.out.println("Now,to work!");
    }

```
注解名后跟小括号标注其属性。标注方式：`属性名 = 值`，多个属性以 `,` 分隔。有默认值的属性可不赋值。     
若是注解只有一个属性,可以直接命名为`value`，使用时无需再标明属性名。如：@Author和元注解。

## 适合注解的场景
上文明确说明了，**注解不具备任何业务处理能力**，这样的元数据似乎并不非常重要。     
但事实并非如此，各种开发框架里都大量的使用了注解（如 Spring、Hibernate）。       
注解的声明和注解的处理逻辑是分不开的。后者常常以 **AOP**（面向切面编程） 的形式实现。     
AOP 中 annotation 的用法在下篇文章里。