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
     Row {          //(a)
          x: 25
          y: 25
          spacing: 10         //元素间距为10像素
          layoutDirection: Qt.RightToLeft    //元素从右向左排列
          //以下添加被Row定位的元素成员
          RedRectangle { }
          GreenRectangle { }
          BlueRectangle { }
     }
     Column {          //(b)
          x: 25
          y: 120
          spacing: 2
          //以下添加被Column定位的元素成员
          RedRectangle { }
          GreenRectangle { }
          BlueRectangle { }
     }
     Grid {          //(c)
          x: 140
          y: 120
          columns: 3         //每行3个元素
          spacing: 5
          //以下添加被Grid定位的元素成员
          BlueRectangle { }
          BlueRectangle { }
          BlueRectangle { }
          BlueRectangle { }
          BlueRectangle { }
     }
}
