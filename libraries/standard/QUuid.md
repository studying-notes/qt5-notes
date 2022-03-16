---
date: 2022-03-08T15:24:41+08:00
author: "Rustle Karl"

title: "QUuid 生成 UUID"
url:  "posts/qt5/libraries/standard/QUuid"  # 永久链接
tags: [ "Qt5", "C++" ]  # 标签
series: [ "Qt5 学习笔记" ]  # 系列
categories: [ "学习笔记" ]  # 分类

toc: true  # 目录
draft: false  # 草稿
---

https://doc.qt.io/qt-5/quuid.html

## 简单用法

```c++
#include <QUuid>

QUuid uuid = QUuid::createUuid();
QString uuidStr = uuid.toString();
qDebug() << uuidStr;
//输出结果："{b5eddbaf-984f-418e-88eb-cf0b8ff3e775}"

// 一般习惯去掉左右花括号和连字符
uuidStr.remove("{").remove("}").remove("-"); 
qDebug() << uuidStr;
//输出结果："b5eddbaf984f418e88ebcf0b8ff3e775"
```

```c++

```


## 二级

### 三级

```c++

```

```c++

```


## 二级

### 三级

```c++

```

```c++

```


## 二级

### 三级

```c++

```

```c++

```


## 二级

### 三级

```c++

```

```c++

```


