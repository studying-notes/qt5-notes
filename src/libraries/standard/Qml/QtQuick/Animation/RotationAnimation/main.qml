import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

Window {
    id: window
    visible: true
    width: 400
    height: 400
    title: qsTr("Rotation Animation")

    Rectangle {
        id: rect
        width: 150
        height: 100
        anchors.centerIn: parent
        color: "red"
        antialiasing: true

        states: State {
            name: "rotated"
            PropertyChanges {
                target: rect
                rotation: 180
            }
        }

        transitions: Transition {
            RotationAnimation {
                duration: 1000
                direction: RotationAnimation.Counterclockwise
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: rect.state = "rotated"
    }

    Component.onCompleted: {

    }
}
