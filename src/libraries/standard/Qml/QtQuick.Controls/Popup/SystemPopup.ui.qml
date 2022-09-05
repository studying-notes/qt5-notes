import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.12

Popup {
    width: 360
    height: 320

    modal: true
    focus: true

    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent

    property alias dialogText: dialogText
    property alias leftButton: leftButton
    property alias rightButton: rightButton

    enter: Transition {
        NumberAnimation {
            property: "opacity"
            from: 0.0
            to: 1.0
        }
    }

    exit: Transition {
        NumberAnimation {
            property: "opacity"
            from: 1.0
            to: 0.0
        }
    }

    background: Rectangle {
        id: dialog
        border.width: 0
        anchors.fill: parent
        radius: 5
        layer.enabled: true
        layer.effect: OpacityMask {
            maskSource: Rectangle {
                width: dialog.width
                height: dialog.height
                radius: dialog.radius
            }
        }

        Label {
            id: dialogText
            width: parent.width
            height: parent.height / 3 * 2
            color: "#ffffff"
            rightPadding: 20
            leftPadding: 20

            text: qsTr("Remember to complete your GitHub Copilot setup before your access expires.")

            font.pixelSize: 20
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.WordWrap
            lineHeight: 1.5

            background: Rectangle {
                border.width: 0
                color: "#000000"
            }
        }

        Rectangle {
            width: parent.width
            height: parent.height / 3
            border.color: "#6b6b6b"
            anchors.top: dialogText.bottom
            border.width: 0

            ButtonGroup {
                buttons: dialogButtons.children
            }

            Row {
                id: dialogButtons

                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter

                spacing: 20

                Button {
                    id: leftButton
                    width: parent.parent.width / 5
                    height: parent.parent.height / 3.5

                    text: "N"
                    font.pixelSize: 20

                    palette.buttonText: "#000000"
                    background: Rectangle {
                        border.color: "#333333"
                        radius: 5
                    }
                }

                Button {
                    id: rightButton
                    width: parent.parent.width / 5
                    height: parent.parent.height / 3.5

                    text: "Y"
                    font.pixelSize: 20

                    palette.buttonText: "#FFFFFF"
                    background: Rectangle {
                        color: "#000000"
                        border.color: "#000000"
                        radius: 5
                    }
                }
            }
        }
    }
}
