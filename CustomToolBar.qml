import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.15

Rectangle {
    property bool openedToolBar: true

    id: mainToolBar
    color: settings.toolBarBackGroundColor
    height: parent.height - musicController.height
    width: openedToolBar ? parent.width * 0.3 : 50

    Column {
        id: columnButtons
        width: parent.width
        spacing: 3

        ToolBarButtonMain { id: toolButton }

        FindToolBtn {
            id: findButton
            imgSource: "/images/find-icon"
            toolBtnHeight: toolButton.height
            toolBtnWidth: toolButton.width
            width: parent.width > 50 ? parent.width - 10 : parent.width - 2
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Rectangle {
            id: separator
            width: parent.width > 50 ? parent.width - 10 : parent.width
            height: 2
            color: settings.textColor
            anchors.horizontalCenter: parent.horizontalCenter
            opacity: 0.3
            visible: openedToolBar
        }

        ButtonGroup { id: btnGroup }
        ToolBtn {
            buttonGroup: btnGroup
            imgSource: "/images/music-queue"
            buttonText: "Music queue"
        }

        ToolBtn {
            buttonGroup: btnGroup
            imgSource: "/images/clock"
            buttonText: "Recently played"
        }


        ToolBtn {
            buttonGroup: btnGroup
            imgSource: "/images/music-library"
            buttonText: "Music library"
        }

        ToolBtn {
            buttonGroup: btnGroup
            imgSource: "/images/music-playlist"
            buttonText: "Playlists"
        }

        ToolBtn {
            buttonGroup: btnGroup
            imgSource: "/images/equalizer"
            buttonText: "Equalizer"
        }

        ToolBtn {
            buttonGroup: btnGroup
            imgSource: "/images/radio"
            buttonText: "Radio"
        }

        ToolBtn {
            buttonGroup: btnGroup
            imgSource: "/images/like"
            buttonText: "Favourite"
        }
    }
    ToolBtn {
        buttonGroup: btnGroup
        imgSource: "/images/settings"
        anchors.bottom: parent.bottom
        buttonText: "Settings"
    }
}
