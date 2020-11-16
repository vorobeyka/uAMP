import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

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
                    musicList.children[0].children[i].likedIcon= false
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
        width: parent.width
        height: 50

        Row {
            x: 15
            anchors.verticalCenter: parent.verticalCenter
            spacing: 5
            CustomText { text: "Sort by: " }
            MouseArea {
                id: sortButton
                width: 60
                height: 20
                CustomText { id: sortText; text: "Title"; color: _themeColor }
                onClicked: sortPopup.open()
            }
        }

        Popup {
            id: sortPopup
            width: 100
            padding: 0
            x: 100
            modal: true
            focus: true

            Column {
                spacing: 0
                anchors.fill: parent
                Repeater {
                    model: ["Title", "Artist", "Album", "Rating", "Most played", "Newest", "Year"]
                    RadioButton {
                        width: parent.width
                        height: 20
                        checked: !index ? true : false

                        indicator: Rectangle {
                            anchors.fill: parent
                            color: parent.checked ? _themeColor : _toolBarBackGroundColor
                            CustomText { x: 10; text: modelData }
                        }
                        onClicked: {
                            sortPopup.close()
                            sortText.text = modelData
                            if (modelData == "Year") {
                                for (let i = 0; i < musicList.count - 1; ++i) {
                                    for (let j = i + 1; j < musicList.count; ++j) {
                                        if (musicList.children[0].children[j].year < musicList.children[0].children[i].year) {
                                            swapModelList(i, j)
                                        }
                                    }
                                }
                            }
                            if (modelData == "Newest") {
                                for (let i = 0; i < musicList.count - 1; ++i) {
                                    for (let j = i + 1; j < musicList.count; ++j) {
                                        if (musicList.children[0].children[j].date < musicList.children[0].children[i].date) {
                                            swapModelList(i, j)
                                        }
                                    }
                                }
                            }
                            if (modelData == "Most played") {
                                for (let i = 0; i < musicList.count - 1; ++i) {
                                    for (let j = i + 1; j < musicList.count; ++j) {
                                        if (musicList.children[0].children[j].playedTimes < musicList.children[0].children[i].playedTimes) {
                                            swapModelList(i, j)
                                        }
                                    }
                                }
                            }
                            if (modelData == "Title") {
                                for (let i = 0; i < musicList.count - 1; ++i) {
                                    for (let j = i + 1; j < musicList.count; ++j) {
                                        if (musicList.children[0].children[j].title < musicList.children[0].children[i].title) {
                                            swapModelList(i, j)
                                        }
                                    }
                                }
                            }
                            if (modelData == "Artist") {
                                for (let i = 0; i < musicList.count - 1; ++i) {
                                    for (let j = i + 1; j < musicList.count; ++j) {
                                        if (musicList.children[0].children[j].artist < musicList.children[0].children[i].artist) {
                                            swapModelList(i, j)
                                        }
                                    }
                                }
                            }
                            if (modelData == "Album") {
                                for (let i = 0; i < musicList.count - 1; ++i) {
                                    for (let j = i + 1; j < musicList.count; ++j) {
                                        if (musicList.children[0].children[j].album < musicList.children[0].children[i].album) {
                                            swapModelList(i, j)
                                        }
                                    }
                                }
                            }
                            if (modelData == "Rating") {
                                for (let i = 0; i < musicList.count - 1; ++i) {
                                    for (let j = i + 1; j < musicList.count; ++j) {
                                        if (musicList.children[0].children[j].rating < musicList.children[0].children[i].rating) {
                                            swapModelList(i, j)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    function swapModelList(a, b) {
        let tmp = musicList.children[0].children[a].title
        musicList.children[0].children[a].title = musicList.children[0].children[b].title
        musicList.children[0].children[b].title = tmp
        tmp = musicList.children[0].children[a].artist
        musicList.children[0].children[a].artist = musicList.children[0].children[b].artist
        musicList.children[0].children[b].artist = tmp
        tmp = musicList.children[0].children[a].year
        musicList.children[0].children[a].year = musicList.children[0].children[b].year
        musicList.children[0].children[b].year = tmp
        tmp = musicList.children[0].children[a].album
        musicList.children[0].children[a].album = musicList.children[0].children[b].album
        musicList.children[0].children[b].album = tmp
        tmp = musicList.children[0].children[a].genre
        musicList.children[0].children[a].genre = musicList.children[0].children[b].genre
        musicList.children[0].children[b].genre = tmp
        tmp = musicList.children[0].children[a].rating
        musicList.children[0].children[a].rating = musicList.children[0].children[b].rating
        musicList.children[0].children[b].rating = tmp
        tmp = musicList.children[0].children[a].duration
        musicList.children[0].children[a].duration = musicList.children[0].children[b].duration
        musicList.children[0].children[b].duration = tmp
        tmp = musicList.children[0].children[a].likedIcon
        musicList.children[0].children[a].likedIcon = musicList.children[0].children[b].likedIcon
        musicList.children[0].children[b].likedIcon = tmp
        tmp = musicList.children[0].children[a]._cppIndex
        musicList.children[0].children[a]._cppIndex = musicList.children[0].children[b]._cppIndex
        musicList.children[0].children[b]._cppIndex = tmp
        tmp = musicList.children[0].children[a].playedTimes
        musicList.children[0].children[a].playedTimes = musicList.children[0].children[b].playedTimes
        musicList.children[0].children[b].playedTimes = tmp
        tmp = musicList.children[0].children[a].date
        musicList.children[0].children[a].date = musicList.children[0].children[b].date
        musicList.children[0].children[b].date = tmp
    }

    ScrollView {
        id: scroll
        width: parent.width
        height: parent.height - 50
        y: 50
        clip: true
        ScrollBar.vertical.interactive: false
        ScrollBar.horizontal.visible: false

        ListView {
            id: musicList
            model: ListModel { id:listModel }
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
