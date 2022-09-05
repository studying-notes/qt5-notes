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
    title: qsTr("Frame")

Frame {
    background: Rectangle {
        color: "transparent"
        border.color: "#21be2b"
        radius: 2
    }

    Label {
        text: qsTr("Content goes here!")
    }
}

    Component.onCompleted: {

    }
}
