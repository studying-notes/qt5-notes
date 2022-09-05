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
    title: qsTr("Split View")

SplitView {
    id: splitView
    anchors.fill: parent

    handle: Rectangle {
        implicitWidth: 4
        implicitHeight: 4
        color: SplitHandle.pressed ? "#81e889"
            : (SplitHandle.hovered ? Qt.lighter("#c2f4c6", 1.1) : "#c2f4c6")
    }

    Rectangle {
        implicitWidth: 150
        color: "#444"
    }
    Rectangle {
        implicitWidth: 50
        color: "#666"
    }
}

    Component.onCompleted: {

    }
}
