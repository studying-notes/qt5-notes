import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.1

Window {
    id: window
    visible: true
    width: 640
    height: 480
    title: qsTr("Message Dialog")

    MessageDialog {
        id: messageDialog
        icon: StandardIcon.Warning
        title: qsTr("提示对话框")
        text: "退出程序？"
        standardButtons: StandardButton.Yes | StandardButton.No
        onYes: {
            Qt.quit()
        }
        onNo: {
        }
        Component.onCompleted: visible = true
    }

    Component.onCompleted: {

    }
}
