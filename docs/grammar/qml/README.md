---
date: 2022-03-20T16:46:37+08:00
author: "Rustle Karl"  # 作者

title: "QML 基础语法"  # 文章标题
url:  "posts/qt5/docs/grammar/qml/README"  # 设置网页永久链接
tags: [ "qt5", "readme" ]  # 标签
categories: [ "Qt5 学习笔记" ]  # 分类

toc: true  # 目录
draft: true  # 草稿
---

## 简介

QML 是一种描述用户界面的声明式语言。它将用户界面分解成一些更小的元素，这些元素能够结合成一个组件。QML 语言描述了用户界面元素的形状和行为。用户界面能够使用 JavaScript 来提供修饰，或者增加更加复杂的逻辑。从这个角度来看它遵循 HTML-JavaScript 模式，但 QML 是被设计用来描述用户界面的，而不是文本文档。

从 QML 元素的层次结构来理解是最简单的学习方式。**子元素从父元素上继承了坐标系统**，它的 x,y 坐标总是**相对应于它的父元素坐标系统**。

## 语法

让我们开始用一个简单的 QML 文件例子来解释这个语法。

```c++
// main.qml

import QtQuick 2.0

// The root element is the Rectangle
Rectangle {
    // name this element root
    id: root

    // properties: <name>: <value>
    width: 120; height: 240

    // color property
    color: "#D8D8D8"

    // Declare a nested element (child of root)
    Image {
    	id: rocket

        // reference the parent
        x: (parent.width - width)/2; y: 40

        source: 'assets/rocket.png'
    }

    // Another child of root
    Text {
        // un-named element

        // reference element by id
        y: rocket.y + rocket.height + 20

        // reference root element
        width: root.width

        horizontalAlignment: Text.AlignHCenter
        text: 'Rocket'
    }
}
```

* import 声明导入了一个指定的模块版本。一般来说会导入 QtQuick2.0 来作为初始元素的引用。
* 使用 // 可以单行注释，使用 / ** / 可以多行注释，就像 C/C++ 和 JavaScript 一样。
* 每一个 QML 文件都需要一个根元素，就像 HTML 一样。
* 一个元素使用它的类型声明，然后使用 {} 进行包含。
* 元素拥有属性，他们按照 name:value 的格式来赋值。
* 任何在 QML 文档中的元素都可以使用它们的 id 进行访问（id 是一个任意的标识符）。
* 元素可以嵌套，这意味着一个父元素可以拥有多个子元素。子元素可以通过访问 parent 关键字来访问它们的父元素。

### 预览 QML

```
qmlscene main.qml
```

qmlscene 会执行 Qt Quick 运行环境初始化，并且解释这个 QML 文件。

## 属性

元素使用他们的元素类型名进行声明，使用它们的属性或者创建自定义属性来定义。一个属性对应一个值。一个属性有一个类型定义并且需要一个初始值。

```c++
    Text {
        // (1) identifier
        id: thisLabel

        // (2) set x- and y-position
        x: 24; y: 16

        // (3) bind height to 2 * width
        height: 2 * width

        // (4) custom property
        property int times: 24

        // (5) property alias
        property alias anotherTimes: thisLabel.times

        // (6) set text appended by value
        text: "Greetings " + times

        // (7) font is a grouped property
        font.family: "Ubuntu"
        font.pixelSize: 24

        // (8) KeyNavigation is an attached property
        KeyNavigation.tab: otherLabel

        // (9) signal handler for property changes
        onHeightChanged: console.log('height:', height)

        // focus is neeed to receive key events
        focus: true

        // change color based on focus value
        color: focus?"red":"black"
    }
```

让我们来看看不同属性的特点：

