import QtQuick 2.0
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0


MouseArea {
    id: root
    width: parent.width
    height: settings.toolButtonHeight
    anchors.horizontalCenter: parent.horizontalCenter

    property string imgSource: ""
    property int xMouse: 0
    property bool gradientVisible: false
    property ButtonGroup buttonGroup: value
    property string buttonText: ""
    property bool _checked: false

    RadioButton {
        id: control
        width: 8
        height: parent.height
        checked: _checked
        ButtonGroup.group: buttonGroup
        indicator: Rectangle {
            width: 8
            height: control.height
            color: control.down ? settings.toolBarBackGroundColor : settings.themeColor
            visible: control.checked
        }
    }



    Row {
        height: parent.height
        width: parent.width - 10
        spacing: 10
        x: 10

        Image {
            id: toolIcon
            source: imgSource
            visible: false
        }

        ColorOverlay {
            id: coloredToolIcon
            anchors.verticalCenter: parent.verticalCenter
            source: toolIcon
            color: settings.textColor
            width: 25
            height: 25
        }

        CustomText {
            visible: openedToolBar
            text: buttonText
        }
    }

    CustomGradient {
        xxMouse: xMouse
        visible: gradientVisible
    }

    hoverEnabled: true
    onEntered: { gradientVisible = true }
    onPositionChanged: { xMouse = mouse.x }
    onExited: {
        xMouse = 0
        gradientVisible = false
    }
    onClicked: { control.checked = true }


    AppSettings { id: settings }
}
