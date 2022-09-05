---
date: 2022-02-18T10:48:21+08:00
author: "Rustle Karl"  # 作者

title: "Windows 平台 Qt 的打包发布"  # 文章标题
url:  "posts/qt5/quickstart/deployqt/windows"  # 设置网页永久链接
tags: [ "qt5", "windows" ]  # 标签
categories: [ "Qt5 学习笔记" ]  # 分类

toc: true  # 目录
draft: true  # 草稿
---

Qt 官方开发环境使用的动态链接库方式，在发布生成的 exe 程序时，需要复制一大堆 dll，如果自己去复制 dll，很可能丢三落四，导致 exe 在别的电脑里无法正常运行。

因此 Qt 官方开发环境里自带了一个工具：windeployqt.exe。

## 命令示例

```bash
windeployqt --release --qmldir C:/Qt/Qt5.12.6/5.12.6/mingw73_32/qml example.exe
```
