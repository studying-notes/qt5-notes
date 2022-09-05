import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.1
import QtGraphicalEffects 1.12
import QtQuick.Layouts 1.1

Window {
    id: window
    visible: true
    width: 640
    height: 480
    title: qsTr("Popup Progress Bar")

    Button {
        width: 180
        height: 60
        text: "打开弹出窗口"
        font.pixelSize: 16
        onClicked: popup.open()
        Component.onCompleted: {
            popup.open()
        }
    }

    Popup {
        id: popup
        parent: Overlay.overlay

        x: Math.round((parent.width - width) / 2)
        y: Math.round((parent.height - height) / 2)

        width: 624
        height: 96

        modal: true
        focus: true
        // closePolicy: Popup.NoAutoClose
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent

        onAboutToShow: {
            progressBar.value = 0
        }

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
            color: "transparent"
            border.width: 0
        }

        contentItem: Column {
            spacing: 5

            Rectangle {
                width: parent.width
                height: 30
                color: "transparent"

                ProgressBar {
                    id: progressBar
                    value: 0.05
                    padding: 0

                    anchors.horizontalCenter: parent.horizontalCenter

                    background: Rectangle {
                        implicitWidth: 200
                        implicitHeight: 8
                        color: "#e6e6e6"
                        radius: 5
                    }

                    contentItem: Item {
                        implicitWidth: 200
                        implicitHeight: 8

                        Rectangle {
                            width: parent.parent.visualPosition * parent.width
                            height: parent.height
                            radius: 5
                            color: "#1890ff"
                        }
                    }

                    Timer {
                        interval: 100
                        running: true
                        repeat: true
                        onTriggered: {
                            if (parent.value < 0.8) {
                                parent.value += 0.05
                            } else if (parent.value < 0.9) {
                                parent.value += 0.02
                            } else if (parent.value < 0.99) {
                                parent.value += 0.01
                            }
                        }
                    }
                }

                Label {
                    anchors.left: progressBar.right
                    anchors.leftMargin: 5
                    anchors.verticalCenter: progressBar.verticalCenter

                    color: "#FFFFFF"
                    text: Math.round(progressBar.value * 100) + "%"
                }
            }

            Label {
                anchors.horizontalCenter: parent.horizontalCenter

                text: qsTr("正在读取，请勿拿开")
                color: "#FFFFFF"
            }
        }
    }

    Component.onCompleted: {

    }
}
