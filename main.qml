import QtQuick 2.14
import QtQuick.Window 2.14
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.2
import QtGraphicalEffects 1.14

Window {
    property bool _isbusy: library.isBusy
    property int _windowWidth: root.width
    property int _windowHeight: root.height
    property string _userName: Settings.userName
    property string _userPassword: ""
    property string _initialItem: ""
    property bool _isAuthorized: Settings.authorized
    property string _backGroundColor: Settings.backGroundColor//""//"#303030"
    property string _toolBarBackGroundColor: Settings.toolBarColor//""//"#404040"
    property string _themeColor: Settings.themeColor//""//"#12CBC4"
    property string _textColor: Settings.textColor//""//"white"
    property string _hoverColor: Settings.hoverColor//""//"#BEC3C6"
    property int _toolButtonHeight: 50
    property double _opacityMusicCotnroll: 0.8
    property double _opacityGradient: 0.5
//    property StackView mainStack: stackView
    property Window _tagEditor: tagEditor
    property BusyIndicator busy: control
    property FileDialogFiles _files: files
    property FileDialogFiles _folders: folders

    property Item _currentPage: _authPage
    property AuthorizationPage _authPage: authPage
    property MusicQueue _musicQueuePage: musicQueuePage
    property MusicLibraryPage _musicLibraryPage: musicLibraryPage
    property MusicPlaylists _musicPlaylistPage: musicPlaylistPage
    property MusicPlaylistEdit _musicPlaylistEditPage: musicPlaylistEditPage
    property MusicEqualizer _musicEqualizerPage: musicEqualizerPage
    property MusicRadio _musicRadioPage: musicRadioPage
    property Properties _properties: properties

    FileDialogFiles {
        id: files
        onAccepted: {
            library.isBusy = true
            for (var i = 0; i < fileUrls.length; ++i)
                library.readFile(fileUrls[i].toString(), 1)
            library.isBusy = false
        }
    }
    FileDialogFiles {
        id: folders
        selectFolder: true
        onAccepted: {
            library.isBusy = true
            library.readFolder(fileUrl.toString())
            library.isBusy = false
        }
    }

    id: root
    minimumWidth: 450
    minimumHeight: 570
    width: 800
    height: 680
    visible: true
    title: qsTr("UAMP")
    color: _backGroundColor

    CustomToolBar { id: mainToolBar }

    Item {
        id: stackView
        x: mainToolBar.width
        width: parent.width - mainToolBar.width
        height: parent.height - musicController.height
        clip: true

        AuthorizationPage { id: authPage; anchors.fill: parent; visible: true }

        MusicQueue { id: musicQueuePage; anchors.fill: parent; visible: false }

        MusicLibraryPage { id: musicLibraryPage; anchors.fill: parent; visible: false }

        MusicPlaylists { id: musicPlaylistPage; anchors.fill: parent; visible: false }

        MusicPlaylistEdit { id: musicPlaylistEditPage; anchors.fill: parent; visible: false }

        MusicEqualizer { id: musicEqualizerPage; anchors.fill: parent; visible: false }

        MusicRadio { id: musicRadioPage; anchors.fill: parent; visible: false }

        Properties { id: properties; anchors.fill: parent; visible: false }
    }


//    StackView {
//        id: stackView
//        initialItem: "AuthorizationPage.qml"
//        x: mainToolBar.width
//        width: parent.width - mainToolBar.width
//        height: parent.height - musicController.height
//        clip: true
//        Component.onCompleted: {
//            stackView.push("MusicLibraryPage.qml")
//        }
//    }

    MusicController { id: musicController }

    Window {
        id: tagEditor
        minimumWidth: 480
        minimumHeight: 600
        maximumHeight: 600
        maximumWidth: 480
        title: "Tag editor"
        color: _backGroundColor
        Rectangle {
            id: tagHedaer
            width: parent.width
            height: 200
            color: _backGroundColor

            Image {
                width: 150
                height: 150
                source: "/images/music-note"
                anchors.verticalCenter: parent.verticalCenter
            }

            Column {
                y: 30
                width: parent.width - 150
                height: parent.height - 30
                anchors.right: parent.right
                spacing: 5
                Text { x:10; text: "Title"; color: _textColor; font.pixelSize: Qt.application.font.pixelSize * 1.2 }
                CustomTextField { id: trackTitle }
                Text { x: 10; text: "Artist"; color: _textColor; font.pixelSize: Qt.application.font.pixelSize * 1.2 }
                CustomTextField {id: trackArtist }
                Text { x: 10; text: "Year"; color: _textColor; font.pixelSize: Qt.application.font.pixelSize * 1.2 }
                CustomTextField {id: trackYear }
            }
        }

        Column {
            id: tagContent
            width: parent.width
            height: parent.height - tagHedaer.height - tagBottom.height
            anchors.top: tagHedaer.bottom
            spacing: 5

            Text { x:10; text: "Album"; color: _textColor; font.pixelSize: Qt.application.font.pixelSize * 1.2 }
            CustomTextField { id: trackAlbum }
            Text { x: 10; text: "Genre"; color: _textColor; font.pixelSize: Qt.application.font.pixelSize * 1.2 }
            CustomTextField {id: trackGenre }
//            Text { text: "Year"; color: _textColor; font.pixelSize: Qt.application.font.pixelSize * 1.2 }
//            CustomTextField { inputMethodHints: Qt.ImhNone }
            Text { x: 10; text: "File path"; color: _textColor; font.pixelSize: Qt.application.font.pixelSize * 1.2 }
            CustomTextField { id: filePath; readOnly: true }
            Text { x: 10; text: "Lyrics"; color: _textColor; font.pixelSize: Qt.application.font.pixelSize * 1.2 }
            Flickable {
                id: trackLyrics
                width: parent.width
                height: 150
                TextArea.flickable: TextArea {
                    id: lyricsTxtArea
                    anchors.fill: parent
                    color: _textColor
                    background: Rectangle {
                        anchors.fill: parent
                        color: _backGroundColor
                        border.color: lyricsTxtArea.activeFocus ? _themeColor : _textColor
                    }
                }
            }
        }

        Item {
            id: tagBottom
            width: parent.width
            height: 50
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom

            CustomButton {
                id: okBtn
                buttonText: "Ok"
                anchors.verticalCenter: parent.verticalCenter
                x: parent.width / 2 - 150
                width: 100
                onClicked: tagEditor.close()
            }

            CustomButton {
                id: cancelBtn
                buttonText: "Cancel"
                anchors.verticalCenter: parent.verticalCenter
                x: parent.width / 2 + 50
                width: 100
                onClicked: tagEditor.close()
            }
        }
    }
    BusyIndicator {
        id: control
        running: _isbusy
        x: root.width / 2 - 32
        y: root.height / 2 - 32
        contentItem: Item {
            implicitWidth: 64
            implicitHeight: 64

            Item {
                id: item
                x: parent.width / 2 - 32
                y: parent.height / 2 - 32
                width: 64
                height: 64
                opacity: control.running ? 1 : 0

                Behavior on opacity {
                    OpacityAnimator {
                        duration: 250
                    }
                }

                RotationAnimator {
                    target: item
                    running: control.visible && control.running
                    from: 0
                    to: 360
                    loops: Animation.Infinite
                    duration: 1250
                }

                Repeater {
                    id: repeater
                    model: 6

                    Rectangle {
                        x: item.width / 2 - width / 2
                        y: item.height / 2 - height / 2
                        implicitWidth: 10
                        implicitHeight: 10
                        radius: 5
                        color: _themeColor
                        transform: [
                            Translate {
                                y: -Math.min(item.width, item.height) * 0.5 + 5
                            },
                            Rotation {
                                angle: index / repeater.count * 360
                                origin.x: 5
                                origin.y: 5
                            }
                        ]
                    }
                }
            }
        }
    }
    Component.onCompleted: {
        Settings.isBusy = false
        if (_isAuthorized) library.setUser(_userName)
    }
    Component.onDestruction: console.log("syka zakrili")
}
