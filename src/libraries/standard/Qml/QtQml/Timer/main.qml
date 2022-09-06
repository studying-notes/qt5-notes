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
    title: qsTr("Timer")

    Timer {
        interval: 500
        running: true
        repeat: true
        onTriggered: time.text = Date().toString()
    }

    Text {
        id: time
    }

    Component.onCompleted: {

    }
}
