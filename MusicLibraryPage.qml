import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0

Item {
    id: root

    Connections {
        target: library
        onLikeTrack: {
            for (let i = 0; i < listModel.count; ++i) {
                if (musicList.children[0].children[i]._cppIndex === id) {
                    musicList.children[0].children[i].likedIcon = true
                    break;
                }
            }
        }

        onUnsetFavouriteTrack: {
            for (let i = 0; i < listModel.count; ++i) {
                if (musicList.children[0].children[i]._cppIndex === id) {
                    musicList.children[0].children[i].likedIcon = false
                    break;
                }
            }
        }

        onSetTrackProperties: {
            musicList.model.append({
                                 _cIndex: pack[0],
                                 _title: pack[1],
                                 _artist: pack[2],
                                 _year: pack[4],
                                 _album: pack[3],
                                 _genre: pack[5],
                                 _rating: pack[6],
                                 _duration: pack[8],
                                 _like: pack[7]
            })
        }
    }

    Item {
        id: header
        width: parent.width
        height: width > 500 ? 50 : 99

        Row {
            id: roooow
            x: 10
            height: parent.width > 500 ? parent.height : parent.height / 2 - 1
            spacing: 5

            Image {
                id: icon
                source: "/images/music-library"
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

            CustomText { text: "Music library"; textSize: 2 }
        }

        Row {
            x: 10
            anchors.rightMargin: 10
            anchors.top: parent.width > 500 ? parent.top : roooow.bottom
            anchors.right: parent.right
            height: parent.width > 500 ? parent.height : parent.height / 2 - 1
            spacing: 5

            CustomButton {
                id: addBtn
                buttonText: "Add"
                width: 40
                height: 30
                anchors.verticalCenter: parent.verticalCenter
                onClicked: _files.open()
            }
            CustomButton {
                id: addFolderBtn
                buttonText: "Add from folder"
                width: 130
                height: 30
                anchors.verticalCenter: parent.verticalCenter
                onClicked: _folders.open()
            }
            CustomButton {
                id: removeBtn
                buttonText: "Delete all"
                width: 100
                height: 30
                anchors.verticalCenter: parent.verticalCenter
                onClicked: console.log("remove from library")
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

    DropArea {
        id: dropArea;
        anchors.fill: parent
        onEntered: {
            drag.accept (Qt.LinkAction)
        }
        onDropped: {
            console.log(drop.urls)
        }
    }

    ScrollView {
        id: scroll
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width - 20
        height: parent.height - header.height
        y: header.height
        clip: true
        ScrollBar.vertical.interactive: false
        ScrollBar.horizontal.visible: false

        ListView {
            id: musicList
            model: ListModel { id: listModel }
            delegate: MusicDelegate {
                _index: model.index
                _cppIndex: _cIndex
                width: scroll.width
                height: 40
                bgColor: !(index % 2) ? _toolBarBackGroundColor : _backGroundColor
                title: _title
                artist: _artist
                year: _year
                album: _album
                genre: _genre
                rating: _rating
                duration: _duration
                likedIcon: _like
            }
        }
    }
}
