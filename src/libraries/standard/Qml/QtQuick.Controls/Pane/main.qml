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
    title: qsTr("Pane")

Pane {
    background: Rectangle {
        color: "#eeeeee"
    }

    Label {
        text: qsTr("Content goes here!")
    }
}

    Component.onCompleted: {

    }
}
