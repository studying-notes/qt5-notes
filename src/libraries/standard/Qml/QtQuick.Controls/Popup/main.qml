import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.12
import Qt.labs.platform 1.1

import "main.js" as MainJS

Window {
    id: window
    visible: true
    width: 640
    height: 480
    title: qsTr("Popup")

    Button {
        width: 180
        height: 60
        anchors.centerIn: parent
        text: "打开弹出窗口"
        font.pixelSize: 16
        onClicked: systemPopup.open()
        Component.onCompleted: {
            systemPopup.open()
        }
    }

    SystemPopup {
        id: systemPopup
        parent: Overlay.overlay
        x: Math.round((parent.width - width) / 2)
        y: Math.round((parent.height - height) / 2)
        leftButton.onClicked: {
            systemPopup.close()
        }
        rightButton.onClicked: {
            systemPopup.close()
            timer.start()
        }

        Timer {
            id: timer
            interval: 1000
            running: false
            onTriggered: {
                popupState.state = popupState.state === "Downloaded"? "Detected": "Downloaded"
                systemPopup.open()
            }
        }

        Rectangle {
            id: popupState
            state: "Detected"

            states: [
                State {
                    name: "Detected"
                    PropertyChanges {
                        target: systemPopup
                        dialogText.text: qsTr("New version detected. Please update.")
                    }
                },

                State {
                    name: "Downloaded"
                    PropertyChanges {
                        target: systemPopup
                        dialogText.text: qsTr("New version downloaded. Please restart.")
                    }
                }
            ]
        }
    }

    Popup {
        id: popup
        parent: Overlay.overlay

        x: Math.round((parent.width - width) / 2)
        y: Math.round((parent.height - height) / 2)

        width: 360
        height: 320

        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent

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
            id: rectangle
            border.width: 0
            anchors.fill: parent
            radius: 5
            layer.enabled: true
            layer.effect: OpacityMask {
                maskSource: Rectangle {
                    width: rectangle.width
                    height: rectangle.height
                    radius: rectangle.radius
                }
            }

            Label {
                id: label
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
                anchors.top: label.bottom
                border.width: 0

                ButtonGroup {
                    buttons: row.children
                }

                Row {
                    id: row

                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter

                    spacing: 20

                    Button {
                        width: parent.parent.width / 5
                        height: parent.parent.height / 3.5

                        text: "N"
                        font.pixelSize: 20

                        palette.buttonText: "#000000"
                        background: Rectangle {
                            border.color: "#333333"
                            radius: 5
                        }

                        onClicked: {
                            popup.close()
                        }
                    }

                    Button {
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

                        onClicked: {
                            Qt.quit()
                        }
                    }
                }
            }
        }
    }

    Component.onCompleted: {
        MainJS.init(window, core)
        MainJS.launch(window, core)
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/

