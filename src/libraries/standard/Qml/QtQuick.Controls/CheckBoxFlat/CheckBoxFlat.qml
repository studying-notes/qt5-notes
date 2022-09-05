import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.1

CheckBox {
    id: root

    property color checkedColor: "#0ACF97"

    text: qsTr("CheckBox")

    indicator: Rectangle {
        x: root.leftPadding
        anchors.verticalCenter: parent.verticalCenter
        width: 26; height: width
        antialiasing: true
        radius: 5
        border.width: 2
        border.color: root.checkedColor

        Rectangle {
            anchors.centerIn: parent
            width: parent.width*0.7; height: width
            antialiasing: true
            radius: parent.radius * 0.7
            color: root.checkedColor
            visible: root.checked
        }
    }
}
