import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

Window {
    id: window
    visible: true
    width: 360
    height: 360
    title: qsTr("Script Action")

    Row {
        spacing: 15
        anchors.centerIn: parent

        Button {
            text: animation.running ? (animation.paused ? "Resume" : "Pause") : "Run"
            onClicked: {
                if (!animation.running)
                    animation.start()
                else if (animation.paused)
                    animation.resume()
                else
                    animation.pause()
            }
        }

        Button {
            text: "Run"
            onClicked: {
                rectangle.state = "fast"
            }
        }
    }

    Rectangle {
        id: rectangle

        x: 260
        y: 260

        width: 100
        height: 100
        color: "blue"

        state: "slow"

        State {
            name: "fast"
            StateChangeScript {
                name: "fastScript"
                script: {
                    rectangle.y = 100
                }
            }
        }

        Transition {
            to: "fast"
            SequentialAnimation {
                NumberAnimation {/* ... */ }
                ScriptAction {
                    scriptName: "fastScript"
                }
                NumberAnimation {/* ... */ }
            }
        }
    }

    Rectangle {
        id: rect
        width: 100
        height: 100
        color: "red"

        SequentialAnimation {
            id: animation
            running: false

            onFinished: {
                start()
            }

            NumberAnimation {
                target: rect
                property: "x"
                to: 260
                duration: 3000
            }

            ScriptAction {
                script: {
                    rect.x = 100
                }
            }
        }
    }

    Component.onCompleted: {

    }
}
