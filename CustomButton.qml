import QtQuick 2.0
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.12


MouseArea {
    id: root
    width: parent.width
    height: 40
    property int size: 30
    property int xMouse: 0
    property string buttonText: ""

    Rectangle {
        id: bgColor
        anchors.fill: parent
        color: settings.themeColor
        opacity: 0.8
        visible: false
        CustomGradient { xxMouse: xMouse }
    }

    CustomText {
        textSize: 1.5
        text: buttonText
        anchors.horizontalCenter: parent.horizontalCenter
    }



    hoverEnabled: true
    onEntered: { bgColor.visible = true }
    onPressed: { bgColor.color = settings.backGroundColor }
    onReleased: {
        if (root.containsMouse) bgColor.color = settings.hoverColor
        else bgColor.color = settings.themeColor
    }
    onPositionChanged: { xMouse = mouse.x }
    onExited: { bgColor.color = settings.themeColor; bgColor.visible = false }

    AppSettings { id: settings }
}
