import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

Window {
    id: window
    visible: true
    width: 720
    height: 480
    title: qsTr("Tumbler Flat")

    Grid {
        anchors.centerIn: parent

        rows: 1
        columns: 9
        spacing: 15

        Repeater {
            model: ["#727CF5", "#0ACF97", "#F9375E", "#FFBC00", "#2B99B9", "#5A6268", "#EEF2F7", "#212730", "#3498DB"]

            TumblerFlat {
                model: ["00", "01", "02", "03", "04", "05"]
                currentItemColor: modelData
            }
        }
    }

    Component.onCompleted: {

    }
}
