import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.1
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0

Window {
    id: window
    visible: true
    width: 640
    height: 480
    title: qsTr("File Dialog")

    Row {
        id: buttons
        spacing: 20

        Button {
            text: qsTr("Open File Dialog")
            onClicked: {
                fileDialog.open()
            }
        }

        Button {
            text: qsTr("Open Dir Dialog")
            onClicked: {
                dirDialog.open()
            }
        }
    }

    Column {
        id: labels
        anchors.top: buttons.bottom
        anchors.topMargin: 30
        spacing: 20

        Label {
            id: filePath
            text: "File Path"
        }

        Label {
            id: dirPath
            text: "Dir Path"
        }
    }

    FileDialog {
        id: fileDialog
        title: "Please choose a file"
        folder: shortcuts.desktop
        nameFilters: ["Image files (*.jpg *.png)", "All files (*)"]

        onAccepted: {
            console.log("You chose: " + fileUrls)
            filePath.text = core.convertUrlToNativeFilePath(fileUrl)
        }

        onRejected: {
            console.log("Canceled")
        }
    }

    FileDialog {
        id: dirDialog
        title: "Please choose a dir"
        folder: shortcuts.documents
        selectFolder: true

        onAccepted: {
            console.log("You chose: " + fileUrls)
            dirPath.text = core.convertUrlToNativeFilePath(fileUrl)
        }

        onRejected: {
            console.log("Canceled")
        }
    }

    Component.onCompleted: {

    }
}
