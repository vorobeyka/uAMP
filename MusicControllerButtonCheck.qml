import QtQuick 2.0
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.12


MouseArea {
    id: root
    property int size: 30
    property bool isChecked: false
    property string imgSource: ""
    property string buttonColor: isChecked ? settings.backGroundColor : settings.themeColor

    anchors.verticalCenter: parent.verticalCenter
    width: size
    height: size

    Rectangle {
        id: bgColor
        anchors.fill: parent
        color: settings.themeColor
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
        color: settings.textColor
    }

    hoverEnabled: true
    onEntered: { bgColor.color = settings.hoverColor; bgColor.visible = true }
    onPressed: { bgColor.color = settings.backGroundColor }
    onReleased: {
        if (root.containsMouse) bgColor.color = settings.hoverColor
        else bgColor.color = buttonColor
    }
    onPositionChanged: { xMouse = mouse.x }
    onExited: {
        bgColor.color = buttonColor
        if (!isChecked) bgColor.visible = false
    }

    AppSettings { id: settings }
}
