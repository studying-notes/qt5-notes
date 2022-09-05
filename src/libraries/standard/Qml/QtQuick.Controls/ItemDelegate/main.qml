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
    title: qsTr("Item Delegate")

ItemDelegate {
    id: control
    text: qsTr("ItemDelegate")

    contentItem: Text {
        rightPadding: control.spacing
        text: control.text
        font: control.font
        color: control.enabled ? (control.down ? "#17a81a" : "#21be2b") : "#bdbebf"
        elide: Text.ElideRight
        verticalAlignment: Text.AlignVCenter
    }

    background: Rectangle {
        implicitWidth: 100
        implicitHeight: 40
        opacity: enabled ? 1 : 0.3
        color: control.down ? "#dddedf" : "#eeeeee"

        Rectangle {
            width: parent.width
            height: 1
            color: control.down ? "#17a81a" : "#21be2b"
            anchors.bottom: parent.bottom
        }
    }
}

    Component.onCompleted: {

    }
}
