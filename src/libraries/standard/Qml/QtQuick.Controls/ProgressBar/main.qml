import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.1
import QtQuick.Layouts 1.1
import Qt.labs.platform 1.1

import "main.js" as MainJS

Window {
    id: window
    visible: true
    width: 360
    height: 60
    title: qsTr("Progress Bar")

    ProgressBar {
        id: control
        value: 0.05
        padding: 2
        anchors.centerIn: parent

        background: Rectangle {
            implicitWidth: 200
            implicitHeight: 10
            color: "#e6e6e6"
            radius: 5
        }

        contentItem: Item {
            implicitWidth: 200
            implicitHeight: 8

            Rectangle {
                width: parent.parent.visualPosition * parent.width
                height: parent.height
                radius: 5
                color: "#1890ff"
            }
        }

        Label {
            anchors.left: parent.right
            anchors.leftMargin: 5
            anchors.verticalCenter: parent.verticalCenter

            color: "#1890ff"
            text: Math.round(parent.value * 100) + "%"
        }

        Timer {
            interval: 100
            running: true
            repeat: true
            onTriggered: {
                parent.value += 0.01
                if (parent.value > 1) {
                    parent.value = 0
                }
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.66}
}
##^##*/

