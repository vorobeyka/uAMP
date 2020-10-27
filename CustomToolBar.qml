import QtQuick 2.14
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.14

Rectangle {
    property bool openedToolBar: true
    id: mainToolBar
    color: settings.toolBarBackGroundColor
    height: parent.height - musicController.height
    width: openedToolBar ? parent.width * 0.3 : 50

    Column {
        id: columnButtons
        width: parent.width
        height: parent.height
        spacing: 3


        ToolBarButtonMain { id: toolButton }

        FindToolBtn {
            id: findButton
            imgSource: "/images/find-icon"
            toolBtnHeight: toolButton.height
            toolBtnWidth: toolButton.width
            width: parent.width > 50 ? parent.width - 10 : parent.width - 2
            anchors.horizontalCenter: parent.horizontalCenter
            visible: isToolBarVisible
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
            visible: isToolBarVisible
        }

        ToolBtn {
            buttonGroup: btnGroup
            imgSource: "/images/clock"
            buttonText: "Recently played"
            visible: isToolBarVisible
        }

        ToolBtn {
            buttonGroup: btnGroup
            imgSource: "/images/music-library"
            buttonText: "Music library"
            visible: isToolBarVisible
        }

        ToolBtn {
            buttonGroup: btnGroup
            imgSource: "/images/music-playlist"
            buttonText: "Playlists"
            visible: isToolBarVisible
        }

        ToolBtn {
            buttonGroup: btnGroup
            imgSource: "/images/equalizer"
            buttonText: "Equalizer"
            visible: isToolBarVisible
        }

        ToolBtn {
            buttonGroup: btnGroup
            imgSource: "/images/radio"
            buttonText: "Radio"
            visible: isToolBarVisible
        }

        ToolBtn {
            buttonGroup: btnGroup
            imgSource: "/images/like"
            buttonText: "Favourite"
            visible: isToolBarVisible
        }
    }
    ToolBtn {
        id: accountButton
        buttonGroup: btnGroup
        imgSource: "/images/user"
        buttonText: "Account"
        _checked: true
        anchors.bottom: settingsButton.top
        onClicked: {
            mainStack.pop("AuthorizationPage.qml")
            settings.initialItem = "authorization"
        }
    }
    ToolBtn {
        id: settingsButton
        buttonGroup: btnGroup
        imgSource: "/images/settings"
        anchors.bottom: parent.bottom
        buttonText: "Settings"
        onClicked: {
            if (settings.initialItem !== "settings")
                mainStack.push("Settings.qml")
            settings.initialItem = "settings"
        }
    }
}
