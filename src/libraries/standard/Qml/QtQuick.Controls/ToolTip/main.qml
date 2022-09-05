import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.1
import QtQuick.Layouts 1.1

Window {
    id: window
    visible: true
    width: 640
    height: 480
    title: qsTr("Tool Tip")

    Button {
        text: qsTr("按住提示")

        ToolTip.visible: down
        ToolTip.text: qsTr("Save the active project")
    }

    Button {
        x: 120
        text: qsTr("长按提示")

        ToolTip.visible: pressed
        ToolTip.delay: Qt.styleHints.mousePressAndHoldInterval
        ToolTip.text: qsTr("This tool tip is shown after pressing and holding the button down.")
    }

    Button {
        x: 240
        text: qsTr("悬浮提示")
        hoverEnabled: true

        ToolTip.delay: 1000
        ToolTip.timeout: 5000
        ToolTip.visible: hovered
        ToolTip.text: qsTr("This tool tip is shown after hovering the button for a second.")
    }

    Slider {
        x: 360
        id: slider
        value: 0.5

        ToolTip {
            parent: slider.handle
            visible: slider.pressed
            text: slider.value.toFixed(1)
        }
    }

    Button {
        y: 80
        text: qsTr("自定义提示")
        hoverEnabled: true

        ToolTip {
            id: control
            visible: parent.hovered

            text: qsTr("A descriptive tool tip of what the button does")

            contentItem: Text {
                text: control.text
                font: control.font
                color: "#21be2b"
            }

            background: Rectangle {
                border.color: "#21be2b"
            }
        }
    }

    Component.onCompleted: {

    }
}
