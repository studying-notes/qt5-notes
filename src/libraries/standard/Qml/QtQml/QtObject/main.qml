import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

Window {
    id: window
    visible: true
    width: 640
    height: 480
    title: qsTr("Qt Object")

    QtObjectCustom {
        id: attributes
    }

    Text {
        text: attributes.text
        font.pixelSize: attributes.size
        objectName: "text"
  }

    Component.onCompleted: {

    }
}
