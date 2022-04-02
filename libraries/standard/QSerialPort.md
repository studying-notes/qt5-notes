---
date: 2022-03-23T13:09:52+08:00
author: "Rustle Karl"

title: "QSerialPort 串口读写"
url:  "posts/qt5/libraries/standard/QSerialPort"  # 永久链接
tags: [ "Qt5", "C++" ]  # 标签
series: [ "Qt5 学习笔记" ]  # 系列
categories: [ "学习笔记" ]  # 分类

toc: true  # 目录
draft: false  # 草稿
---

```
QT += serialport
```

```c++
#include <QCoreApplication>
#include <QSerialPort>
#include <QSerialPortInfo>
#include<QDebug>

int main(int argc, char *argv[])
{
    QCoreApplication a(argc, argv);

    QSerialPort *serial=new QSerialPort;

    // 寻找显示目前的所有串口信息
    foreach (const QSerialPortInfo &info, QSerialPortInfo::availablePorts())
    {
        qDebug() << "Name : " << info.portName();
        qDebug() << "Description : " << info.description();
        qDebug() << "Manufacturer: " << info.manufacturer();
        qDebug() << "Serial Number: " << info.serialNumber();
        qDebug() << "System Location: " << info.systemLocation();
    }

    // 打开（关闭）串口
    serial->setPortName("COM1"); // 串口名称
    serial->open(QIODevice::ReadOnly); // 打开失败会返回 false
    // serial->clear(); //清除缓存区
    // serial->close(); //关闭串口

    // 配置参数
    serial->setBaudRate(QSerialPort::Baud4800);
    serial->setParity(QSerialPort::NoParity);
    serial->setStopBits(QSerialPort::OneStop);
    //serial->setFlowControl(QSerialPort::NoFlowControl);
    serial->setFlowControl(QSerialPort::HardwareControl);
    serial->setDataBits(QSerialPort::Data8);

    // 使用信号与槽读取串口


    return a.exec();
}
```

### 使用信号与槽读取串口

```c++
/***** 在头文件中声明该槽函数
private slots:
    void ReadData();
*******/
/***** 连接信号与槽
connect(s,&QSerialPort::readyRead,this,&MainWindow::ReadData);
******/
void MainWindow::ReadData()
{
    QByteArray buf;
    buf=s->readAll();
    if(!buf.isEmpty()) {
        QString str = buf;
        //std::cout  << str.toStdString() << std::endl;
        std::cout  << str.data() << std::endl;
        //qDebug()  << str;
    }
    buf.clear();
}
```

```c++

```

```c++

```

```c++

```

```c++

```

```c++

```

```c++

```

```c++

```

```c++

```
