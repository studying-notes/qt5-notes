import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.1
import QtQuick.Layouts 1.1

Window {
    id: window
    visible: true
    width: 640
    height: 480
    title: qsTr("Progress Bar Label")

    ProgressBar {
        value: 0.05
        padding: 0
        anchors.centerIn: parent

        background: Rectangle {
            implicitWidth: 200
            implicitHeight: 8
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
            anchors.bottom: parent.top
            anchors.bottomMargin: 5
            anchors.left: parent.left
            anchors.leftMargin: parent.visualPosition * parent.width

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

    Component.onCompleted: {

    }
}
