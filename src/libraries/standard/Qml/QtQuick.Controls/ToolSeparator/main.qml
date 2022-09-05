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
    title: qsTr("Tool Separator")

ToolBar {
    RowLayout {
        anchors.fill: parent

        ToolButton {
            text: qsTr("Action 1")
        }
        ToolButton {
            text: qsTr("Action 2")
        }

        ToolSeparator {
            padding: vertical ? 10 : 2
            topPadding: vertical ? 2 : 10
            bottomPadding: vertical ? 2 : 10

            contentItem: Rectangle {
                implicitWidth: parent.vertical ? 1 : 24
                implicitHeight: parent.vertical ? 24 : 1
                color: "#c3c3c3"
            }
        }

        ToolButton {
            text: qsTr("Action 3")
        }
        ToolButton {
            text: qsTr("Action 4")
        }

        Item {
            Layout.fillWidth: true
        }
    }
}

    Component.onCompleted: {

    }
}
