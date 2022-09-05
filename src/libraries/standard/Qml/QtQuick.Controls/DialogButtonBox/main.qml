import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

Window {
    id: window
    visible: true
    width: 640
    height: 480
    title: qsTr("Dialog Button Box")

    DialogButtonBox {
        id: standard
        standardButtons: DialogButtonBox.Ok | DialogButtonBox.Cancel

        onAccepted: console.log("Ok clicked")
        onRejected: console.log("Cancel clicked")
    }

    DialogButtonBox {
        anchors.top: standard.bottom
        anchors.topMargin: 20

        Button {
            text: qsTr("Save")
            DialogButtonBox.buttonRole: DialogButtonBox.AcceptRole

            palette.buttonText: "white"

            background: Rectangle {
                implicitWidth: 100
                implicitHeight: 40
                color: "#1890FF"
                border.color: "#1890FF"
                radius: 5
            }
        }

        Button {
            text: qsTr("Close")
            DialogButtonBox.buttonRole: DialogButtonBox.DestructiveRole

            palette.buttonText: "black"

            background: Rectangle {
                implicitWidth: 100
                implicitHeight: 40
                color: "white"
                border.color: "#000000"
                radius: 5
            }
        }
    }

    Component.onCompleted: {

    }
}
