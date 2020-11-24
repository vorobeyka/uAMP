import QtQuick 2.0
import QtGraphicalEffects 1.0
import QtQuick.Dialogs 1.2
import QtQuick.Controls 2.12

Item {
    Connections {
        target: library

        function onSetInQueue(pack) {
            listModel.append({
                             "_cIndex": pack[0],
                             "_title": pack[1],
                             "_artist": pack[2],
                             "_year": pack[4],
                             "_album": pack[3],
                             "_genre": pack[5],
                             "_rating": pack[6],
                             "_duration": pack[8],
                             "_like": pack[7],
                             "_queueIndex": pack[11]
            })
//            console.log(pack[])
        }

        function onClearQueue() { listModel.clear() }

        function onDeleteTrackFromLibrary(id) {
            for (let i = 0; i < listModel.count; ++i) {
                if (listModel.get(i)._cIndex === id) {
                    listModel.remove(i, 1)
                    i--;
                }
            }
        }

        function onDeleteTrackFromQueue(id) {
            for (let i = 0; i < listModel.count; ++i) {
                if (listModel.get(i)._queueIndex === id) {
                    listModel.remove(i, 1)
                    break;
                }
            }
        }
    }

    Dialog {
        id: saveDialog
        width: 200
        height: 150

        contentItem: Rectangle {
            anchors.fill: parent
            color: _backGroundColor
            Item {
                width: parent.width - 40
                height: 80
                anchors.horizontalCenter: parent.horizontalCenter
                Text {
                    y: 20
                    text: "Enter playlist name"
                    color: _textColor
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: Qt.application.font.pixelSize * 1.2
                }

                CustomTextField {
                    id: dialogText;
                    anchors.bottom: parent.bottom
                }
            }
            Row {
                height: 40
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 5
                CustomButton {
                    width: 50
                    buttonText: "Ok"
                    onClicked: {
                        console.log(dialogText.text)
                        saveDialog.close()
                    }
                }
                CustomButton {
                    width: 50
                    buttonText: "Cancel"
                    onClicked: saveDialog.close()
                }
            }
        }
    }

    Item {
        id: header
        width: parent.width
        height: parent.width > 500 ? 50 : 99

        Row {
            id: roooow
            x: 10
            height: parent.width > 500 ? parent.height - 1 : parent.height / 2 - 1
            spacing: 5

            Image {
                id: icon
                source: "/images/music-queue"
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

            CustomText { text: "Music queue"; textSize: 2 }
        }

        Row {
            anchors.rightMargin: 10
            anchors.top: parent.width > 500 ? parent.top : roooow.bottom
            anchors.right: parent.right
            height: parent.width > 500 ? parent.height : parent.height / 2 - 1
            spacing: 5

            CustomButton {
                id: addQueue
                buttonText: "Add"
                width: 50
                height: 30
                anchors.verticalCenter: parent.verticalCenter
                onClicked: {
                    musicList.model.append({})
                }
            }

            CustomButton {
                id: saveBtn
                buttonText: "Save as playlist"
                width: 120
                height: 30
                anchors.verticalCenter: parent.verticalCenter
                onClicked: { saveDialog.open() }
            }
            CustomButton {
                id: clearQueue
                buttonText: "Clear"
                width: 100
                height: 30
                anchors.verticalCenter: parent.verticalCenter
                onClicked: { library.deleteAllFromQueue() }
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
        width: parent.width
        height: 50
        y: header.height

        Row {
            x: 15
            anchors.verticalCenter: parent.verticalCenter
            spacing: 5
            CustomText { text: "Sort by: " }
            MouseArea {
                id: sortButton
                width: 60
                height: 20
                CustomText { id: sortText; color: _themeColor }
                onClicked: sortPopup.open()
                Component.onCompleted: {
                    let itemIndex = library.libSortedValue
                    sortText.text = sortRepeater.itemAt(itemIndex).modelText
                    sortRepeater.itemAt(itemIndex).checked = true
                }
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
                    id: sortRepeater
                    model: ["Unsorted", "Title", "Artist", "Album", "Rating", "Most played", "Newest", "Year"]
                    RadioButton {
                        width: parent.width
                        height: 20
                        checked: false
                        property int _index: index
                        property string modelText: modelData

                        indicator: Rectangle {
                            anchors.fill: parent
                            color: parent.checked ? _themeColor : _toolBarBackGroundColor
                            CustomText { x: 10; text: modelText }
                        }
                        onClicked: {
                            library.isBusy = true
                            sortPopup.close()
                            sortText.text = modelData
                            library.libSortedValue = _index
                        }
                    }
                }
            }
        }
    }

    ScrollView {
        id: scroll
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width - 20
        height: parent.height - header.height - 50
        y: 50 + header.height
        clip: true
        ScrollBar.vertical.interactive: false
        ScrollBar.horizontal.visible: false

        ListView {
            id: musicList
            model: ListModel { id: listModel }
            delegate: MusicDelegate {
                isInQueue: true
                _index: model.index
                _cppIndex: _cIndex
                _qIndex: _queueIndex
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
