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
    title: qsTr("Button")

    Column {
        spacing: 25
        anchors.centerIn: parent

        Button {
            text: "A"

            font.pixelSize: 16

            contentItem: Text {
                text: parent.text
                font: parent.font
                opacity: enabled ? 1.0 : 0.3
                color: parent.down ? "#17a81a" : "#21be2b"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            background: Rectangle {
                implicitWidth: 100
                implicitHeight: 40
                opacity: enabled ? 1 : 0.3
                border.color: parent.down ? "#17a81a" : "#21be2b"
                border.width: 1
                radius: 2
            }
        }

        Button {
            text: "B"

            palette.buttonText: "white"

            background: Rectangle {
                implicitWidth: 100
                implicitHeight: 40
                color: "#1890FF"
                border.color: "#1890FF"
                radius: 5
            }
        }
    }

    Component.onCompleted: {

    }
}
