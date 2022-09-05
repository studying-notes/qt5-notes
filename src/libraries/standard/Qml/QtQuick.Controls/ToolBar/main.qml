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
    title: qsTr("Tool Bar")

ToolBar {
    id: control

    background: Rectangle {
        implicitHeight: 40
        color: "#eeeeee"

        Rectangle {
            width: parent.width
            height: 1
            anchors.bottom: parent.bottom
            color: "transparent"
            border.color: "#21be2b"
        }
    }

    RowLayout {
        anchors.fill: parent
        ToolButton {
            text: qsTr("Undo")
        }
        ToolButton {
            text: qsTr("Redo")
        }
    }
}

    Component.onCompleted: {

    }
}
