import QtQuick 2.0
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.12


MouseArea {
    id: root
    property int size: 30
    property bool isChecked: false
    property string imgSource: ""
    property string buttonColor: isChecked ? _backGroundColor : _themeColor

    anchors.verticalCenter: parent.verticalCenter
    width: size
    height: size

    Rectangle {
        id: bgColor
        anchors.fill: parent
        color: _themeColor
        radius: width / 2
        opacity: 0.8
        visible: false
    }

    Image {
        id: icon
        width: 20
        height: 20
        anchors.centerIn: parent
        source: imgSource
        visible: false
    }

    ColorOverlay {
        id: coloredIcon
        anchors.fill: icon
        source: icon
        color: _textColor
    }

    hoverEnabled: true
    onEntered: { bgColor.color = _hoverColor; bgColor.visible = true }
    onPressed: { bgColor.color = _backGroundColor }
    onReleased: {
        if (root.containsMouse) bgColor.color = _hoverColor
        else bgColor.color = buttonColor
    }
    onPositionChanged: { xMouse = mouse.x }
    onExited: {
        bgColor.color = buttonColor
        if (!isChecked) bgColor.visible = false
    }
}
