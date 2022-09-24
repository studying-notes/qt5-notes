---
date: 2022-09-24T08:13:58+08:00  # 创建日期
author: "Rustle Karl"  # 作者

title: "QeventLoop 事件循环"  # 文章标题
url:  "posts/qt5/libraries/standard/Qt/Core/QEventLoop"  # 设置网页永久链接
tags: [ "qt5", "qevent-loop" ]  # 标签
categories: [ "Qt5 学习笔记" ]  # 分类

toc: true  # 目录
draft: true  # 草稿
---

## 事件与事件循环

### 单个处理

```cpp
#include <stdio.h>

int main(int argc, char *argv[]) {
  printf("Hello World");
  return 0;
}
```

这是一段最简单的命令行程序，运行起来会在终端输出”Hello World”，之后程序就退出了。

### 循环处理

下面的程序能够一直运行，每次用户输入一些信息并按下回车时，打印出用户的输入。直到输入的内容为 “quit” 时才退出。

```cpp
#include <stdio.h>
#include <string.h>

int main(int argc, char *argv[]) {
  char input[1024];
  const char cmdQuit[] = "quit";
  bool quit = false;
  while (!quit) {
    scanf("%s", input);
    printf("user input: %s\n", input);
    if (0 == memcmp(input, cmdQuit, sizeof cmdQuit)) {
      quit = true;
    }
  }
  return 0;
}
```

### 类比事件循环的概念

在上面这个例子中，“用户输入并按下回车”这件事情，我们可以称作一个“事件”或者“用户输入事件”，不停的去处理“事件”的这段代码，我们可以称作“事件循环”, 也可以叫做”消息循环”。

一般对于带 UI 窗口的程序来说，“事件”是由操作系统或程序框架在不同的时刻发出的。

当用户按下鼠标、敲下键盘，或者是窗口需要重新绘制的时候，计时器触发的时候，都会发出一个相应的事件。

我们把“事件循环”的代码提炼/抽象如下：

```cpp
function loop() {
    initialize();
    bool shouldQuit = false;
    while(false == shouldQuit)
    {
        var message = get_next_message();
        process_message(message);
        if (message == QUIT) 
        {
            shouldQuit = true;
        }
    }
}
```

在事件循环中, 不停地去获取下一个事件，然后做出处理。直到quit事件发生，循环结束。

有“取事件”的过程，那么自然有“存储事件”的地方，要么是操作系统存储，要么是软件框架存储。

存储事件的地方，我们称作 “事件队列” Event Queue。

处理事件，我们也称作 “事件分发” Event Dispatch。

### 不同操作系统的事件循环

#### Windows

Windows 系统的事件循环示例：

```cpp
    MSG msg = { 0 };
    bool done = false;
    bool result = false;
    while (!done)
    {
        if (PeekMessage(&msg, 0, 0, 0, PM_REMOVE))
        {
            TranslateMessage(&msg);
            DispatchMessage(&msg);
        }
        if (msg.message == WM_QUIT)
        {
            done = true;
        }
    }
```

#### Linux X11 窗口

有些 linux 系统使用 X11 窗口系统，看看其窗口事件循环：

```cpp
Atom wmDeleteMessage = XInternAtom(mDisplay, "WM_DELETE_WINDOW", False);
XSetWMProtocols(display, window, &wmDeleteMessage, 1);

XEvent event;
bool running = true;

while (running)
{
    XNextEvent(display, &event);

    switch (event.type)
    {
        case Expose:
            printf("Expose\n");
            break;

        case ClientMessage:
            if (event.xclient.data.l[0] == wmDeleteMessage)
                running = false;
            break;

        default:
            break;
    }
}
```

#### MacOS

在 Cocoa Application 中，有一种获取事件的机制，叫做 runloop( 一个 NSRunLoop 对象，它允许进程接收窗口服务的各种事件 ) 。

一般的 Cocoa Application 运行流程是，从 runloop 的事件队列中获取一个事件 (NSEvent) 派发事件 (NSEvent) 到合适的对象 (Object) 事件被处理完成后，再取下一个事件 (NSEvent)，直到应用退出。

## Qt 的事件循环

Qt 作为一个跨平台的 UI 框架，其事件循环实现原理，就是把不同平台的事件循环进行了封装，并提供统一的抽象接口。

### QEventLoop 类

QEventLoop 即 Qt 中的事件循环类，主要接口如下：

```cpp
int exec(QEventLoop::ProcessEventsFlags flags = AllEvents)
void exit(int returnCode = 0)
bool isRunning() const
bool processEvents(QEventLoop::ProcessEventsFlags flags = AllEvents)
void processEvents(QEventLoop::ProcessEventsFlags flags, int maxTime)
void wakeUp()
```

其中 exec 是启动事件循环，调用 exec 以后，调用 exec 的函数就会被“阻塞”，直到 EventLoop 里面的 while 循环结束。

