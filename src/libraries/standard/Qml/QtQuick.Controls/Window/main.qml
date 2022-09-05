import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.1
import QtQuick.Layouts 1.1

import "main.js" as MainJS

Window {
    id: window
    visible: true
    width: 640
    height: 480

    title: qsTr("Window")

    // 无边框
    flags: Qt.FramelessWindowHint

   property bool closing: false

   MessageDialog {
      id: exitMessageDialogId
      icon: StandardIcon.Question
      text: "Are you sure to exit?"
      standardButtons: StandardButton.Yes | StandardButton.No
      onYes: {
         closing = true
         window.close()
      }
   }

   onClosing: {
      close.accepted = closing
      onTriggered: if(!closing) exitMessageDialogId.open()
   }
}
