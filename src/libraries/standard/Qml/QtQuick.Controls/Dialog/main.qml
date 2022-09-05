import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

Window {
    id: window
    visible: true
    width: 640
    height: 480
    title: qsTr("Dialog")

    Button {
        text: qsTr("打开")
        onClicked: {
            dialog.open()
        }
    }

    Dialog {
        id: dialog
        visible: true
        modal: true
        anchors.centerIn: parent
        closePolicy: Popup.NoAutoClose

        title: "设置"

        onAccepted: console.log("确认")

        background: Rectangle {
            border.width: 0
        }

        header: Label {
            text: parent.title
            elide: Label.ElideRight
            font.bold: true
            padding: 12
        }

        footer: DialogButtonBox {
            alignment: Qt.AlignRight

            Button {
                text: qsTr("确认")

                DialogButtonBox.buttonRole: DialogButtonBox.AcceptRole

                palette.buttonText: "white"

                background: Rectangle {
                    implicitWidth: 80
                    implicitHeight: 30
                    color: "#1890FF"
                    border.color: "#1890FF"
                    radius: 5
                }
            }
        }

        contentItem: Rectangle {
            color: "lightskyblue"
            implicitWidth: 400
            implicitHeight: 200
            Text {
                text: "Hello blue sky!"
                color: "navy"
                anchors.centerIn: parent
            }
        }
    }

    Component.onCompleted: {

    }
}
