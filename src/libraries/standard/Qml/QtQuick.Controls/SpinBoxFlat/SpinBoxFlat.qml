import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.1

SpinBox {
    id: root

    property color color: "#3498DB"

    value: 50
    editable: true

    contentItem: TextInput {
        text: root.value

        font.pixelSize: 15
        font.family: "Arial"
        font.weight: Font.Thin

        horizontalAlignment: Qt.AlignHCenter
        verticalAlignment: Qt.AlignVCenter

        readOnly: !root.editable
        validator: root.validator
    }

    up.indicator: Rectangle {
        x: root.mirrored ? 0 : parent.width - width
        implicitWidth: 37
        implicitHeight: implicitWidth
        color: root.up.pressed ? "#EBEDEF" : root.color

        Text {
            text: "+"
            anchors.fill: parent
            color: root.up.pressed ? root.color : "white"

            font.bold: true
            font.pixelSize: root.font.pixelSize * 2
            fontSizeMode: Text.Fit

            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    down.indicator: Rectangle {
        x: root.mirrored ? parent.width - width : 0
        implicitWidth: root.up.indicator.implicitWidth
        implicitHeight: implicitWidth
        color: root.down.pressed ? "#EBEDEF" : root.color

        Text {
            text: "-"
            anchors.fill: parent
            color: root.down.pressed ? root.color : "white"

            font.bold: true
            font.pixelSize: root.font.pixelSize * 2
            fontSizeMode: Text.Fit

            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    background: Rectangle {
        implicitWidth: 138
        border.color: "#EBEDEF"

        layer.enabled: root.hovered
        layer.effect: DropShadow {
            id: dropShadow
            transparentBorder: true
            color: "#EEF2F7"
            samples: 8
        }
    }
}
