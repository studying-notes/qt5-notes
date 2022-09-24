import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.1

Rectangle {
   id: moveItem

   x: 100
   y: 100
   width: 100
   height: 100

   color: "lightblue"
   MouseArea {
       anchors.fill: parent
       property real lastX: 0
       property real lastY: 0
       onPressed: {
           lastX = mouseX
           lastY = mouseY
       }
       onPositionChanged: {
           if (pressed) {
               moveItem.x += mouseX - lastX
               moveItem.y += mouseY - lastY
           }
       }
   }
}
