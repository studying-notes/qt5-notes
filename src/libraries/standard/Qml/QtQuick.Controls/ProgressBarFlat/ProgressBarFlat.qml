import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.1

ProgressBar {
    id: root

    property color color: "#3498DB"

    value: 0.5

    background: Rectangle {
        implicitWidth: 200
        implicitHeight: 12
        color: "#EBEDEF"
    }

    contentItem: Item {
        implicitWidth: root.background.implicitWidth
        implicitHeight: root.background.implicitHeight

        Rectangle {
            width: root.visualPosition * parent.width
            height: parent.height
            color: root.color
        }
    }
}
