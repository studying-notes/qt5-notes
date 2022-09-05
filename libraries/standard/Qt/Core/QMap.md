---
date: 2022-09-05T21:25:48+08:00  # 创建日期
author: "Rustle Karl"  # 作者

title: "Qt 键值对容器类"  # 文章标题
url:  "posts/qt5/libraries/standard/Qt/Core/QMap"  # 设置网页永久链接
tags: [ "qt5", "qmap" ]  # 标签
categories: [ "Qt5 学习笔记" ]  # 分类

toc: true  # 目录
draft: true  # 草稿
---

## QMap 类和 QHash 类

QMap 类和 QHash 类具有非常类似的功能，它们的差别仅在于：

QHash 具有比 QMap 更快的查找速度。

QHash 以任意的顺序存储数据项，而 QMap 总是按照键 Key 顺序存储数据。

QHash 的键类型 Key 必须提供 `operator==()` 和一个全局的 `qHash(Key)` 函数，而 QMap 的键类型 Key 必须提供 `operator<()` 函数。

二者的时间复杂度比较见表 2.4。

![](https://dd-static.jd.com/ddimg/jfs/t1/59163/16/21873/19664/6315f1e0E678ff006/17fcd42faf127d88.png)

### QMap 类

`QMap<Key,T>` 提供了一个从类型为 Key 的键到类型为 T 的值的映射。

通常，QMap 存储的数据形式是一个键对应一个值，并且按照键 Key 的次序存储数据。

为了能够支持一键多值的情况，QMap 提供了 `QMap<Key,T>::insertMulti()` 和 `QMap<Key,T>::values()` 函数。

存储一键多值的数据时，也可以使用 `QMultiMap<Key,T>` 容器，它继承自 QMap。

### QHash 类

`QHash<Key,T>` 具有与 QMap 几乎完全相同的 API。QHash 维护着一张哈希表（Hash Table），哈希表的大小与 QHash 的数据项的数目相适应。

QHash 以任意的顺序组织它的数据。当存储数据的顺序无关紧要时，建议使用 QHash 作为存放数据的容器。QHash 也可以存储一键多值形式的数据，它的子类 `QMultiHash<Key,T>` 实现了一键多值的语义。
