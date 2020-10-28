import QtQuick 2.12
import QtQuick.Controls 2.12

Button {
    id: root
    width: 40
    height: 40
    flat: true

    property string btnColor: ""
    property string textColor: ""
    property string hoverColor: ""
    property string toolBarColor: ""

    Rectangle {
        anchors.fill: parent
        color: btnColor
    }

    onClicked: {
        Settings.backGroundColor = btnColor
//        Settings.textColor = textColor
//        Settings.hoverColor = hoverColor
        Settings.toolBarColor = toolBarColor
    }
}
