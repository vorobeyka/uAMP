import QtQuick 2.14
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.14

Rectangle {
    property bool openedToolBar: false
//    property int _page: CustomToolBar.CurrentPage.User
    id: mainToolBar
    color: _toolBarBackGroundColor
    height: parent.height - musicController.height
    width: openedToolBar ? parent.width * 0.3 : 50

//    enum CurrentPage {
//        Queue,
//        Library,
//        Playlists,
//        Equalizer,
//        Radio,
//        User,
//        Settings
//    }

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
            onClicked: {
                if (_initialItem !== "queue") {
//                    mainStack.pop()
//                    mainStack.push("MusicQueue.qml")
                    _currentPage.visible = false
                    _currentPage = _musicQueuePage
                    _currentPage.visible = true
                }
                _initialItem = "queue"
            }
        }

        ToolBtn {
            buttonGroup: btnGroup
            imgSource: "/images/music-library"
            buttonText: "Music library"
            visible: _isAuthorized
            onClicked: {
                if (_initialItem !== "library") {
//                    mainStack.pop()
//                    mainStack.push("MusicLibraryPage.qml")
                    _currentPage.visible = false
                    _currentPage = _musicLibraryPage
                    _currentPage.visible = true
                }
                _initialItem = "library"
            }
        }

        ToolBtn {
            buttonGroup: btnGroup
            imgSource: "/images/music-playlist"
            buttonText: "Playlists"
            visible: _isAuthorized
            onClicked: {
                if (_initialItem !== "playlists") {
//                    mainStack.pop()
//                    mainStack.push("MusicPlaylists.qml")
                    _currentPage.visible = false
                    _currentPage = _musicPlaylistPage
                    _currentPage.visible = true
                }
                _initialItem = "playlists"
            }
        }

        ToolBtn {
            buttonGroup: btnGroup
            imgSource: "/images/equalizer"
            buttonText: "Equalizer"
            visible: _isAuthorized
            onClicked: {
                if (_initialItem !== "equalizer") {
//                    mainStack.pop()
//                    mainStack.push("MusicEqualizer.qml")
                    _currentPage.visible = false
                    _currentPage = _musicEqualizerPage
                    _currentPage.visible = true
                }
                _initialItem = "equalizer"
            }
        }

        ToolBtn {
            buttonGroup: btnGroup
            imgSource: "/images/radio"
            buttonText: "Radio"
            visible: _isAuthorized
            onClicked: {
                if (_initialItem !== "radio") {
//                    mainStack.pop()
//                    mainStack.push("MusicRadio.qml")
                    _currentPage.visible = false
                    _currentPage = _musicRadioPage
                    _currentPage.visible = true
                }
                _initialItem = "radio"
            }
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
//            mainStack.pop()
            if (_initialItem != "authorization") {
                _currentPage.visible = false
                _currentPage = _authPage
                _currentPage.visible = true
            }

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
            if (_initialItem !== "settings") {
                _currentPage.visible = false
                _currentPage = _properties
                _currentPage.visible = true
//                mainStack.pop()
//                mainStack.push("Properties.qml")
            }
            _initialItem = "settings"
        }
    }
}
