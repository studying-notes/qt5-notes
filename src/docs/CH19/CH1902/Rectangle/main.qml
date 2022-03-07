import QtQuick 2.12
import QtQuick.Window 2.12

Window {
       visible: true
       width: 640
       height: 480
       MainForm {
           anchors.fill: parent
           mouseArea.onClicked: {
               //Qt.quit();
               topRect.visible = !topRect.visible //控制矩形对象的可见性
           }
       }
}
