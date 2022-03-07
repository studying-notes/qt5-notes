/* import部分 */
import QtQuick 2.3       //导入Qt Quick 2.3库
/* 对象声明 */
Rectangle {         //根对象：Rectangle
     property alias mouseArea: mouseArea  //属性别名
     width: 360        //属性（宽度）
     height: 360        //属性（高度）
     MouseArea {        //子对象1：MouseArea
          id: mouseArea      //对象标识符
          anchors.fill: parent
     }
     Text {         //子对象2：Text
          anchors.centerIn: parent
          text: "Hello World"
     }
     Image {
          //图像在窗口的位置坐标
          x: 20
          y: 20
          width: 320;height: 160   //(a)
          source: "images/FFmpeg_logo.jpg"  //图片路径URL
          fillMode: Image.PreserveAspectCrop  //(b)
          clip: true       //避免所要渲染的图片超出元素范围
     }
}
