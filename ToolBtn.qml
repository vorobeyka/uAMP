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

    Rectangle {
        id: bg
        anchors.fill: parent
        color: settings.toolBarBackGroundColor

        RadioButton {
            id: control
            width: 50
            height: 50

            ButtonGroup.group: buttonGroup
            indicator: Rectangle {
                width: 8
                height: bg.height
                color: control.down ? settings.toolBarBackGroundColor : settings.themeColor
                visible: control.checked
            }
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

        Image {
            id: toolImage
            source: imgSource
            visible: false
        }

        ColorOverlay {
            id: coloredSearchIcon
            x: 10
            anchors.verticalCenter: parent.verticalCenter
            source: toolImage
            color: settings.textColor
            width: 25
            height: 25
        }
    }

    Text {
        anchors.verticalCenter: parent.verticalCenter
        x: coloredSearchIcon.width + 20
        visible: openedToolBar
        text: buttonText
        font.pixelSize: Qt.application.font.pixelSize * 1.2
        color: settings.textColor
    }

    hoverEnabled: true
    onEntered: { gradientVisible = true }
    onPositionChanged: { xMouse = mouse.x }
    onExited: { gradientVisible = false }
    onClicked: { control.checked = true }


    AppSettings { id: settings }
}
