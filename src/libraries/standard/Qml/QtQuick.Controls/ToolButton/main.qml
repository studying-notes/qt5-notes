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
    title: qsTr("Tool Button")

ToolButton {
    id: control
    text: qsTr("ToolButton")
    width: 120

    contentItem: Text {
        text: control.text
        font: control.font
        opacity: enabled ? 1.0 : 0.3
        color: control.down ? "#17a81a" : "#21be2b"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    background: Rectangle {
        implicitWidth: 40
        implicitHeight: 40
        color: Qt.darker("#33333333", control.enabled && (control.checked || control.highlighted) ? 1.5 : 1.0)
        opacity: enabled ? 1 : 0.3
        visible: control.down || (control.enabled && (control.checked || control.highlighted))
    }
}

    Component.onCompleted: {

    }
}
