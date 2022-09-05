import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

Window {
    id: window
    visible: true
    width: 100
    height: 100
    title: qsTr("Color Animation")

    Rectangle {
        width: 100
        height: 100
        color: "red"

        ColorAnimation on color {
            id: colorAnimation
            to: "yellow"
            duration: 5000
        }
    }

    Component.onCompleted: {

    }
}
