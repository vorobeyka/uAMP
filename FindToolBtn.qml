import QtQuick 2.0
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0

Rectangle {
    property string imgSource: ""
    property int toolBtnWidth: 0
    property int toolBtnHeight: 0
    property bool gradientVisible: false
    property int xMouse: 0

    id: root
    height: toolBtnHeight
    color: width > 50 ? _backGroundColor : _toolBarBackGroundColor

    TextField {
        id: searchField
        width: parent.width - 2 - _toolButtonHeight
        visible: openedToolBar
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: Qt.application.font.pixelSize * 1.2
        color: _textColor
        background: Rectangle {
            anchors.fill: parent
            color: _backGroundColor
            border.color: _backGroundColor
        }
    }

    MouseArea {
        width: height
        height: parent.height
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        Image {
            id: searchIcon
            source: imgSource
            visible: false
        }
        ColorOverlay {
            id: coloredSearchIcon
            anchors.centerIn: parent
            source: searchIcon
            color: _textColor
            width: 25
            height: 25
            opacity: 0.8
        }

        CustomGradient {
            visible: gradientVisible
            xxMouse: xMouse
        }

        hoverEnabled: true
        onEntered: { gradientVisible = true }
        onPositionChanged: { xMouse = mouse.x }
        onExited: { gradientVisible = false }
        onClicked: {
            if (!openedToolBar) {
                openedToolBar = true
                searchField.focus = true
            } else {
                console.log("syka blyat")
            }
        }
    }
}
