# AOP (面向切面编程) 系列之一
上接 `java 注解（annotation）`  ,注解是 **元数据** ，**本身不具备任何业务处理能力**。AOP 编程就是赋予注解实际处理能力的一种常见方式。
## AOP 是什么 
AOP 是 Aspect Oriented Programming 的简称，一般翻译为`面向切面编程` 。           
提到 AOP 可能还有一些陌生，先说一个人尽皆知的 OOP （Object-oriented programming，面向对象程序设计）。把现实事物抽象为程序对象的编程思想大大提高软件的重用性、灵活性和扩展性，被广泛地应用于软件开发领域。         
AOP 是指可以通过预编译方式和运行期动态代理实现在不修改源代码的情况下给程序动态统一添加功能的一种技术，目的是调用者和被调用者之间的解耦,提高代码的灵活性和可扩展性。        
因此， AOP 取代 OOP 的说法根本就是无稽之谈。二者适用的场景和设计的目标并不相同。   
通俗的说 AOP 是在程序编译过程或者运行过程（动态代理）中根据提前设置的切面统一添加特定的功能，而对业务代码无侵入或低侵入。
## 常见的 AOP 使用场景
目前常见的应用场景主要是日志记录，性能统计，安全控制，事务处理，异常处理等等。尤其在编程框架中最为常见。
## spring XML 配置方式 AOP
`Talk is cheap, just show you the code`     
本文使用纯 spring XML 配置方式使用 AOP ，不使用 AspectJ 注解（注解方式是挖的另一个坑，下一篇填）。
### 用作切面的注解
借用 `java 注解（annotation）` 的自定义注解 AnnotationDemo （仅仅只是偷懒罢了）。     
注解在上文中已经解释地很详细了。
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
### 切面方法定义
这里是指切面触发的特定逻辑（aspect definition）。       
实在是不擅长文字描述，直接看代码吧。       
```
package com.hxx.aop;

import com.hxx.annotation.AnnotationDemo;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.reflect.MethodSignature;

/**
 * <ul>
 * <li>功能说明：使用 spring 的 XML 方式配置 AOP</li>
 * <li>作者：tal on 2018/10/17 0017 17:20 </li>
 * <li>邮箱：hou_xiangxiang@126.com</li>
 * </ul>
 */
public class SpringAspect {
    /**
     * 切点执行前执行的方法
     *
     * @param point
     */
    public void doBefore(JoinPoint point) {
        System.out.println("---------------> before ");
    }

    public Object doAround(ProceedingJoinPoint point) throws Throwable {
        System.out.println("---------------> around start");
        MethodSignature methodSignature = (MethodSignature) point.getSignature();
        AnnotationDemo annotation = methodSignature.getMethod().getAnnotation(AnnotationDemo.class);
        System.out.println("annotation ---------------> " + annotation);
        Object proceed = null;
        try {
            proceed = point.proceed();
        } catch (Throwable throwable) {
            throw throwable;
        }
        System.out.println("---------------> around end");
        return proceed;
    }

    /**
     * 切点执行后执行的方法
     *
     * @param point
     */
    public void doAfter(JoinPoint point) {
        System.out.println("---------------> after");
    }

    /**
     * 后置异常通知：在切点抛出异常之后执行,可以访问到异常信息,且可以指定出现特定异常信息时执行代码
     *
     * @param point
     */
    public void afterThrowing(JoinPoint point, Throwable throwable) {
        System.out.println("---------------> afterThrowing");
        System.out.println(throwable.getMessage());
    }

    /**
     *
     * @param point
     * @param returnValue
     */
    public void afterReturning(JoinPoint point, int returnValue) {
        System.out.println("---------------> afterReturning +++ " + returnValue);
    }
}

```

