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
    title: qsTr("Icons")

    Button {
        icon.name: "quit"
        icon.color: "transparent"
        icon.source: "quit.svg"

        text: qsTr("退出")
        font.pixelSize: 14

        background: Rectangle {
            color: "transparent"
        }

        onClicked: {
            window.close()
        }
    }

    Component.onCompleted: {

    }
}
