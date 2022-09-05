import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.1
import QtQuick.Layouts 1.1

ApplicationWindow {
    id: window
    visible: true
    width: 640
    height: 480
    title: qsTr("Drawer")

    header: ToolBar {}

    Drawer {
        id: drawer
        width: 0.66 * window.width
        height: window.height

        Label {
            text: "Content goes here!"
            anchors.centerIn: parent
        }

        background: Rectangle {
            Rectangle {
                x: parent.width - 1
                width: 1
                height: parent.height
                color: "#21be2b"
            }
        }
    }

    Label {
        id: content

        text: "Aa"
        font.pixelSize: 96
        anchors.fill: parent
        verticalAlignment: Label.AlignVCenter
        horizontalAlignment: Label.AlignHCenter

        transform: Translate {
            x: drawer.position * content.width * 0.33
        }
    }

    Component.onCompleted: {

    }
}
