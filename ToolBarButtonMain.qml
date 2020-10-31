import QtQuick 2.0
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.14

MouseArea {
    id: toolButton
    width: parent.width
    height: _toolButtonHeight

    property bool gradientVisible: false
    property int xMouse: 0

    Text {
        anchors.centerIn: parent
        text: openedToolBar ? "\u25C0" : "\u2630"
        font.pixelSize: Qt.application.font.pixelSize * 2
        color: _textColor
        opacity: 0.8
    }

    CustomGradient {
        xxMouse: xMouse
        visible: gradientVisible
    }

    hoverEnabled: true
    onEntered: { gradientVisible = true }
    onPositionChanged: { xMouse = mouse.x }
    onExited: { xMouse = 0; gradientVisible = false }
    onClicked: { openedToolBar = !openedToolBar }
}
