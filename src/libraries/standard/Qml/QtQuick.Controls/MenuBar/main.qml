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
    title: qsTr("Menu Bar")

MenuBar {
    id: menuBar

    Menu { title: qsTr("File") }
    Menu { title: qsTr("Edit") }
    Menu { title: qsTr("View") }
    Menu { title: qsTr("Help") }

    delegate: MenuBarItem {
        id: menuBarItem

        contentItem: Text {
            text: menuBarItem.text
            font: menuBarItem.font
            opacity: enabled ? 1.0 : 0.3
            color: menuBarItem.highlighted ? "#ffffff" : "#21be2b"
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }

        background: Rectangle {
            implicitWidth: 40
            implicitHeight: 40
            opacity: enabled ? 1 : 0.3
            color: menuBarItem.highlighted ? "#21be2b" : "transparent"
        }
    }

    background: Rectangle {
        implicitWidth: 40
        implicitHeight: 40
        color: "#ffffff"

        Rectangle {
            color: "#21be2b"
            width: parent.width
            height: 1
            anchors.bottom: parent.bottom
        }
    }
}

    Component.onCompleted: {

    }
}