说不用  AspectJ 注解就一个都不用。
虽然没有用 AspectJ 注解，但也用了 aspectj 的几个类，所以是要引入 aspectj 依赖的。本文只举例 maven 的 pom 文件依赖方式，jar 包版本号一般选择最新版即可。
```
<dependency>
    <groupId>org.aspectj</groupId>
    <artifactId>aspectjrt</artifactId>
    <version>${aspectj.version}</version>
</dependency>
<dependency>
    <groupId>org.aspectj</groupId>
    <artifactId>aspectjweaver</artifactId>
    <version>${aspectj.version}</version>
</dependency>
```
除此之外这就是一个普普通通的类了。类里的方法名和参数名会在 spring xml 配置里用到，叫什么不要紧，一致即可（不一致编译就会报错）。
### spring XML 配置
使用 spring xml 配置先引入 spring 依赖，照旧只上 maven 依赖，版本自己选。
```
<!-- spring context 支持-->
<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-context-support</artifactId>
    <version>${spring.version}</version>
</dependency>
<!-- spring aop 支持-->
<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-aop</artifactId>
    <version>${spring.version}</version>
</dependency>
```
spring context 入口文件（applicationContext.xml）：
```
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:context="http://www.springframework.org/schema/context"
    xmlns:aop="http://www.springframework.org/schema/aop"
    xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context.xsd http://www.springframework.org/schema/aop http://www.springframework.org/schema/aop/spring-aop.xsd">

    <context:component-scan base-package="com.hxx" />
    <!-- 支持注解 -->
    <context:annotation-config />
    <!-- 支持 aop -->
    <aop:aspectj-autoproxy />
    <import resource="applicationContext-aop.xml" />
</beans>
```
重头戏是 aop 的 xml 配置（applicationContext-aop.xml），其内容是这样的：
```
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:aop="http://www.springframework.org/schema/aop"
    xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context.xsd http://www.springframework.org/schema/aop http://www.springframework.org/schema/aop/spring-aop.xsd">

    <bean id="springAspect" class="com.hxx.aop.SpringAspect" />
    <aop:config proxy-target-class="true">
        <aop:aspect ref="springAspect">
            <aop:pointcut id="springPointcut"
                expression="@annotation(com.hxx.annotation.AnnotationDemo)" />
            <aop:around pointcut-ref="springPointcut" method="doAround" />
            <aop:before pointcut-ref="springPointcut" method="doBefore" />
            <aop:after pointcut-ref="springPointcut" method="doAfter" />
            <aop:after-throwing pointcut-ref="springPointcut" method="afterThrowing"
                throwing="throwable" />
            <aop:after-returning pointcut-ref="springPointcut" method="afterReturning"
                returning="returnValue" />
        </aop:aspect>
    </aop:config>
</beans>
```
先来读一下这个配置文件     
*`<aop:config></aop:config>`* 是一条 aop 规则，当然实际使用中可以根据需求定义多条规则。       
`proxy-target-class` 指定是否创建基于类的（CGLIB）代理，默认创建 jdk 代理（Java interface-based）。一般选 true 即可（这二者代理的性能差别也先挖个坑，以后再填）。     
*`aop:aspect`* 标签定义切面，ref 指定切面的实例；id 设置切面的标识； order 可以指定切面的顺序，用于同一个切入点（连接点）多个切面时指定执行顺序。    
*`aop:pointcut`* 标签定义一个切入点，即切面执行的条件。id 设置标识，指定切入点对应要执行的方法时会使用。expression 指切点表达式，符合条件则触发切入点。`@annotation(com.hxx.annotation.AnnotationDemo)`的意思是被 AnnotationDemo 注解标注的地方是切入点（expression 的详细解释、种类及复合用法也先挖个坑）。     
*`aop:around`* 标签定义切点围绕的方法，这里可以根据条件拒绝执行切点方法，也可以处理过程中产生的异常（吞掉或者包装）。pointcut-ref 指定属于哪个切入点，method 指定要执行切面方法名，本例中是 SpringAspect 的 doAround 方法。此时 doAround 方法只能有一个 JoinPoint 类型的参数，否则运行过程中会因参数不匹配而报错。         
在 around 指定的方法里，调用 JoinPoint 的 proceed 方法就会执行切入点。around 也因围绕着这个过程而得名。       
*`aop:before`* 标签定义切入点执行前要执行的方法。method 指定要执行切面的方法名,即  JoinPoint 的 proceed 方法执行前执行的方法（如果同时也有 around 配置的话）。     
*`aop:after`* 标签定义切入点执行后要执行的方法。     
*`aop:after-throwing`* 标签定义发生异常时执行的方法，此时可以拿到发生的异常，但无法阻止异常抛出。throwing 指定 在 method 指定的方法里异常的参数名。出现 throwing 配置也要在方法里有同名的 Throwable 类型参数接收发生的异常，否则同样在运行过程中会因参数不匹配而报错。      
*`aop:after-returning`* 标签定义返回结果后执行的方法，与 `aop:after-throwing` 类似，returning 指代切面方法中接收返回值的形参。配置和方法必须同时出现。       
看完这些就可以看出 **around** 最为强大，ProceedingJoinPoint 参数可以控制切入点的执行，因此其使用场景也最多。      
从 JoinPoint 中可以拿到切入点的方法以及其注解信息，还原出切点处的注解配置。       

