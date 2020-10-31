import QtQuick 2.14
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.14

Rectangle {
    property bool openedToolBar: false
    id: mainToolBar
    color: _toolBarBackGroundColor
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
            visible: _isAuthorized
        }

        Rectangle {
            id: separator
            width: parent.width > 50 ? parent.width - 10 : parent.width
            height: 2
            color: _textColor
            anchors.horizontalCenter: parent.horizontalCenter
            opacity: 0.3
            visible: openedToolBar
        }

        ButtonGroup { id: btnGroup }
        ToolBtn {
            buttonGroup: btnGroup
            imgSource: "/images/music-queue"
            buttonText: "Music queue"
            visible: _isAuthorized
        }

        ToolBtn {
            buttonGroup: btnGroup
            imgSource: "/images/clock"
            buttonText: "Recently played"
            visible: _isAuthorized
        }

        ToolBtn {
            buttonGroup: btnGroup
            imgSource: "/images/music-library"
            buttonText: "Music library"
            visible: _isAuthorized
        }

        ToolBtn {
            buttonGroup: btnGroup
            imgSource: "/images/music-playlist"
            buttonText: "Playlists"
            visible: _isAuthorized
        }

        ToolBtn {
            buttonGroup: btnGroup
            imgSource: "/images/equalizer"
            buttonText: "Equalizer"
            visible: _isAuthorized
        }

        ToolBtn {
            buttonGroup: btnGroup
            imgSource: "/images/radio"
            buttonText: "Radio"
            visible: _isAuthorized
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
            _initialItem = "authorization"
        }
    }
    ToolBtn {
        id: settingsButton
        buttonGroup: btnGroup
        imgSource: "/images/settings"
        anchors.bottom: parent.bottom
        buttonText: "Settings"
        onClicked: {
            if (_initialItem !== "settings")
                mainStack.push("Properties.qml")
            _initialItem = "settings"
        }
    }
}
