---
date: 2022-02-15T17:01:20+08:00  # 创建日期
author: "Rustle Karl"  # 作者

# 文章
title: "Qt5 学习笔记"  # 文章标题
description: "纸上得来终觉浅，学到过知识点分分钟忘得一干二净，今后无论学什么，都做好笔记吧。"
url:  "posts/qt5/README"  # 设置网页永久链接
tags: [ "Qt5", "README" ]  # 标签
series: [ "Qt5 学习笔记" ]  # 系列
categories: [ "学习笔记" ]  # 分类

index: true  # 是否可以被索引
toc: true  # 是否自动生成目录
draft: false  # 草稿
---

# Qt5 学习笔记

> 纸上得来终觉浅，学到过知识点分分钟忘得一干二净，今后无论学什么，都做好笔记吧。

不太习惯 Qt Creator 或者 Visual Studio（快捷键无法适应，界面不方便，代码提示太弱了），所以示例代码全部用 VSCode/Clion + CMake 编写，大部分情况只用 VSCode + CMake 即可。

## 目录结构

- `assets/images`: 笔记配图
- `assets/templates`: 笔记模板
- `docs`: 基础语法
- `libraries`: 库
  - `libraries/standard`: 标准库
  - `libraries/tripartite`: 第三方库
- `quickstart`: 基础用法
- `src`: 源码示例
  - `src/docs`: 基础语法源码示例
  - `src/libraries/standard`: 标准库源码示例
  - `src/libraries/tripartite`: 第三方库源码示例
  - `src/quickstart`: 基础用法源码示例

## 基础用法

- [用 windeployqt 进行 Qt 的打包发布](quickstart/release.md)



## 基础语法

### 第2章_模板库、工具类及控件

- [2.1_字符串类](docs/第2章_模板库、工具类及控件/2.1_字符串类.md)
- [2.2_容器类](docs/第2章_模板库、工具类及控件/2.2_容器类.md)
- [2.3_QVariant类](docs/第2章_模板库、工具类及控件/2.3_QVariant类.md)
- [2.4_算法及正则表达式](docs/第2章_模板库、工具类及控件/2.4_算法及正则表达式.md)
- [2.5_控件](docs/第2章_模板库、工具类及控件/2.5_控件.md)

### 第10章_Qt5网络与通信

- [10.1_获取本机网络信息](docs/第10章_Qt5网络与通信/10.1_获取本机网络信息.md)
- [10.2_基于UDP的网络广播程序](docs/第10章_Qt5网络与通信/10.2_基于UDP的网络广播程序.md)

### 第19章_QML编程基础

- [19.1_QML概述](docs/第19章_QML编程基础/19.1_QML概述.md)
- [19.2_QML可视元素](docs/第19章_QML编程基础/19.2_QML可视元素.md)
- [19.3_QML元素布局](docs/第19章_QML编程基础/19.3_QML元素布局.md)

### 第21章_QtQuickControls开发基础

- [21.1_QtQuickControls概述](docs/第21章_QtQuickControls开发基础/21.1_QtQuickControls概述.md)

### 其他

- [概念解析](quickstart/others/概念解析.md)

## 库

## 标准库

- [HTTP 请求](libraries/standard/network/http.md)
- [JSON 解析](libraries/standard/json.md)
- [QSharedMemory 共享内存段](libraries/standard/QSharedMemory.md)

## 第三方库
