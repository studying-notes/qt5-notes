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
     Flow {        //(b)
          anchors.fill: parent
          anchors.margins: 15     //元素与窗口左上角边距为15像素
          spacing: 5
          //以下添加被Flow定位的元素成员
          RedRectangle { }
          BlueRectangle { }
          GreenRectangle { }
     }
}
