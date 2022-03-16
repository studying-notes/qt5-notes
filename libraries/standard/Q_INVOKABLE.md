---
date: 2022-03-08T14:23:13+08:00
author: "Rustle Karl"

title: "Q_INVOKABLE 及 Qt 反射"
url:  "posts/qt5/libraries/standard/Q_INVOKABLE"  # 永久链接
tags: [ "Qt5", "C++" ]  # 标签
series: [ "Qt5 学习笔记" ]  # 系列
categories: [ "学习笔记" ]  # 分类

toc: true  # 目录
draft: false  # 草稿
---

Qt 的元对象系统除了提供信号/槽机制的特性之外，它还提供了以下特性:

| QObject::metaObject()                       | 返回关联的元对象             |
| ------------------------------------------- | ---------------------------- |
| QMetaObject::className()                    | 在运行时状态下返回类名       |
| QObject::inherits()                         | 判断类的继承关系             |
| QObject::tr()，QObject::trUtf8()            | 提供国际化，翻译字符串       |
| QObject::setProperty()，QObject::property() | 通过名称来动态设置和获取属性 |
| QMetaObject::newInstance()                  | 创建新实例                   |

通过QObject::metaObject()方法， 所有继承于 QObject 的类可以 返回元对象系统为其生成的 metaObject 对象。QMetaObject 提供的一些重要信息：

| QMetaClassInfo | 通过宏 Q_CLASSINFO 的支持，提供类的附加信息   |
| -------------- | ------------------------------------------- |
| QMetaEnum      | Qt 特色的枚举对象，支持 key 和 value 之间的互转 |
| QMetaMethod    | 提供类成员函数的元数据                      |
| QMetaProperty  | 提供类成员属性的元数据                      |

## Qt 反射前期准备

1、首先得继承于Q_Object，同时需要在class中加入Q_OBJECT。

2、注册类成员变量需要使用Q_PROPERTY

　　Q_PROPERTY( type member READ get WRITE set) 其中READ，WRITE是关键字

　　Type表示成员的类型（不支持自定义类型，对Qt很多基本类型都支持）;

　　Member代表你给该成员另外起的名字，可以和变量名不同；get，set就是自己在C++函数里面定义的基本的访问函数名，不需要写参数。

3、注册类成员函数

　　如果你希望这个函数能够被反射，那么很简单，只需要在类的函数声明前加入**Q_INVOKABLE**关键字。

**下面是一个例子**：

```c++
//声明一个继承于QObject的类
class ReflectionObject : public QObject

{
      Q_OBJECT
      Q_PROPERTY(int Id READ Id WRITE setId)
      Q_PROPERTY(QString Name READ Name WRITE setName)
      Q_PROPERTY(QString Address READ Address WRITE setAddress)
      Q_PROPERTY(PriorityType Priority READ Priority WRITE setPriority)
      Q_ENUMS(PriorityType)

public:
      enum PriorityType  {High,Low,VeryHigh,VeryLow};
      Q_INVOKABLE int Id() {return m_Id; }
      Q_INVOKABLE QString Name() { return m_Name; }
      Q_INVOKABLE QString Address() { return m_Address; }
      Q_INVOKABLE PriorityType Priority() const {return m_Priority; }
      Q_INVOKABLE void setId(const int & id) {m_Id = id; }
      Q_INVOKABLE void setName(const QString & name) {m_Name = name; }
      Q_INVOKABLE void setAddress(const QString & address) {m_Address = address; }
      Q_INVOKABLE void setPriority(PriorityType priority) {m_Priority = priority; }

private:
      int      m_Id;
      QString  m_Name;
      QString  m_Address;
      PriorityType m_Priority;

};
```

**遍历该类的成员函数：**

```c++
ReflectionObject theObject;

const QMetaObject* theMetaObject =theObject.metaObject();

int methodIndex;

int methodCount = theMetaObject->methodCount();

for(methodIndex = 0; methodIndex < methodCount; ++methodIndex) {
      QMetaMethod oneMethod =theMetaObject->method(methodIndex);
      qDebug() <<"typeName: " <<oneMethod.typeName();
      qDebug() <<"signature: " <<oneMethod.signature();
      qDebug() <<"methodType: " <<oneMethod.methodType();
      qDebug() <<"parameterNames: " <<oneMethod.parameterNames() <<"\n";
}
```

其中 typeName 代表返回类型，signature 只的是函数的原貌，methodType 代表函数的类型，在 Qt 中分为三类（槽，信号，普通函数），parameterNames 代表函数参数

**遍历该类的成员变量：**

```c++
int propertyIndex;

int propertyCount = theMetaObject->propertyCount();

for(propertyIndex = 0; propertyIndex < propertyCount; ++propertyIndex){
      QMetaProperty oneProperty =theMetaObject->property(propertyIndex);
      qDebug() <<"name: " << oneProperty.name();
      qDebug() <<"type: " <<oneProperty.type() <<"\n";
}
```

**遍历该类的枚举集合：**

```c++
int enumeratorIndex;
int enumeratorCount = theMetaObject->enumeratorCount();
for(enumeratorIndex = 0; enumeratorIndex < enumeratorCount; ++enumeratorIndex){
      QMetaEnum oneEnumerator =theMetaObject->enumerator(enumeratorIndex);
      int enumIndex;
      int enumCount = oneEnumerator.keyCount();
      for(enumIndex = 0;enumIndex < enumCount; ++enumIndex)
      {
          qDebug() <<oneEnumerator.key(enumIndex) <<" ==> " <<oneEnumerator.value(enumIndex);
      }
}
```

这里我们看到 QMetaEnum 存在 key、value 配对出现，这必然可以互转，而 QMetaEnum 确实提供了方式：valueToKey()、keyToValue()。

## **反射的应用**

反射反射，就我目前的认知水平来看，通过使用字符串，来实现函数的通用化调用，例如你可以利用反射把很多函数放置到数组中，实现一次遍历，全部调用。

目前见到的大多是利用反射来操作数据库，例如 hibernate，其实可以利用 Qt 的反射，快速实现所谓的 hibernate。

## Q_INVOKABLE简单测试

`reflectdatatest.h` 文件

```c++
#ifndef REFLECTDATATEST_H
#define REFLECTDATATEST_H

#include <QObject>
#include <QDebug>

class ReflectDataTest : public QObject
{
    Q_OBJECT
public:
    explicit ReflectDataTest(QObject *parent = nullptr);

    Q_INVOKABLE  void printTest()
    {
        qDebug() << __FUNCTION__ << __LINE__ << "  : Q_INVOKABLE test";
    }
};

#endif // REFLECTDATATEST_H
```

`reflectdatatest.cpp` 文件

```c++
#include "reflectdatatest.h"

ReflectDataTest::ReflectDataTest(QObject *parent) : QObject(parent)
{

}
```

`main.cpp` 调用

```c++
#include "mainwindow.h"

#include <QApplication>
#include <QMetaObject>

#include "reflectdatatest.h"

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
//    MainWindow w;
//    w.show();

    ReflectDataTest r;
    QMetaObject::invokeMethod(&r, "printTest");

    return a.exec();
}
```

## 测试结果输出

ReflectDataTest::printTest 16 : Q_INVOKABLE test
