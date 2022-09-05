import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

Window {
    id: window
    visible: true
    width: 720
    height: 480
    title: qsTr("Quick Style")

    QuickStyle {}

    Component.onCompleted: {

    }
}
