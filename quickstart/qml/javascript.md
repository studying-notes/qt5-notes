---
date: 2022-09-06T10:01:42+08:00  # 创建日期
author: "Rustle Karl"  # 作者

title: "在 JavaScript 文件中创建 QML 对象"  # 文章标题
url:  "posts/qt5/quickstart/qml/javascript"  # 设置网页永久链接
tags: [ "qt5", "javascript" ]  # 标签
categories: [ "Qt5 学习笔记" ]  # 分类

toc: true  # 目录
draft: true  # 草稿
---

## 示例

```js
function Timer(root) {
  return Qt.createQmlObject('import QtQuick 2.12; Timer {}', root);
}
```

```js
let timer = new Timer(root);

timer.interval = 3000;
timer.repeat = false;

timer.triggered.connect(function() {
    // TODO
});

timer.start();
```

```cpp

```
