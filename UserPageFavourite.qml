import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Item {
    Connections {
        target: library
        function onUnsetFavouriteTrack(id) {

            for (let i = 0; i < listModel.count; ++i) {
                if (listModel.get(i)._cIndex === id) {
                    listModel.remove(i, 1)
                    break;
                }
            }
        }

        function onSetFavouriteTrack(pack) {
            listModel.append({
                             "_cIndex": pack[0],
                             "_title": pack[1],
                             "_artist": pack[2],
                             "_year": pack[4],
                             "_album": pack[3],
                             "_genre": pack[5],
                             "_rating": pack[6],
                             "_duration": pack[8],
                             "_like": pack[7]
            })
        }
    }

    ScrollView {
        anchors.fill: parent
        id: scroll
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