1. id 是一个非常特殊的属性值，它在一个 QML 文件中被用来引用元素。id 不是一个字符串，而是一个标识符和 QML 语法的一部分。一个 id 在一个 QML 文档中是唯一的，并且不能被设置为其它值，也无法被查询（它的行为更像 C++ 世界里的指针）。
2. 一个属性能够设置一个值，这个值依赖于它的类型。如果没有对一个属性赋值，那么它将会被初始化为一个默认值。你可以查看特定的元素的文档来获得这些初始值的信息。
3. 一个属性能够依赖一个或多个其它的属性，这种操作称作**属性绑定**。**当它依赖的属性改变时，它的值也会更新**。这就像订了一个协议，在这个例子中 height 始终是 width 的两倍。
4. 添加自己定义的属性需要使用 **property 修饰符**，然后跟上类型，名字和可选择的初始化值（`property <type> <name> : <value>`）。如果没有初始值将会给定一个系统初始值作为初始值。**注意如果属性名与已定义的默认属性名不重复，使用 default 关键字你可以将一个属性定义为默认属性。这在你添加子元素时用得着，如果他们是可视化的元素，子元素会自动的添加默认属性的子类型链表（children property list）**。
5. 另一个重要的声明属性的方法是使用 alias 关键字（property alias <name> : <reference>）。alias 关键字允许我们**转发一个属性或者转发一个属性对象自身到另一个作用域**。我们将在后面定义组件导出内部属性或者引用根级元素 id 会使用到这个技术。一个属性别名不需要类型，它使用引用的属性类型或者对象类型。
6. text 属性依赖于自定义的 timers（int 整型数据类型）属性。int 整型数据会自动的转换为 string 字符串类型数据。这样的表达方式本身也是另一种属性绑定的例子，文本结果会在 times 属性每次改变时刷新。
7. 一些属性是按组分配的属性。当一个属性需要结构化并且相关的属性需要联系在一起时，我们可以这样使用它。另一个组属性的编码方式是 `font { family: "Ubuntu"; pixelSize: 24 }`。
8. 一些属性是元素自身的附加属性。这样做是为了全局的相关元素在应用程序中只出现一次（例如键盘输入）。编码方式 `<element>.<property>: <value>` 。
9. 对于每个元素你都可以提供一个信号操作。这个操作在属性值改变时被调用。例如这里我们完成了当 height（高度）改变时会使用控制台输出一个信息。

一个元素 id 应该只在当前文档中被引用。QML 提供了动态作用域的机制，后加载的文档会覆盖之前加载文档的元素 id 号，这样就可以引用已加载并且没有被覆盖的元素 id，这有点类似创建全局变量。但不幸的是这样的代码阅读性很差。目前这个还没有办法解决这个问题，所以你使用这个机制的时候最好仔细一些甚至不要使用这种机制。如果你想向文档外提供元素的调用，你可以在根元素上使用属性导出的方式来提供。

## 脚本

QML 与 JavaScript 是最好的配合。

```c++
    Text {
        id: label

        x: 24; y: 24

        // custom counter property for space presses
        property int spacePresses: 0

        text: "Space pressed: " + spacePresses + " times"

        // (1) handler for text changes
        onTextChanged: console.log("text changed to:", text)

        // need focus to receive key events
        focus: true

        // (2) handler with some JS
        Keys.onSpacePressed: {
            increment()
        }

        // clear the text on escape
        Keys.onEscapePressed: {
            label.text = ''
        }

        // (3) a JS function
        function increment() {
            spacePresses = spacePresses + 1
        }
    }
```

1. 文本改变操作 onTextChanged 会将每次空格键按下导致的文本改变输出到控制台。
2. 当文本元素接收到空格键操作（用户在键盘上点击空格键），会调用 JavaScript 函数 increment()。
3. 定义一个 JavaScript 函数使用这种格式 `function (){....}`，在这个例子中是增加 spacePressed 的计数。每次 spacePressed 的增加都会导致它绑定的属性更新。

QML 的属性绑定与 JavaScript 的 = 赋值是不同的。绑定是一个协议，并且存在于整个生命周期。然而 JavaScript 赋值只会产生一次效果。当一个新的绑定生效或者使用 JavaScript 赋值给属性时，绑定的生命周期就会结束。
