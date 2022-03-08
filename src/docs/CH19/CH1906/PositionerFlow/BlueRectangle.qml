/* 蓝色矩形，源文件BlueRectangle.qml */
import QtQuick 2.0
Rectangle {
    width: 80
    height: 50
    color: "blue"
    border.color: Qt.lighter(color)
}