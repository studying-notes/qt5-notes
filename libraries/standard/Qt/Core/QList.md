---
date: 2022-09-05T16:57:42+08:00  # 创建日期
author: "Rustle Karl"  # 作者

title: "Qt 列表容器类"  # 文章标题
url:  "posts/qt5/libraries/standard/Qt/Core/QList"  # 设置网页永久链接
tags: [ "qt5", "qlist" ]  # 标签
categories: [ "Qt5 学习笔记" ]  # 分类

toc: true  # 目录
draft: true  # 草稿
---

## 简介

Qt 提供了一组通用的基于模板的容器类。对比 C++ 的标准模板库中的容器类，Qt 的这些容器更轻量、更安全并且更容易使用。此外，Qt 的容器类在速度、内存消耗和内联(inline)代码等方面进行了优化（较少的内联代码将会减少可执行程序的大小）。

存储在 Qt 容器中的数据必须是可赋值的数据类型，也就是说，这种数据类型必须提供一个默认的构造函数（不需要参数的构造函数）、一个复制构造函数和一个赋值操作运算符。

这样的数据类型包含了通常使用的大多数数据类型，包括基本数据类型（如 int 和 double 等）和 Qt 的一些数据类型（如 QString、QDate 和 QTime 等）。

不过，Qt 的 QObject 及其他的子类（如 QWidget 和 Qdialog 等）是不能够存储在容器中的。因为这些类（QObject 及其他的子类）没有复制构造函数和赋值操作运算符。

一个可代替的方案是存储 QObject 及其子类的指针，例如：

```c++
QList<QToolBar*> list;
```

Qt的容器类是可以嵌套的，例如：

```c++
QHash<QString, QList<double> >
```

其中，QHash 的键类型是 QString，它的值类型是 `QList<double>`。注意，在最后两个“>”符号之间要保留一个空格，否则，C++ 编译器会将两个“>”符号解释为一个“>>”符号，导致无法通过编译器编译。

Qt 的容器类为遍历其中的内容提供了以下两种方法。

1. Java 风格的迭代器 (Java-style iterators)。
2. STL 风格的迭代器 (STL-style iterators)，能够同 Qt 和 STL 的通用算法一起使用，并且在效率上也略胜一筹。

## QList 类、QLinkedList 类和 QVector 类

经常使用的 Qt 容器类有 QList、QLinkedList 和 QVector 等。

表 2.1 列出了 QList、QLinkedList 和 QVector 容器的时间复杂度比较。

![](https://dd-static.jd.com/ddimg/jfs/t1/19050/34/17594/22216/6315f1beE79b859fb/e9d250b71faa7739.png)

其中，“Amort.O(1)”表示，如果仅完成一次操作，可能会有 O(n) 行为；但是如果完成多次操作（如 n 次），平均结果将会是 O(1)。

## QList 类

`QList<T>` 是迄今为止最常用的容器类，它存储给定数据类型 T 的一列数值。继承自 QList 类的子类有 QItemSelection、QQueue、QSignalSpy 及 QStringList 和 QTestEventList。

QList 不仅提供了可以在列表进行追加的 `QList::append()` 和 `Qlist::prepend()` 函数，还提供了在列表中间完成插入操作的函数 `QList::insert()`。相对于任何其他的 Qt 容器类，为了使可执行代码尽可能少，QList 被高度优化。

`QList<T>` 维护了一个指针数组，该数组存储的指针指向 `QList<T>` 存储的列表项的内容。因此，`QList<T>` 提供了基于下标的快速访问。
对于不同的数据类型，`QList<T>` 采取不同的存储策略，存储策略有以下几种。

1. 如果 T 是一个指针类型或指针大小的基本类型（即该基本类型占有的字节数和指针类型占有的字节数相同），`QList<T>` 会将数值直接存储在它的数组中。

2. 如果 `QList<T>` 存储对象的指针，则该指针指向实际存储的对象。

```c++
#include <QDebug>
int main(int argc,char *argv[])
{
    QList<QString> list;       //(a)
    {
        QString str("This is a test string");
        list<<str;         //(b)
    }            //(c)
    qDebug()<<list[0]<< "How are you! ";
    return 0;
}
```

其中，

(a) ` QList<QString> list`：声明了一个 `QList<QString>` 栈对象。
(b) ` list<<str`：通过操作运算符“<<”将一个 QString 字符串存储在该列表中。
(c) 程序中使用花括弧“{”和“}”括起来的作用域表明，此时 `QList<T>` **保存了对象的一个复制**。

### QLinkedList 类

`QLinkedList<T>` 是一个链式列表，它以非连续的内存块保存数据。
`QLinkedList<T>` 不能使用下标，只能使用迭代器访问它的数据项。

与 QList 相比，当对一个很大的列表进行插入操作时，QLinkedList 具有更高的效率。

### QVector 类

`QVector<T>` 在相邻的内存中存储给定数据类型 T 的一组数值。在一个 QVector 的前部或者中间位置进行插入操作的速度是很慢的，这是因为这样的操作将导致内存中的大量数据被移动，这是由 QVector 存储数据的方式决定的。

`QVector<T>` 既可以使用下标访问数据项，也可以使用迭代器访问数据项。继承自 QVector 类的子类有 QPolygon、QPolygonF 和 QStack。

```cpp

```
