import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

Window {
    id: window
    visible: true
    width: 640
    height: 480
    title: qsTr("Progress Bar Flat")

    Grid {
        anchors.centerIn: parent

        rows: 9
        columns: 1
        spacing: 15

        Repeater {
            model: ["#727CF5", "#0ACF97", "#F9375E", "#FFBC00", "#2B99B9", "#5A6268", "#EEF2F7", "#212730", "#3498DB"]

            ProgressBarFlat {
                color: modelData
                value: Math.random()
            }
        }
    }

    Component.onCompleted: {

    }
}
