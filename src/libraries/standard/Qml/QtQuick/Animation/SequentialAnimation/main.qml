import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

Window {
    id: window
    visible: true
    width: 360
    height: 360
    title: qsTr("Sequential Animation")

    Button {
        id: button
        anchors.centerIn: parent
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

            NumberAnimation {
                target: rect
                property: "y"
                to: 260
                duration: 3000
            }

            NumberAnimation {
                target: rect
                property: "x"
                to: 0
                duration: 3000
            }

            NumberAnimation {
                target: rect
                property: "y"
                to: 0
                duration: 3000
            }
        }
    }

    Component.onCompleted: {

    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.75}
}
##^##*/

