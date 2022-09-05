import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12

ApplicationWindow {
    id: window
    visible: true
    width: 720
    height: 480
    title: qsTr("Material Style")

    Material.theme: Material.Dark
    Material.accent: Material.Purple

    MaterialItem {

    }

    Component.onCompleted: {

    }
}
