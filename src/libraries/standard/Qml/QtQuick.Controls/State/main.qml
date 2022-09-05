import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.1
import QtQuick.Layouts 1.1
import Qt.labs.platform 1.1

Window {
    id: window
    visible: true
    width: 200
    height: 200
    title: qsTr("State")

    Rectangle {
        id: rectangle1
        width: 100
        height: 50
        color: "black"

        MouseArea {
            anchors.fill: parent
            onClicked: rectangle1.state === 'clicked' ? rectangle1.state
                                                        = "" : rectangle1.state = 'clicked'
        }

        states: [
            State {
                name: "clicked"
                PropertyChanges {
                    target: rectangle1
                    color: "red"
                }
            }
        ]
    }

    Rectangle {
        id: rectangle2
        y: 55
        width: 100
        height: 50
        color: "red"

        MouseArea {
            id: mouseArea2
            anchors.fill: parent
        }

        states: State {
            name: "hidden"
            when: mouseArea2.pressed
            PropertyChanges {
                target: rectangle2
                opacity: 0
            }
        }
    }

    Button {
        id: button1
        y: 110

        state: "NO"

        states: [
            State {
                name: "NO"
                PropertyChanges {
                    target: button1
                    text: "NO"
                    onClicked: {
                        console.log("NO")
                        button1.state = "YES"
                    }
                }
            },
            State {
                name: "YES"
                PropertyChanges {
                    target: button1
                    text: "YES"
                    onClicked: {
                        console.log("YES")
                        button1.state = "NO"
                    }
                }
            }
        ]
    }
}
