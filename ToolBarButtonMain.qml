import QtQuick 2.0
import QtQuick.Window 2.15
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.15

MouseArea {
    id: toolButton
    width: parent.width
    height: settings.toolButtonHeight

    property bool gradientVisible: false
    property int xMouse: 0

    Text {
        anchors.centerIn: parent
        text: openedToolBar ? "\u25C0" : "\u2630"
        font.pixelSize: Qt.application.font.pixelSize * 2
        color: settings.textColor
    }

    LinearGradient {
        visible: gradientVisible
        width: xMouse
        height: parent.height
        start: Qt.point(0, 0)
        end: Qt.point(xMouse, 0)
        opacity: 0.5
        gradient: Gradient {
            GradientStop { position: 0.0; color: settings.toolBarBackGroundColor }
            GradientStop { position: 1.0; color: settings.themeColor }
        }
    }
    LinearGradient {
        visible: gradientVisible
        x: xMouse
        y: 0
        height: parent.height
        width: parent.width - xMouse
        start: Qt.point(0, 0)
        end: Qt.point(width, 0)
        opacity: 0.5
        gradient: Gradient {
            GradientStop { position: 0.0; color: settings.themeColor }
            GradientStop { position: 1.0; color: settings.toolBarBackGroundColor }
        }
    }

    hoverEnabled: true
    onEntered: { gradientVisible = true }
    onPositionChanged: { xMouse = mouse.x }
    onExited: { gradientVisible = false }
    onClicked: { openedToolBar = !openedToolBar }
}
