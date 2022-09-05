import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.1

import "main.js" as MainJS

ApplicationWindow {
    id: window
    visible: true
    width: 640
    height: 480
    title: qsTr("Application Window")

   background: Rectangle {
        gradient: Gradient {
            GradientStop { position: 0; color: "#ffffff" }
            GradientStop { position: 1; color: "#c1bbf9" }
        }
    }

    overlay.modal: Rectangle {
        color: "#8f28282a"
    }

    overlay.modeless: Rectangle {
        color: "#2f28282a"
    }

   menuBar: MenuBar {
        Menu {
            title: "File"
            MenuItem { text: "Open..." }
            MenuItem { text: "Close" }
        }

        Menu {
            title: "Edit"
            MenuItem { text: "Cut" }
            MenuItem { text: "Copy" }
            MenuItem { text: "Paste" }
        }
    }
}
