import QtQuick 2.12
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.12

Item {
    id: root

    property string plName: "Playlist name"
    property int _index: 0

    Item {
        id: header
        width: parent.width
        height: 99

        Row {
            id: rooooow
            x: 10
            height: parent.height /2 - 1
            spacing: 5

            Image {
                id: icon
                source: "/images/music-playlist"
                visible: false
            }

            ColorOverlay {
                id: coloredicon
                anchors.verticalCenter: parent.verticalCenter
                source: icon
                color: _textColor
                width: 25
                height: 25
                opacity: 0.8
            }

            CustomText { text: plName; textSize: 2; clip: true; width: header.width - 100 }
        }

        Row {
            x: 10
            anchors.rightMargin: 10
            anchors.top: rooooow.bottom
            height: parent.height / 2 - 1
            spacing: 5

            CustomButton {
                id: addBtn
                buttonText: "Back"
                width: 100
                height: 30
                anchors.verticalCenter: parent.verticalCenter
                onClicked: {
                    _currentPage.visible = false
                    _currentPage = _musicPlaylistPage
                    _currentPage.visible = true
                    _initialItem = "playlists"
                }
            }
            CustomButton {
                id: removeBtn
                buttonText: "Remove"
                width: 100
                height: 30
                anchors.verticalCenter: parent.verticalCenter
                onClicked: {
                    _currentPage.visible = false
                    _currentPage = _musicPlaylistPage
                    _currentPage.visible = true
                    _initialItem = "playlists"
                }
            }
        }

        Rectangle {
            id: separator
            color: _textColor
            width: parent.width - 20
            height: 1
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: header.bottom
            opacity: 0.5
        }
    }

    Item {
        id: editing
        width: parent.width
        height: 200
        y: header.height

        Row {
            width: parent.width
            height: parent.height
            anchors.verticalCenter: parent.verticalCenter
            spacing: 5

            Image {
                id: bgImage
                source: "/images/music-playlist"
                width: parent.height - 20
                height: width
                anchors.verticalCenter: parent.verticalCenter
            }

            Column {
                y: 30
                height: parent.height
                spacing: 10
                CustomTextField {
                    id: plNameEdit
                    text: plName
                    y: 20
                    width: editing.width - bgImage.width - 15
                    onTextChanged: {
                        plName = text
                    }
                }

                CustomButton {
                    width: 80
                    height: 40
                    buttonText: "Set image"
                }

                Row {
                    spacing: 5
                    CustomButton {
                        width: 60
                        height: 40
                        buttonText: "Import"
                    }
                    CustomButton {
                        width: 60
                        height: 40
                        buttonText: "Export"
                    }
                }
            }
        }

        Rectangle {
            x: 10
            color: _textColor
            width: parent.width - 20
            height: 1
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            opacity: 0.5
        }
    }

    Row {
        y: header.height + 200
        width: parent.width - 20
        anchors.horizontalCenter: parent.horizontalCenter
        CustomButton {
            width: parent.width / 2
            buttonText: "Play"
        }
        CustomButton {
            width: parent.width / 2
            buttonText: "Add to queue"
        }
    }

    ScrollView {
        id: scroll
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width - 20
        height: parent.height - header.height - 240
        y: header.height + 240
        clip: true
        ScrollBar.vertical.interactive: false
        ScrollBar.horizontal.visible: false

        ListView {
            id: musicList
            model: 20
            delegate: MusicDelegate {
                _index: model.index
                width: scroll.width
                height: 40
                bgColor: !(index % 2) ? _toolBarBackGroundColor : _backGroundColor
            }
        }
    }
}
