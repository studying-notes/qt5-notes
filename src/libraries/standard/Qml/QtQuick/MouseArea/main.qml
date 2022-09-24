import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

Window {
    id: window
    visible: true
    width: 640
    height: 480
    title: qsTr("Mouse Area")

    // 左键右键单击改变属性
    Rectangle {
        width: 100
        height: 100
        color: "green"

        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton | Qt.RightButton
            onClicked: mouse => {
                           if (mouse.button === Qt.RightButton)
                           parent.color = 'blue'
                           else
                           parent.color = 'red'
                       }
        }
    }

    // 在坐标轴上拖动改变属性
    Rectangle {
        x: 120
        id: container
        width: 402
        height: 52

        border.width: 1

        Rectangle {
            id: rect
            x: 1
            y: 1
            width: 50
            height: 50
            color: "red"
            opacity: (600.0 - rect.x) / 600

            MouseArea {
                anchors.fill: parent
                drag.target: rect
                drag.axis: Drag.XAxis
                drag.minimumX: 1
                drag.maximumX: container.width - rect.width - 1
            }
        }
    }

    Rectangle {
        x: 160
        y: 80
        width: 100
        height: 100
        color: "lightsteelblue"

        MouseArea {
            anchors.fill: parent
            drag.target: parent
            drag.axis: "XAxis"
            drag.minimumX: 50
            drag.maximumX: 350
            drag.filterChildren: true

            Rectangle {
                color: "yellow"
                x: 25
                y: 25
                width: 50
                height: 50
            }
        }
    }

    // 悬停进入退出改变属性
    Rectangle {
        x: 10
        y: 120
        width: 100
        height: 100
        border.width: 1
        color: "lightsteelblue"

        MouseArea {
            id: mouseArea1
            anchors.fill: parent
            hoverEnabled: true
        }

        MouseArea {
            id: mouseArea2
            width: 50
            height: 50
            anchors.centerIn: parent
            hoverEnabled: true

            onEntered:{
                parent.color = "red"
            }

            onExited:{
                parent.color = "lightsteelblue"
            }
        }
    }

    // 可拖动组件
    MouseAreaCustom {

    }

    Component.onCompleted: {

    }
}
