---
date: 2022-03-08T13:03:31+08:00
author: "Rustle Karl"

title: "QSharedMemory 共享内存段"
url:  "posts/qt5/libraries/standard/QSharedMemory"  # 永久链接
tags: [ "Qt5", "C++" ]  # 标签
series: [ "Qt5 学习笔记" ]  # 系列
categories: [ "学习笔记" ]  # 分类

toc: true  # 目录
draft: false  # 草稿
---

## QSharedMemory介绍

QSharedMemory 提供了多个线程和进程对共享内存段的访问。它还提供了一种方法，让单个线程或进程锁定内存以进行独占访问。

当使用这个类时，请注意以下平台差异:

- Windows : QSharedMemory 不“拥有”共享内存段。当有 QSharedMemory 实例附加到特定共享内存段的所有线程或进程销毁了它们的 QSharedMemory 实例或者退出了，Windows 内核会自动释放共享内存段。
- Unix : QSharedMemory“拥有”共享内存段。当最后一个线程或进程将一个 QSharedMemory 实例附加到一个特定的共享内存段时，通过销毁它的 QSharedMemory 实例从这个段中分离出来，Unix 内核释放这个共享内存段。但是如果最后一个线程或进程在没有运行 QSharedMemory 析构函数的情况下崩溃了 ( 未释放 )，共享内存段会在崩溃时幸存下来。

在对共享内存进行读写操作之前，记得使用 lock() 锁定共享内存，并且记得在操作完成后使用 unlock() 释放锁。

它的构造函数如下所示:

```javascript
QSharedMemory(const QString &key, QObject *parent = nullptr)
```

通过指定的 parent 和 key，构造一个共享内存对象。由于 key 已经被设置，所以不需要再调用 setKey() 或 setNativeKey() 指定要访问的内存块了,create() 和 attach() 就可以被调用了。

其它常用函数如下所示:

```c++
QString QSharedMemory::key() const
//返回被setKey()所赋值的key如果未设置key则返回空字符串,如果应用程序是和非Qt平台的,则需要使用nativeKey()访问

bool QSharedMemory::lock()
//用来锁定共享内存的互斥值，锁住成功则返回true. 若另一个进程已经锁住了共享内存段，本函数将会阻塞直到锁被另一个进程释放。到那时，本函数才会获得锁并返回true. 如果本函数返回false，那就说明你已经忽略了一个由create()或attach()返回的false，而其原因可能是由于某个系统错误而导致setNativeKey()或QSystemSemaphore::acquire()失败。

bool QSharedMemory::unlock()
//释放共享内存段上的锁并返回true，如果共享内存段没有被lock，或者如果锁被其他进程持有，本函数什么都不会做而只是返回false. 

bool QSharedMemory::create(int size, AccessMode mode=ReadWrite)
//创建一个大小为size个字节的共享内存段, 然后用给定的访问模式mode附着到共享内存上。Mode取值有以下几种:
QSharedMemory::ReadOnly // 共享内存段是只读的。不允许写入共享内存段。尝试写入使用ReadOnly创建的共享内存段会导致程序中止。
QSharedMemory::ReadWrite // 允许对共享内存段进行读写操作。

bool QSharedMemory::attach(AccessMode mode = ReadWrite)
//尝试将进程附加到由传递给构造函数或调用setKey()或setNativeKey()的键标识的共享内存段上。默认访问模式为“ReadWrite”。也可以是ReadOnly。如果附加操作成功，则返回true。如果返回false，则调用error()或者errorString()来确定发生了哪个错误。在附加共享内存段成功之后，则可以通过调用data()来获得一个指向共享内存的指针。

bool QSharedMemory::isAttached() const
//如果该进程附加到共享内存段，则返回true。

bool QSharedMemory::detach()
//将进程从共享内存段中分离。如果这是连接到共享内存段的最后一个进程，那么共享内存段将被系统释放，也就是说，内容将被销毁。如果函数分离了共享内存段，则返回true。如果它返回false，通常意味着该段没有连接，或者被另一个进程锁定。

void * QSharedMemory::data()
//如果附加了共享内存段，则返回指向共享内存段内容的指针。否则返回null。在对共享内存进行读写操作之前，记得使用lock()锁定共享内存，并且记得在操作完成后使用unlock()释放锁。
```

## QSharedMemory示例

界面如下所示:

![](http://dd-static.jd.com/ddimg/jfs/t1/211869/24/14340/20307/6226e468Ee0dc0e64/546f0e8993737c95.png)

写内存 widget 示例代码如下所示:

```c++
#include "widget.h"
#include "ui_widget.h"
#include <QDebug>
#include <QTextEdit>
#include <QByteArray>
Widget::Widget(QWidget *parent)
    : QWidget(parent)
    , ui(new Ui::Widget),
      sharememory("shareTest", this)
{
    ui->setupUi(this);

}

Widget::~Widget()
{
    delete ui;
}


void Widget::on_textEdit_textChanged()
{

    if(sharememory.isAttached()) {
        sharememory.detach();
    }
    QByteArray arr = ui->textEdit->toPlainText().toLocal8Bit();
    int len = arr.length();
    qDebug()<<ui->textEdit->toPlainText()<<len;
    if(!sharememory.create(len)) {
        qDebug() << sharememory.errorString();
        return ;
    }
    sharememory.lock();
    char *dest = reinterpret_cast<char *>(sharememory.data());
    for (int i = 0; i < len; i++) {
        dest[i] = arr[i];
    }
    sharememory.unlock();
}
```

读内存 widget 示例代码如下所示:

```c++
#include "widget.h"
#include "ui_widget.h"
#include <QDebug>
#include <QTextEdit>
#include <QTimer>
#include <QByteArray>


Widget::Widget(QWidget *parent)
    : QWidget(parent)
    , ui(new Ui::Widget),
      sharememory("shareTest", this)
{
    ui->setupUi(this);
    QTimer *timer = new QTimer(this);
    connect(timer, SIGNAL(timeout()), this, SLOT(timeout()));
    timer->start(200);

}


void Widget::timeout()
{

    if (!sharememory.isAttached()) {
        if (!sharememory.attach()) {
            qDebug() << sharememory.errorString();
        } else {
            sharememory.lock();
            QByteArray arr((char*)sharememory.data(), sharememory.size());
            ui->textEdit->setPlainText(QString(arr));
            sharememory.unlock();
            sharememory.detach();
        }
    }

}

Widget::~Widget()
{
    delete ui;
}
```

**3.Linux下查看共享内存**

1、查看共享内存，使用命令：ipcs -m

2、删除共享内存，使用命令：ipcrm -m [shmid]

如下图所示:

![](http://dd-static.jd.com/ddimg/jfs/t1/144458/38/24808/129337/6226e48eE7cf9416b/c98ca1ce09f47d13.png)

1、key：共享内存的key

2、shmid：共享内存的编号

3、owner：共享内存的创建用户

4、perms：共享内存的权限

5、bytes：共享内存的大小

6、nattch：连接到共享内存的进程数

7、status：共享内存的状态