![示意图](https://pic1.zhimg.com/v2-00ab750f452a75b744c7224f6552cae4_r.jpg)

exit 是退出事件循环 ( 将 EventLoop 中的退出标识设为 true)。

processEvents 是及时处理队列中的事件 ( 这个很有用，后面还会讲 )。

这里有个问题，exec 阻塞了当前函数，还怎么退出 EventLoop 呢？

在派发事件后，某个事件处理的函数中，达到事件退出条件时，调用 exit 函数，将 EventLoop 中的退出标识设为 true。

这样的程序运行流程，我们叫做 “事件驱动”式的程序。

### QCoreApplication 主事件循环

一般的 Qt 程序，main 函数中都有一个 QCoreApplication/QGuiApplication/QApplication，并在末尾调用 exec。

```cpp
int main(int argc, char *argv[])
{
    QCoreApplication app(argc, argv);
    return app.exec();
}
```

Application 类中，除去启动参数、版本等相关东西后，关键就是维护了一个 QEventLoop，Application 的 exec 就是 QEventLoop 的 exec。

不过 Application 中的这个 EventLoop，我们称作“主事件循环” Main EventLoop。

所有的事件分发、事件处理都从这里开始。

Application 还提供了 sendEvent 和 poseEvent 两个函数，分别用来发送事件。

sendEvent 发出的事件会立即被处理，也就是“同步”执行。

postEvent 发送的事件会被加入事件队列，在下一轮事件循环时才处理，也就是“异步”执行。

还有一个特殊的 sendPostedEvents，是将已经加入队列中的准备异步执行的事件立即同步执行。

## Qt 的事件分发和事件处理

以 QWidget 为例来说明。

QWidget 是 Widget 框架中，大部分 UI 组件的基类。QWidget 类拥有一些名字为 xxxEvent 的虚函数, 比如：

```cpp
virtual void keyPressEvent(QKeyEvent *event)
virtual void keyReleaseEvent(QKeyEvent *event)
```

keyPressEvent 就表示按键按下时的处理，keyReleaseEvent 表示按键松开时的处理。

主事件循环中 ( 注册过 QWidget 类之后 )，事件分发会在按键按下时调用 QWidget 的 keyPressEvent 函数，按键松开时调用 QWidget 的 keyReleaseEvent 函数。

### 重载事件

有了上面的事件处理机制，我们就可以在自己的 QWidget 子类中，通过重载 keyPressEvent、keyReleaseEvent 等等事件处理函数，做一些自定义的事件处理。

### QEvent

每一个事件处理函数，都是带有参数的，这个参数是 QEvent 的子类，携带了各种事件的参数。比如按键事件 `void keyPressEvent(QKeyEvent * event)` 中的 QKeyEvent，就包括了按下的按键值 key、 count 等等。

### 事件过滤器

Qt 还提供了事件过滤机制，在事件分发之前先过滤一部分事件。

```cpp
class KeyPressEater : public QObject
{
    Q_OBJECT
    ...

protected:
    bool eventFilter(QObject *obj, QEvent *event) override;
};

bool KeyPressEater::eventFilter(QObject *obj, QEvent *event)
{
    if (event->type() == QEvent::KeyPress) {
        QKeyEvent *keyEvent = static_cast<QKeyEvent *>(event);
        qDebug("Ate key press %d", keyEvent->key());
        return true;
    } else {
        // standard event processing
        return QObject::eventFilter(obj, event);
    }
}

monitoredObj->installEventFilter(filterObj);
```

自定义一个 QObject 子类，重载 eventFilter 函数。之后在要过滤的 QObject 对象上，调用 installEventFilter 函数以安装过滤器上去。

过滤器函数的返回值为 bool，true 表示这个事件被过滤掉了，不用再往下分发了。false 表示没有过滤。

## 事件循环的运用

### processEvents 不阻塞 UI

我们的 UI 界面，要持续不断地刷新（对于 QWidget 就是触发 paintEvent 事件），以保证显示流畅、能及时响应用户输入。

一般要有一个良好的帧率，比如每秒刷新 60 帧，即经常说的 FPS 60，换算一下 1000 ms/ 60≈16 ms，也就是每隔 16 毫秒刷新一次。

而我们有时候又需要做一些复杂的计算，这些计算的耗时远远超过了 16 毫秒。

在没有计算完成之前，函数不会退出（相当于阻塞），事件循环得不到及时处理，就会发生 UI 卡住的现象。

这种场景下，就可以使用 Qt 为我们提供的接口，立即处理一次事件循环，来保证 UI 的流畅

```cpp
//耗时操作
someWork1()

//适当的位置，插入一个processEvents，保证事件循环被处理
QCoreApplication::processEvents();

//耗时操作
someWork2()
```

### QEventLoop 模拟同步调用

经常会有这种场景： “触发 ”了某项操作，必须等该操作完成后才能进行“ 下一步 ”。

比如：软件的登录界面，向服务器发起登录请求后，必须等收到服务器返回的登录数据，才知道登录结果并决定下一步如何执行。

这种场景，如果设计成异步调用，直接用 Qt 的信号/槽即可，如果要设计成同步调用，就可以使用本地 QEventLoop。

示例：

```cpp
void login(const QString &username, const QString &password) {
  QNetworkAccessManager *manager = new QNetworkAccessManager;
  QNetworkRequest request;
  request.setUrl(QUrl("http://192.168.0.16:28082/get"));
  request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
  request.setHeader(QNetworkRequest::ContentLengthHeader, 0);
  request.setRawHeader("username", username.toUtf8());
  request.setRawHeader("password", password.toUtf8());

  QNetworkReply *reply = manager->get(request);

  QObject::connect(reply, &QNetworkReply::finished, [=]() {
    qDebug() << reply->readAll();
    reply->deleteLater();
  });

  QEventLoop loop;
  QObject::connect(reply, &QNetworkReply::finished, [&loop]() {
    loop.quit();
  });

  loop.exec();
}
```

```cpp

```
