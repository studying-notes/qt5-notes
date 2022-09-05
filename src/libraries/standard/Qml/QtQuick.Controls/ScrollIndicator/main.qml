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
    title: qsTr("Scroll Indicator")

ScrollIndicator {
    id: control
    size: 0.3
    position: 0.2
    active: true
    orientation: Qt.Vertical

    contentItem: Rectangle {
        implicitWidth: 2
        implicitHeight: 100
        color: "#c2f4c6"
    }
}

    Component.onCompleted: {

    }
}
