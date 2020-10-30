import QtQuick 2.0
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.12


MouseArea {
    id: root
    property int size: 30
    property bool imgVisible: true
    property string imgSource: ""
    property string buttonText: ""

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
        enabled: imgVisible
        id: icon
        width: 20
        height: 20
        anchors.centerIn: parent
        source: imgSource
        visible: false
    }

    ColorOverlay {
        id: coloredIcon
        visible: imgVisible
        anchors.fill: icon
        source: icon
        color: _textColor
    }

    Text {
        enabled: !imgVisible
        visible: !imgVisible
        text: buttonText
        font.pixelSize: Qt.application.font.pixelSize * 1.2
        color: _textColor
        anchors.centerIn: parent
    }

    hoverEnabled: true
    onEntered: { bgColor.color = _hoverColor; bgColor.visible = true }
    onPressed: { bgColor.color = _backGroundColor }
    onReleased: {
        if (root.containsMouse) bgColor.color = _hoverColor
        else bgColor.color = _themeColor
    }
    onPositionChanged: { xMouse = mouse.x }
    onExited: { bgColor.color = _themeColor; bgColor.visible = false }
}
