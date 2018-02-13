#JAVA调用matlab程序 输入输出数据转换
1.  JAVA 程序调用 matlab函数（matlab导出jar包里的函数）、JAVA解析matlab返回数据时，机器需要先安装**matlab运行时环境** 并 在java工程中导入运行时环境提供的**javabuilder.jar**用于数据类型的转换。
2. java工程中导入从matlab导出的jar文件。
## 函数调用
 a. 传入函数的JAVA变量先转换为运行时环境里的对象
例如：JAVA double对象转 matlab double对象（传入函数的实际是运行时环境提供的中间类型）
```
double params= 0.2d;
MWNumericArray p1 = new MWNumericArray(params, MWClassID.DOUBLE);
```
 b. 函数调用
```
//封装实参为函数接受的类型
Object[] inputs = new Object[5];
MWNumericArray p1 = new MWNumericArray(params, MWClassID.DOUBLE);
input[1]=p1;
····
//实例化matlab函数入口对象，调用函数
//传入的第一个参数是指定函数返回值数量（必须严格和实际返回值数量一致），第二个参数开始是实参列表（本例中实参封装为Object数组传入）
//函数返回 在Object数组 result 中
ClassSimple simple= new ClassSimple();
Object[] result = simple.XXXX(5, inputs);
```
## matlab函数返回数据解析
目前，项目使用到并**成功实现转换的数据类型有 元胞数组、双精度型数据、字符型数据**。 最小粒度的数据为双精度型数据、字符型数据，经过元胞数组的封装和嵌套 返回。转换过程中，确认不能转换的数据类型有  table、日期时间型、日期长度型、时间日期向量。
```
Object res1= result[0];
//先将数据类型强制类型转换为MWCellArray
MWCellArray cellArray = (MWCellArray) res1;
//cellArray.numberOfElements() 获取元胞数组中元素总个数
//MWCellArray 相当于把表格数据纵向一维展开， 每一列的数据是相连的 而封装java对象要抽出一行的数据
//元素总个数除以列数（表具有的字段数）得到行数
int rowNum= cellArray.numberOfElements() / columnNum;
for (int i = 1; i <= rowNum; i++) {
			Bean bean= new Bean();
                        //解析字符型数据
			bean.setName(String.valueOf(((char[][]) cellArray.get(i))[0]));
                        //解析双精度型数据
			bean.setWeight(((double[][]) cellArray.get(rowNum+ i))[0][0]);
			System.err.println(bean);
}
 ```
 1. 字符型数据的转换
 确认元胞数组 cellArray 的第i 个元素对应字符型数据（可以先输出第i个元素的类名查看 字符型数据对应的Class的SimpleName为char[][]）后，
通过
```
String.valueOf(((char[][]) cellArray.get(i))[0]);
```
转换为String；
 2. 双精度型数据的转换
确认元胞数组cellArray 的第j 个元素对应双精度型数据（对应SimpleName为double[][]）后,
通过
```
((double[][]) cellArray.get(j))[0][0];
```
即可取出该位置的数据；
 3. 元胞数组嵌套时的数据转换
确认元胞数组cellArray 的第k个元素为元胞数组类型（对应SimpleName为MWArray）后,
通过
```
MWArray array= cellArray.getCell(k);			
```
即可取出该位置的元胞数组，再次解析即可，例如：
```
for (int j = 1; j <= array.numberOfElements(); j++) {
       String.valueOf(((char[][]) array.get(j))[0]);
}
```
## 注意事项：
    1. 运行时环境里的元胞数组 **下标从1开始** 下标为0 报错；
    2. MWCellArray 相当于把表格数据纵向一维展开， 每一列的数据是相连的 而封装java对象要抽出一行的数据；
    3. 成功实现转换的数据类型有 元胞数组、双精度型数据、字符型数据； 确认不能转换的数据类型有  table、日期时间型、日期长度型、时间日期向量；
    4. 从元胞数组中获取元胞数组是使用cellArray.getCell()，使用cellArray.get()有时候报错。