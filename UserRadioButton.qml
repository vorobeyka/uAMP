import QtQuick 2.0
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0


MouseArea {
    id: root
    width: text.width
    height: 30

    property int xMouse: 0
    property bool gradientVisible: false
    property ButtonGroup buttonGroup: value
    property string buttonText: ""
    property bool _checked: false

    RadioButton {
        id: control
        width: parent.width
        height: 2
        checked: _checked
        ButtonGroup.group: buttonGroup
        anchors.bottom: root.bottom
        indicator: Rectangle {
            anchors.fill: parent
            color: control.down ? _toolBarBackGroundColor : _themeColor
            visible: control.checked
        }
    }

    CustomText {
        id: text
        text: buttonText
        anchors.horizontalCenter: parent.horizontalCenter
    }

    CustomText {
        id: hoveredText
        visible: !text.visible
        text: buttonText
        anchors.horizontalCenter: parent.horizontalCenter
        color: _themeColor
    }

    hoverEnabled: true
    onEntered: {
        text.visible = false
        gradientVisible = true
    }
    onPositionChanged: { xMouse = mouse.x }
    onExited: {
        xMouse = 0
        text.visible = true
//        text.color = _textColor
        gradientVisible = false
    }
    onClicked: { control.checked = true }
}
