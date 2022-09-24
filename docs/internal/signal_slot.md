---
date: 2022-09-24T11:26:56+08:00  # 创建日期
author: "Rustle Karl"  # 作者

title: "Qt 信号与槽"  # 文章标题
url:  "posts/qt5/docs/internal/signal_slot"  # 设置网页永久链接
tags: [ "qt5", "signal-slot" ]  # 标签
categories: [ "Qt5 学习笔记" ]  # 分类

toc: true  # 目录
draft: true  # 草稿
---

## 对象之间的通信机制

提供一种对象之间的通信机制。这种机制，要能够给两个不同对象中的函数建立映射关系，前者被调用时后者也能被自动调用。

再深入一些，两个对象都互相不知道对方的存在，仍然可以建立联系。甚至一对一的映射可以扩展到多对多，具体对象之间的映射可以扩展到抽象概念之间。

### 直接调用

前者知道后者有一个函数，然后主动调用。

### 回调函数映射表

通过一个标识符，从映射表中找到函数，然后调用，属于间接调用。

```cpp
#include <functional>
#include <map>

class Connections {
public:
  // 建立映射关系
  void connect(const std::string &key, const std::function<void()> &func) {
    funcs[key] = func;
  }

  void invoke(const std::string &key) {
    auto f = funcs.find(key);
    if (f != funcs.end()) {//迭代器判断
      f->second();         //迭代器有效的情况，直接调用
    }
  }

private:
  std::map<std::string, std::function<void()>> funcs;
};

static Connections s_connections;

class A {
public:
  void Run() {
    s_connections.invoke("key");
  }
};

class B {
public:
  B() {
    //在构造函数中，建立映射关系
    s_connections.connect("key", [this] { RunAway(); });
  }
  void RunAway() {}
};
```

### 观察者模式

或者叫发布订阅模式。

```cpp
#pragma once
#include <algorithm>
#include <functional>
#include <iostream>
#include <vector>

template<typename ObserverType>
class Subject {
public:
  void subscribe(ObserverType *obs) {
    auto o = std::find(m_observerList.begin(), m_observerList.end(), obs);
    if (m_observerList.end() == o) {
      m_observerList.push_back(obs);
    }
    std::cout << "subscribe: " << obs << std::endl;
  }

  void unsubscribe(ObserverType *obs) {
    m_observerList.erase(std::remove(m_observerList.begin(), m_observerList.end(), obs));
    std::cout << "unsubscribe: " << obs << std::endl;
  }

  template<typename FuncType>
  void publish(FuncType func) {
    for (auto obs : m_observerList) {
      func(obs);
    }
  }

private:
  std::vector<ObserverType *> m_observerList;
};

class AObserver {
public:
  virtual void onA() = 0;
  virtual ~AObserver() = default;
};

class B : public Subject<AObserver> {
public:
  void run() {
    std::cout << "B::run" << std::endl;
    //    publish(std::bind(&AObserver::onA, std::placeholders::_1));
    publish([](auto &&PH1) { PH1->onA(); });
  }
};

class A : public AObserver {
public:
  void onA() override {
    RunAway();
  }

  void RunAway() {
    std::cout << "A::RunAway" << std::endl;
  }
};

int main() {
  B b;
  A a;
  b.subscribe(&a);
  b.run();
  return 0;
}
```

任意类只要继承 Subject 模板类，提供观察者参数，就拥有了发布订阅功能。

## Qt 的信号与槽

### 简介

信号与槽是 Qt 自定义的一种通信机制，通过 connect 函数把信号与槽连接起来。

![信号与槽](https://pic4.zhimg.com/v2-29412691dc6685a8a7ac558c37494dc3_r.jpg)

连接的时候，前面的是发送者，后面的是接收者。

信号与信号也可以连接，这种情况把接收者信号看做槽即可，相当于转发信号。

### 分类

信号-槽要分成两种来看待，一种是同一个线程内的信号-槽，另一种是跨线程的信号-槽。

同一个线程内的信号-槽，就相当于函数调用，和前面的观察者模式相似，只不过信号-槽稍微有些性能损耗。

跨线程的信号-槽，在信号触发时，发送者线程将槽函数的调用转化成了一次“调用事件”，放入事件循环中。

接收者线程执行到下一次事件处理时，处理“调用事件”，调用相应的函数。

### 实现

信号-槽的实现，借助一个工具：元对象编译器 MOC(Meta Object Compiler)。

这个工具被集成在了 Qt 的编译工具链 qmake 中，在开始编译 Qt 工程时，会先去执行 MOC，从代码中解析 signals、slot、emit 等等这些标准 C/C++ 不存在的关键字，以及处理 Q_OBJECT、Q_PROPERTY、Q_INVOKABLE 等相关的宏，生成一个 moc_xxx.cpp 的 C++ 文件。

比如信号函数只要声明、不需要自己写实现，就是在这个 moc_xxx.cpp 文件中，自动生成的。

MOC 之后就是常规的 C/C++ 编译、链接流程了。

MOC 的本质，其实是一个反射器。

什么叫反射呢？ 简单来说，就是运行过程中，获取对象的构造函数、成员函数、成员变量。

设计模式中的“工厂模式”，就是一个典型的反射案例。不过工厂模式只解决了构造函数的调用，没有成员函数、成员变量等信息。

反射包括编译期静态反射和运行期动态反射。

```cpp

```
