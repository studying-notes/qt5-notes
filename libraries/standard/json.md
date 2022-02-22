---
date: 2022-02-22T09:59:55+08:00
author: "Rustle Karl"

title: "JSON 解析"
url:  "posts/qt5/libraries/standard/json"  # 永久链接
tags: [ "Qt5", "C++" ]  # 标签
series: [ "Qt5 学习笔记" ]  # 系列
categories: [ "学习笔记" ]  # 分类

toc: true  # 目录
draft: false  # 草稿
---

在 Qt 库中，为 JSON 的相关操作提供了完整的类支持，包括 QJsonValue，QJsonObject，QJsonArray，QJsonDocument 和 QJsonParseError。

其中，

- `QJsonValue` 类表示 json 格式中的一个值； 
- `QJsonObject` 表示一个 json 对象； 
- `QJsonArray` 顾名思义表示一个 json 数组； 
- `QJsonDocument` 主要用来读写 json 文档；
- `QJsonParseError` 是用来表示 json 解析过程中出现的错误。

## QJsonValue

QJsonValue 类封装了一个 json 格式中的值。该值可以是如下 6 中基本类型：

- bool QJsonValue::Bool
- double QJsonValue::Double
- string QJsonValue::String
- array QJsonValue::Array
- object QJsonValue::Object
- null QJsonValue::Null

一个 QJsonValue 可以表示上面任何一种数据类型。此外，QJsonValue 还有一个特殊的标志用来表示未定义的值。可以使用 isUndefined() 函数来进行判断。而一个 QJsonValue 中存储的类型可以通过 type() 或 isBool()，isString() 之类的函数进行查询。同样，QJsonValue 中存储的值可以通过 toBool()，toString() 等函数转换到具体的类型。

QJsonValue 中存储的值在内部是强类型的，并且和 QVariant 相反，它不会尝试进行任何的隐式类型转换。这意味着将 QJsonValue 转换成一个不是它存储的类型，将返回一个该类型的模型构造函数返回的值。

其实，说到 QJsonValue，还有另一个类要说，QJsonValueRef，该类是一个对于 QJsonArray 和 QJsonObject 来说的一个帮助类。当你获得一个 QJsonValueRef 类的对象后，你可以把它当做一个 QJsonValue 对象的应用来使用。如果你向他赋值，该值会实际作用到底层的 QJsonArray 或者 QJsonObject 对象中的元素上。而要想使用该类，可以使用一下的两个方法：

- QJsonArray::operator[](int i)
- QJsonObject::operator[](const QString& key)const;

下面来看一下 QJsonValue 的构造函数：

```cpp
QJsonValue(Type type = Null)
QJsonValue(bool b)
QJsonValue(double n)
QJsonValue(int n)
QJsonValue(qint64 n)
QJsonValue(const QString &s)
QJsonValue(QLatin1String s)
QJsonValue(const char *s)
QJsonValue(const QJsonArray &a)
QJsonValue(const QJsonObject &o)
QJsonValue(const QJsonValue &other)
```

可以看到，该类主要是对基本类型的一个包装。

## QJsonObject

QJsonObject 类封装了一个 json 对象。一个 json 对象是一个键值对的列表，其中 key 是唯一的字符串，而值就是一个我们上面讲到的 QJsonValue。一个 QJsonObject 的对象可以转换到 QVariantMap，要可以由 QVariantMap 转换得到。

我们可以使用 size() 函数来查询一个 QJsonObject 中存储的键值对的个数；使用 insert() 和 remove() 来插入或从中删除键值对；还可以使用标准的 C++ 迭代器来遍历它。

QJsonObject 类是一个隐式共享类。

其构造函数如下：

```cpp
QJsonObject()
QJsonObject(std::initializer_list<QPair<QString, QJsonValue> > args)
QJsonObject(const QJsonObject &other)
```

我们可以使用初始化列表来快速的构建一个 QJsonObject 对象。如下：

```cpp
  QJsonObject object
  {
      {"property1", 1},
      {"property2", 2}
  };
```

如此之外, 比较常用的就是 insert() 函数了:

```cpp
iterator QJsonObject::insert(const QString &key, const QJsonValue &value)
```

一般，我们可以先定义一个空的 QJsonObject 对象，然后使用该函数向其中插入需要的键值对。如果新插入的 key 已存在，那么会进行替换。

下面，我们通过一个例子还使用该类构造如下 json 字符串：

```json
{"name":"lily", "age":23, "addr":{"city":"xxx", "province":"yyy"}}
```

代码如下：

