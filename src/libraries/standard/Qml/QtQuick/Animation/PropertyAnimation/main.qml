import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

Window {
    id: window
    visible: true
    width: 640
    height: 480
    title: qsTr("Property Animation")

    Rectangle {
        width: 100
        height: 100
        color: "red"

        Behavior on x {
            PropertyAnimation {}
        }

        MouseArea {
            anchors.fill: parent
            onClicked: parent.x = 50
        }
    }

    Component.onCompleted: {

    }
}
