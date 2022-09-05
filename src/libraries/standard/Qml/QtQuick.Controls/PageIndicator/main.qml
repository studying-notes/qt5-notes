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
    title: qsTr("Page Indicator")

PageIndicator {
    id: control
    count: 5
    currentIndex: 2

    delegate: Rectangle {
        implicitWidth: 8
        implicitHeight: 8

        radius: width / 2
        color: "#21be2b"

        opacity: index === control.currentIndex ? 0.95 : pressed ? 0.7 : 0.45

        Behavior on opacity {
            OpacityAnimator {
                duration: 100
            }
        }
    }
}

    Component.onCompleted: {

    }
}