```cpp
#include <QCoreApplication>
#include <QDebug>
#include <QJsonObject>
 
int main(int argc, char *argv[])
{
    QCoreApplication a(argc, argv);
 
    QJsonObject obj;
    obj.insert("name", "lily");
    obj.insert("age", 23);
    QJsonObject addr;
    addr.insert("city", "guangzhou");
    addr.insert("province", "guangdong");
    obj.insert("addr", addr);
    qDebug() << obj;
 
    return a.exec();
}
```

我们先构建了一个 QJsonObject 对象 obj，然后向其中插入姓名和年龄键值对；因为地址又是一个 QJsonObject，所以我们又构建了 addr 对象，向其中插入城市和省份，最后，将该 QJsonObject 做为地址键值对的值，插入到 obj 中。打印结果如下：

![img](http://dd-static.jd.com/ddimg/jfs/t1/101602/36/24467/22163/621443dbEbad7f2f1/529c31cece4f05b8.png)
QJsonArray

顾名思义，QJsonArray 封装了一个 JSON 数组。一个 JSON 数组是一个值的列表。我们可以向这个列表中插入或删除 QJsonValue。

同时，我们可以把一个 QVariantList 转换成一个 QJsonArray。也可以使用标准 C++ 迭代器对它进行遍历。

其构造函数如下：

```cpp
QJsonArray()
QJsonArray(std::initializer_list<QJsonValue> args)
QJsonArray(const QJsonArray &other)
```

我们也可以像上面那样，使用一个初始化列表来构建一个 QJsonArray 对象：

```cpp
QJsonArray array = { 1, 2.2, QString() };
```

在此我们只使用了单个的值，没有使用键值对。其实，这样的 json 对象，一般我们就称为数组。

和 QJsonObject 一样，我们一般也是通过它的 insert() 函数来生成我们需要的 json 数组：

```cpp
void insert(int i, const QJsonValue &value)
iterator insert(iterator before, const QJsonValue &value)
```

下面，我们继续上面的例子，来生成一个表示人物信息的列表。代码如下：

```cpp
#include <QCoreApplication>
#include <QDebug>
#include <QJsonObject>
#include <QJsonArray>
 
int main(int argc, char *argv[])
{
    QCoreApplication a(argc, argv);
 
    QJsonObject obj1;
    obj1.insert("name", "lily");
    obj1.insert("age", 23);
    QJsonObject addr1;
    addr1.insert("city", "guangzhou");
    addr1.insert("province", "guangdong");
    obj1.insert("addr", addr1);
    qDebug() << obj1;
 
    QJsonObject obj2;
    obj2.insert("name", "tom");
    obj2.insert("age", 24);
    QJsonObject addr2;
    addr2.insert("city", "shenzhen");
    addr2.insert("province", "guangdong");
    obj2.insert("addr", addr2);
    qDebug() << obj2;
 
    QJsonObject obj3;
    obj3.insert("name", "jerry");
    obj3.insert("age", 24);
    QJsonObject addr3;
    addr3.insert("city", "foshan");
    addr3.insert("province", "guangdong");
    obj3.insert("addr", addr3);
    qDebug() << obj3;
 
    QJsonArray array;
    array.push_back(obj1);
    array.push_back(obj2);
    array.push_back(obj3);
    qDebug() << array;
 
    return a.exec();
}
```

在此，我们只是简单的构建了三个人物的 QJsonObject 对象，然后将它们放入一个 QJsonArray 中。输入结果如下：

![img](http://dd-static.jd.com/ddimg/jfs/t1/117693/10/20832/30257/621443dbEd62b4fc6/bc735091f5e9c6e2.png)

## QJsonDocument

QJsonDocument 类提供了读写 JSON 文档的方法。QJsonDocument 类包装了一个完整的 JSON 文档，我们可以以 utf-8 编码的文本格式和 Qt 自己的二进制格式来操作该文档。一个 JSON 文档可以使用 QJsonDocument::fromJson() 函数转换 json 文本字符串来得到。而 toJson() 可以将其转换成文本。这个解析器是非常快速和高效的，Qt 也是使用它来将 JSON 对象转换成其二进制表示的。解析得到的文档可以使用 isNull() 来判断是否有效。还可以使用 isArray() 和 isObject() 函数来判断该文档所包含的是否是数据或 json 对象。如果是，可以使用 array() 或 object() 函数还获得其中的对象或数组。

其构造函数如下：

```cpp
QJsonDocument()
QJsonDocument(const QJsonObject &object)
QJsonDocument(const QJsonArray &array)
QJsonDocument(const QJsonDocument &other)
```

除了构造函数外，该类还提供了两个转换函数，可以将 json 文档序列化为二进制对象，然后我们就可以将该对象存储到文件中，或发送到网络上。

```cpp
QByteArray toBinaryData() const
QByteArray toJson(JsonFormat format = Indented) const
```

下面，我们就使用该类将我们上面生成的 json 数组写入到文件中：

代码如下：

```cpp
#include <QCoreApplication>
#include <QDebug>
#include <QJsonObject>
#include <QJsonArray>
#include <QFile>
#include <QJsonDocument>
 
int main(int argc, char *argv[])
{
    QCoreApplication a(argc, argv);
 
    QJsonObject obj1;
    obj1.insert("name", "lily");
    obj1.insert("age", 23);
    QJsonObject addr1;
    addr1.insert("city", "guangzhou");
    addr1.insert("province", "guangdong");
    obj1.insert("addr", addr1);
    qDebug() << obj1;
 
    QJsonObject obj2;
    obj2.insert("name", "tom");
    obj2.insert("age", 24);
    QJsonObject addr2;
    addr2.insert("city", "shenzhen");
    addr2.insert("province", "guangdong");
    obj2.insert("addr", addr2);
    qDebug() << obj2;
 
    QJsonObject obj3;
    obj3.insert("name", "jerry");
    obj3.insert("age", 24);
    QJsonObject addr3;
    addr3.insert("city", "foshan");
    addr3.insert("province", "guangdong");
    obj3.insert("addr", addr3);
    qDebug() << obj3;
 
    QJsonArray array;
    array.push_back(obj1);
    array.push_back(obj2);
    array.push_back(obj3);
    qDebug() << array;
 
    QJsonDocument jsonDoc(array);
    QByteArray ba = jsonDoc.toJson();
    QFile file("result.json");
    if(!file.open(QIODevice::WriteOnly))
    {
        qDebug() << "write json file failed";
        return 0;
    }
    file.write(ba);
    file.close();
 
    return a.exec();
}
```

我们先使用 QJsonArray 构建出一个 QJsonDocument 对象，然后调用其 toJson()方法，将该 json 文档转换成一个字节数组。注意，toJson() 函数会接受一个格式化参数：

```cpp
QByteArray QJsonDocument::toJson(JsonFormat format = Indented) const
```

其中，format 主要有两种格式，一种是人们可读的格式，一种是紧凑的格式。分别描述如下表：

| Constant                | Value | Description                                                  |
| ----------------------- | ----- | ------------------------------------------------------------ |
| QJsonDocument::Indented | 0     | 定义人们可读的输出格式，如下： { "Array":[ true, 999, "string" ], "key": "value", "null": null } |
| QJsonDocument::Compact  | 1     | 定义一个紧凑的输出格式，如下： {"Array": [true, 999, "string"], "key": "value", "null":null} |


toJson() 函数默认使用 Indented，一缩进的形式生成人们可读的 json 文件。

运行该程序后，在编译目录查看生成的 json 文件。结果如下：

![img](http://dd-static.jd.com/ddimg/jfs/t1/135648/15/23118/22163/621443dbE209804f5/13fabdeb724cceb7.png)

当然，除了将 json 对象写入到文件中，QJsonDocument 还提供了几个静态函数，将从文件中读取出的原始数据或 json 字符串转换成一个 QJsonDocument 对象。函数声明信息如下：

```cpp
QJsonDocument fromBinaryData(const QByteArray &data, DataValidation validation = Validate)
QJsonDocument fromJson(const QByteArray &json, QJsonParseError *error = Q_NULLPTR)
QJsonDocument fromRawData(const char *data, int size, DataValidation validation = Validate)
QJsonDocument fromVariant(const QVariant &variant)
```

下面，我们就使用这些函数，将我们写入到文件中的 json 对象再读出来，并生成一个 QJsonDocument 对象。

代码如下：

```cpp
#include <QCoreApplication>
#include <QDebug>
#include <QFile>
#include <QJsonDocument>
 
int main(int argc, char *argv[])
{
    QCoreApplication a(argc, argv);
 
    QFile file("result.json");
    if(!file.open(QIODevice::ReadOnly))
    {
        qDebug() << "read json file failed";
        return 0;
    }
    QByteArray ba = file.readAll();
    qDebug() << "读出的数据如下：";
    qDebug() << ba;
    QJsonParseError e;
    QJsonDocument jsonDoc = QJsonDocument::fromJson(ba, &e);
    if(e.error == QJsonParseError::NoError && !jsonDoc.isNull())
    {
        qDebug() << jsonDoc;
    }
 
    return a.exec();
}
```


在此，因为我们从文件中读出的是一个 json 形式的字符串，所以可以使用 fromJson() 函数，将其转换成一个 QJsonDocument 对象。同时，在调用 fromJson() 函数时，我们还为它传入了一个 QJsonParseError 对象，用来接收解析 json 字符串的过程中，有可能发生的错误信息。

代码运行如下：

![img](http://dd-static.jd.com/ddimg/jfs/t1/93127/23/22907/39777/621443dbE19e97f63/7757f0d5c8aa7916.png)
