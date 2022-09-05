---
date: 2022-02-16T14:31:08+08:00
author: "Rustle Karl"  # 作者

title: "Qt 字符串类"  # 文章标题
url:  "posts/qt5/libraries/standard/Qt/Core/QString"  # 设置网页永久链接
tags: [ "qt5", "qstring" ]  # 标签
categories: [ "Qt5 学习笔记" ]  # 分类

toc: true  # 目录
draft: true  # 草稿
---

标准 C++ 提供了两种字符串：一种是 C 语言风格的以“\0”字符结尾的字符数组；另一种是字符串类 String。而 Qt 字符串类 QString 功能更强大。

QString 类保存 16 位 Unicode 值，提供了丰富的操作、查询和转换等函数。该类还进行了使用隐式共享（implicit sharing）、高效的内存分配策略等多方面的优化。

```c++
std::cout << QString("Welcome!").toStdString();
```

- [操作字符串](#操作字符串)
- [查询字符串数据](#查询字符串数据)
- [字符串的转换](#字符串的转换)
  - [字符串转换为整型数值](#字符串转换为整型数值)
  - [字符编码集的转换](#字符编码集的转换)
- [NULL 字符串和空（empty）字符串的区别](#null-字符串和空empty字符串的区别)

## 操作字符串

字符串有如下几个操作符。

1. QString 提供了一个二元的“+”操作符用于组合两个字符串，并提供了一个“+=”操作符用于将一个字符串追加到另一个字符串的末尾，例如：

```c++
QString str1 = "Welcome ";
str1=str1+"to you! ";         //str1=" Welcome to you! "
QString str2="Hello, ";
str2+="World! ";               //str2="Hello,World! "
```

其中，`QString str1 = "Welcome "` 传递给 QString 一个 `const char *` 类型的 ASCII 字符串 “Welcome”，它被解释为一个典型的以“\0” 结尾的 C 类型字符串。这将会导致调用 QString 构造函数，来初始化一个 QString 字符串。其构造函数原型为：

```c++
QT_ASCII_CAST_WARN_CONSTRUCTOR QString::QString(const char* str)
```

被传递的 `const char *` 类型的指针又将被函数 `QString :: fromAscii()` 转换为 Unicode 编码。默认情况下，函数 `QString :: fromAscii()` 会将超过 128 的字符作为 Latin-1 进行处理（可以通过调用 `QTextCodec :: setCodecForCString()` 函数改变 `QString :: fromAscii()` 函数的处理方式）。

此外，在编译应用程序时，也可以通过定义 `QT_CAST_FROM_ASCII` 宏变量屏蔽该构造函数。如果程序员要求显示给用户的字符串都必须经过 `QObject::tr()` 函数的处理，那么屏蔽 QString 的这个构造函数是非常有用的。

2. `QString::append()` 函数具有与“+=”操作符同样的功能，实现在一个字符串的末尾追加另一个字符串，例如：

```c++
QString str1 = "Welcome ";
QString str2 = "to ";
str1.append(str2);           //str1=" Welcome to"
str1.append("you! ");       //str1="Welcome to you! "
```

3. 组合字符串的另一个函数是 QString::sprintf()，此函数支持的格式定义符和 C++ 库中的函数 sprintf() 定义的一样。例如：

```c++
QString str;
str.sprintf("%s"," Welcome ");             //str="Welcome "
str.sprintf("%s"," to you! ");             //str="to you! "
str.sprintf("%s %s"," Welcome ", "to you! "); //str=" Welcome to you! "
```

```c++
QString s;
s.sprintf("%d = %x", 20, 20);
std::cout << s.toStdString();
```

4. Qt 还提供了另一种方便的字符串组合方式，使用 QString::arg() 函数，此函数的重载可以处理很多的数据类型。此外，一些重载具有额外的参数对字段的宽度、数字基数或者浮点数精度进行控制。通常，相对于函数 QString::sprintf()，函数 QString::arg() 是一个比较好的解决方案，因为它类型安全，完全支持 Unicode，并且允许改变 "%n" 参数的顺序。例如：

```c++
QString str;
str=QString("%1 was born in %2.").arg("John").arg(1982);//str="John was born in 1982."
```

其中，"%1"被替换为"John"，"%2"被替换为"1982"。

```c++
std::cout << QString("%1 = %2\n").arg(20).arg(20, 0,16).toStdString();
```

5. QString也提供了一些其他组合字符串的方法，包括如下几种。

- insert()函数：在原字符串特定的位置插入另一个字符串。
- prepend()函数：在原字符串的开头插入另一个字符串。
- replace()函数：用指定的字符串代替原字符串中的某些字符。

6. 很多时候，去掉一个字符串两端的空白（空白字符包括回车字符“\n”、换行字符“\r”、制表符“\t”和空格字符“ ”等）非常有用，如获取用户输入的账号时。

- QString::trimmed()函数：移除字符串两端的空白字符。
- QString::simplified()函数：移除字符串两端的空白字符，使用单个空格字符“ ”代替字符串中出现的空白字符。

```c++
std::cout << QString("Welcome \t to \n you!\n").trimmed().toStdString();
std::cout << QString("Welcome \t to \n you!\n").simplified().toStdString();
```

## 查询字符串数据

1. 函数 QString::startsWith() 判断一个字符串是否以某个字符串开头。此函数具有两个参数。第一个参数指定了一个字符串，第二个参数指定是否大小写敏感（默认情况下，是大小写敏感的），例如：

```c++
QString str="Welcome to you! ";
str.startsWith("Welcome",Qt::CaseSensitive);   //返回true;
str.startsWith("you",Qt::CaseSensitive);        //返回false;
```

2. 函数QString::endsWith()类似于QString::startsWith()，此函数判断一个字符串是否以某个字符串结尾。

3. 函数QString::contains()判断一个指定的字符串是否出现过，例如：

```c++
QString str=" Welcome to you! ";
str.contains("Welcome",Qt::CaseSensitive);     //返回true;
```

4. 比较两个字符串也是经常使用的功能，QString提供了多种比较手段。

- operator<(const QString&)：比较一个字符串是否小于另一个字符串。如果是，则返回true。
- operator<=(const QString&)：比较一个字符串是否小于等于另一个字符串。如果是，则返回true。
- operator==(const QString&)：比较两个字符串是否相等。如果相等，则返回true。
- operator>=(const QString&)：比较一个字符串是否大于等于另一个字符串。如果是，则返回true。
- localeAwareCompare(const QString&,const QString&)：静态函数，比较前后两个字符串。如果前面字符串小于后面字符串，则返回负整数值；如果等于则返回0；如果大于则返回正整数值。该函数的比较是基于本地（locale）字符集的，而且是平台相关的。通常，该函数用于向用户显示一个有序的字符串列表。
- compare(const QString&,const QString&,Qt::CaseSensitivity)：该函数可以指定是否进行大小写的比较，而大小写的比较是完全基于字符的Unicode编码值的，而且是非常快的，返回值类似于localeAwareCompare()函数。

## 字符串的转换

QString 类提供了丰富的转换函数，可以将一个字符串转换为数值类型或者其他的字符编码集。

### 字符串转换为整型数值

1. QString::toInt() 函数将字符串转换为整型数值，类似的函数还有 toDouble()、toFloat()、toLong()、toLongLong() 等。下面举个例子说明其用法：

```c++
QString str="125";     //初始化一个"125"的字符串
bool ok;
int hex=str.toInt(&ok,16);        //ok=true,hex=293
int dec=str.toInt(&ok,10);        //ok=true,dec=125
```

其中，int hex=str.toInt(&ok,16)：调用 QString::toInt() 函数将字符串转换为整型数值。函数 QString::toInt() 有两个参数。第一个参数是一个 bool 类型的指针，用于返回转换的状态，当转换成功时设置为 true，否则设置为 false。第二个参数指定了转换的基数。当基数设置为 0 时，将会使用 C 语言的转换方法，即如果字符串以“0x”开头，则基数为 16 ；如果字符串以“0”开头，则基数为 8 ；其他情况下，基数一律是 10。

### 字符编码集的转换

2. QString提供的字符编码集的转换函数将会返回一个 const char* 类型版本的 QByteArray，即构造函数 QByteArray(const char*)构造的 QByteArray 对象。QByteArray 类具有一个字节数组，它既可以存储原始字节（raw bytes），也可以存储传统的以“\0”结尾的 8 位的字符串。在 Qt 中，使用 QByteArray 比使用 const char* 更方便，且 QByteArray 也支持隐式共享。转换函数有以下几种。

- toAscii()：返回一个ASCII编码的8位字符串。
- toLatin1()：返回一个Latin-1（ISO8859-1）编码的8位字符串。
- toUtf8()：返回一个UTF-8编码的8位字符串。
- toLocal8Bit()：返回一个系统本地（locale）编码的8位字符串。

```c++
QString str=" Welcome to you! ";  //初始化一个字符串对象
QByteArray ba=str.toAscii();     //(a)
qDebug()<<ba;       //(b)
ba.append("Hello,World! ");   //(c)
qDebug()<<ba.data();     //输出最后结果
```

其中，

(a) `QByteArray ba=str.toAscii()`：通过 QString :: toAscii() 函数，将 Unicode 编码的字符串转换为 ASCII 码的字符串，并存储在 QByteArray 对象 ba 中。
(b) `qDebug()<<ba`：使用 qDebug() 函数输出转换后的字符串（qDebug() 支持输出 Qt 对象）。
(c) `ba.append("Hello,World!")`：使用 QByteArray :: append() 函数追加一个字符串。

## NULL 字符串和空（empty）字符串的区别

一个 NULL 字符串就是使用 QString 的默认构造函数或者使用 `(const char *)0` 作为参数的构造函数创建的 QString 字符串对象；而一个空字符串是一个大小为 0 的字符串。一个 NULL 字符串一定是一个空字符串，而一个空字符串未必是一个 NULL 字符串。例如：

```c++
QString().isNull();          //结果为true
QString().isEmpty();         //结果为true
QString("").isNull();        //结果为false
QString("").isEmpty();      //结果为true
```