### AOP 使用
定义并配置好了切面、切入点，来看看怎么用。       
首先模拟业务场景定义一个接口：
```
package com.hxx.api;

/**
 * <ul>
 * <li>功能说明：模拟业务接口</li>
 * <li>作者：tal on 2018/10/18 0018 14:34 </li>
 * <li>邮箱：hou_xiangxiang@126.com</li>
 * </ul>
 */

public interface ApiDemo {
    /**
     * 模拟业务方法定义
     *
     * @param input 输入
     * @return 输出
     */
    int work(int input);
}

```
简单实现一下这个接口，并使用一下配置好的 AOP ：
```
package com.hxx.api.impl;

import com.hxx.annotation.AnnotationDemo;
import com.hxx.api.ApiDemo;
import com.hxx.enums.UserType;

import org.springframework.stereotype.Service;

@Service("apiDemo")
public class ApiDemoImpl implements ApiDemo {

    @AnnotationDemo(time = 1, count = 2, name = "admin", userType = UserType.SYSTEM_ADMIN)
    public int work(int input) {
        System.out.println("------->> ApiDemo work");
        return 3 / input;
    }

}

```
使用非常简单，在方法上添加注解即可，**对业务完全无侵入**。

### 结果测试
借助 junit 测试用例进行测试：
```
package com.hxx.api;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;

@RunWith(SpringJUnit4ClassRunner.class) //使用junit4进行测试
@ContextConfiguration(locations = {"classpath*:applicationContext.xml"}) //加载配置文件
public class ApiDemoTest {

    @Resource(name = "apiDemo")
    private ApiDemo apiDemo;

    @Test
    public void testWork() throws Exception {
        apiDemo.work(1);
    }

    @Test
    public void testWorkException() throws Exception {
        apiDemo.work(0);
    }
} 
```
运行 testWork（） 可以得到结果：
```
---------------> around start
annotation ---------------> @com.hxx.annotation.AnnotationDemo(name=admin, count=2, time=1, userType=SYSTEM_ADMIN - 系统管理员)
---------------> before 
------->> ApiDemo work
---------------> around end
---------------> after
---------------> afterReturning +++ 3
```
执行结果完全符合预期，但没测试到出现异常的情况，我们再运行一下 testWorkException() ：
```
---------------> around start
annotation ---------------> @com.hxx.annotation.AnnotationDemo(name=admin, count=2, time=1, userType=SYSTEM_ADMIN - 系统管理员)
---------------> before 
------->> ApiDemo work
---------------> after
---------------> afterThrowing
/ by zero

java.lang.ArithmeticException: / by zero
    at com.hxx.api.impl.ApiDemoImpl.work(ApiDemoImpl.java:15)
    ……
```
当出现异常且在 around 中没有吞掉时，afterThrowing 执行了，after 也执行了，但 afterReturning 无法再执行，around 中抛出异常后的语句也无法再执行。
如果在 around 中吞掉异常，修改 SpringAspect 的 doAround 方法为(仅仅注释了 throw 语句)：
```
 public Object doAround(ProceedingJoinPoint point) throws Throwable {
        System.out.println("---------------> around start");
        MethodSignature methodSignature = (MethodSignature) point.getSignature();
        AnnotationDemo annotation = methodSignature.getMethod().getAnnotation(AnnotationDemo.class);
        System.out.println("annotation ---------------> " + annotation);
        Object proceed = 0;
        try {
            proceed = point.proceed();
        } catch (Throwable throwable) {
           // throw throwable;
        }
        System.out.println("---------------> around end");
        return proceed;
    }
```
重新运行 testWorkException 后得到结果：
```
---------------> around start
annotation ---------------> @com.hxx.annotation.AnnotationDemo(name=admin, count=2, time=1, userType=SYSTEM_ADMIN - 系统管理员)
---------------> before 
------->> ApiDemo work
---------------> around end
---------------> after
---------------> afterReturning +++ 0
```
由此看到可以在 around 中吞掉异常，给回默认返回值。