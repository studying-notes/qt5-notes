import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

Window {
    id: window
    visible: true
    width: 640
    height: 480
    title: qsTr("Combo Box Flat")

    Grid {
        anchors.centerIn: parent

        rows: 3
        columns: 3
        spacing: 15

        Repeater {
            model: ["#727CF5", "#0ACF97", "#F9375E", "#FFBC00", "#2B99B9", "#5A6268", "#EEF2F7", "#212730", "#3498DB"]

            ComboBoxFlat {
                model: ["First", "Second", "Third"]
                checkedColor: modelData
            }
        }
    }

    Component.onCompleted: {

    }
}
