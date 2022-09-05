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
    title: qsTr("Group Box")

GroupBox {
    id: control
    title: qsTr("GroupBox")

    background: Rectangle {
        y: control.topPadding - control.bottomPadding
        width: parent.width
        height: parent.height - control.topPadding + control.bottomPadding
        color: "transparent"
        border.color: "#21be2b"
        radius: 2
    }

    label: Label {
        x: control.leftPadding
        width: control.availableWidth
        text: control.title
        color: "#21be2b"
        elide: Text.ElideRight
    }

    Label {
        text: qsTr("Content goes here!")
    }
}

    Component.onCompleted: {

    }
}
