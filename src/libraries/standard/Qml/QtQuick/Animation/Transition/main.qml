import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

Window {
    id: window
    visible: true
    width: 300
    height: 300
    title: qsTr("Transition")

    Rectangle {
        id: rect1
        width: 100
        height: 100
        color: "red"

        MouseArea {
            id: mouseArea
            anchors.fill: parent
        }

        states: State {
            name: "moved"
            when: !mouseArea.pressed
            PropertyChanges {
                target: rect1
                x: 200
                y: 200
            }
        }

        transitions: [
            Transition {
                from: "*"
                to: "middleRight"
                NumberAnimation {
                    properties: "x,y"
                    easing.type: Easing.InOutQuad
                    duration: 2000
                }
            },
            Transition {
                from: "*"
                to: "bottomLeft"
                NumberAnimation {
                    properties: "x,y"
                    easing.type: Easing.InOutQuad
                    duration: 200
                }
            },
            //If any other rectangle is clicked, the icon will return
            //to the start position at a slow speed and bounce.
            Transition {
                from: "*"
                to: "*"
                NumberAnimation {
                    easing.type: Easing.OutBounce
                    properties: "x,y"
                    duration: 4000
                }
            }
        ]

        //        transitions: Transition {
        //            NumberAnimation {
        //                properties: "x,y"
        //                easing.type: Easing.InOutQuad
        //            }
        //        }
    }

    Component.onCompleted: {

    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.75}
}
##^##*/

