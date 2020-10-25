import QtQuick 2.0
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0

Rectangle {
    property string imgSource: ""
    property int toolBtnWidth: 0
    property int toolBtnHeight: 0
    id: root
    height: toolBtnHeight
    color: width > 50 ? settings.backGroundColor : settings.toolBarBackGroundColor

    TextField {
        id: searchField
        width: parent.width - 2 - settings.toolButtonHeight
        visible: openedToolBar
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: Qt.application.font.pixelSize * 1.2
        color: settings.textColor
        background: Rectangle {
            anchors.fill: parent
            color: settings.backGroundColor
            border.color: settings.backGroundColor
        }
    }

    Button {
        width: height
        height: parent.height
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        flat: true
        Image {
            id: searchIcon
            source: imgSource
            visible: false
        }
        ColorOverlay {
            id: coloredSearchIcon
            anchors.centerIn: parent
            source: searchIcon
            color: settings.textColor
            width: 25
            height: 25
        }

        onClicked: {
            if (!openedToolBar) {
                openedToolBar = true
                searchField.focus = true
            } else {
                console.log("syka blyat")
            }
        }
    }
//    Button {
//        visible: !openedToolBar
//        width: toolBtnWidth
//        height: toolBtnHeight
//        flat: true

//        Image {
//            id: searchIconClosed
//            source: imgSource
//            visible: false
//        }
//        ColorOverlay {
//            id: coloredSearchIconClosed
//            anchors.centerIn: parent
//            source: searchIconClosed
//            color: settings.textColor
//            width: 25
//            height: 25
//        }
//        onClicked: {
//            openedToolBar = true
//            searchField.focus = true
//        }
//    }
    AppSettings { id: settings }
}
