---
date: 2022-02-18T10:48:21+08:00
author: "Rustle Karl"

title: "用 windeployqt 进行 Qt 的打包发布"
url:  "posts/qt5/quickstart/release"  # 永久链接
tags: [ "Qt5", "C++" ]  # 标签
series: [ "Qt5 学习笔记" ]  # 系列
categories: [ "学习笔记" ]  # 分类

toc: true  # 目录
draft: false  # 草稿
---

Qt 官方开发环境使用的动态链接库方式，在发布生成的 exe 程序时，需要复制一大堆 dll，如果自己去复制 dll，很可能丢三落四，导致 exe 在别的电脑里无法正常运行。

因此 Qt 官方开发环境里自带了一个工具：windeployqt.exe。

## 问题的提出

既然是要发布自己的程序，那么就需要，在 Release 中编译运行。具体方法如下图所示。

1. 点击 qt 界面左下角的图标；
2. 选择 Release ；
3. 点击编译运行即可；

![img](http://dd-static.jd.com/ddimg/jfs/t1/168363/29/27916/89104/620f0943Eda8c9b5e/621e730a206d61a7.png)

生成的程序运行正常之后，找到项目的生成目录。

![img](http://dd-static.jd.com/ddimg/jfs/t1/126914/23/21794/58548/620f0943E49a0a130/f16d801060fb0e7a.png)

我们可以发现，此时点击 .exe 文件是会出问题的，解决办法如下。

## 用 windeployqt 进行打包发布

1. 首先进入上图中这个文件夹，在里面，找到 DiyName.exe，将这个.exe 复制到一个新的单独的文件夹里用于发布。

![img](http://dd-static.jd.com/ddimg/jfs/t1/132509/39/24836/44188/620f0943E31a6e247/6033adfd94d23ae8.png)

此时，这个文件只一个有刚刚从 release 文件夹下，复制过来的.exe 文件。

2. 以官方 Qt 5.8.0+MinGW 开发环境为例，可以打开 Qt 命令行，从这里就可以执行 windeployqt 工具。必须是一致的开发环境。

![img](http://dd-static.jd.com/ddimg/jfs/t1/219675/8/12752/12990/620f0943E2bf25b9a/aa4ab50ee76716f1.png)

3. 从开始菜单打开 Qt 命令行，输入命令 ：

```
cd /d AppDir
```

4. 用 windeployqt 命令：

```
windeployqt App.exe
```

![img](http://dd-static.jd.com/ddimg/jfs/t1/102412/5/23573/44188/620f0943E9fd9921a/eec3e171f1009ea1.png)
