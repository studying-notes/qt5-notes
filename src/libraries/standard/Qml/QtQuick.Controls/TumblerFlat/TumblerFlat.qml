import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.1

Tumbler {
    id: root

    property color currentItemColor: "#3498DB"

    visibleItemCount: 5

    delegate: Text {
        text: modelData
        color: root.currentItemColor

        font.family: "Arial"
        font.weight: Font.Thin
        font.pixelSize: 50

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        opacity: 1.0 - Math.abs(Tumbler.displacement) / root.visibleItemCount
        scale: opacity
    }

    background: Rectangle {
        width: root.width;
        height: root.height
        border.color: "#EBEDEF"

        layer.enabled: root.hovered
        layer.effect: DropShadow {
            transparentBorder: true
            color: root.currentItemColor
            samples: 5 /*20*/
        }
    }
}
