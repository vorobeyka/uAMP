import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0

MouseArea {
    id: root

    property string bgColor: _backGroundColor
    property int _index: 0

    Rectangle {
        id: backGround
        anchors.fill: parent
        color: bgColor

        Item {
            id: tackDuration
            width: 40
            height: 40
            anchors.right: parent.right
            CustomText { text: "time" }
        }
    }

    Row {
        width: parent.width - 40
        height: parent.height

        Item {
            id: trackName
            width: parent.width < 500 ? parent.width * 0.6 : parent.width * 0.3
            height: 40
            CustomText { id: nameText; text: "Track Name" }
            Item {
                id: trackButtons
                height: 40
                width: height * 2
                visible: false
                anchors.right: parent.right
                MouseArea {
                    id: playButton
                    width: 40
                    height: 40
                    anchors.left: parent.left

                    Image {
                        id: playIcon
                        width: 20
                        height: 20
                        anchors.centerIn: parent
                        source: "/images/play"
                        visible: false
                    }

                    ColorOverlay {
                        id: playColoredIcon
                        anchors.fill: playIcon
                        source: playIcon
                        color: _textColor
                        opacity: 0.8
                    }

                }
                MouseArea {
                    id: addToPlaylistButton
                    width: 40
                    height: 40
                    anchors.right: parent.right

                    Image {
                        id: addIcon
                        width: 20
                        height: 20
                        anchors.centerIn: parent
                        source: "/images/add"
                        visible: false
                    }

                    ColorOverlay {
                        id: addColoredIcon
                        anchors.fill: addIcon
                        source: addIcon
                        color: _textColor
                        opacity: 0.8
                    }

                    onClicked: console.log("blyat")

                    Popup {
                        id: sortPopup
                        width: 100
                        padding: 0
                        x: 100
                        modal: true
                        focus: true
                        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent

                        Column {
                            id: column
                            spacing: 0
                            anchors.fill: parent

                        }
                    }

                }
            }
        }

        Item {
            id: trackArtist
            width: parent.width < 500 ? parent.width * 0.4 : parent.width * 0.2
            height: 40
            CustomText { text: "Artist" }
        }
        Item {
            id: trackAlbum
            width: parent.width * 0.2
            height: 40
            visible: root.width > 700
            CustomText { text: "Album" }
        }
        Item {
            id: trackYear
            width: parent.width - trackName.width - trackAlbum.width - trackArtist.width - trackGenre.width
            height: 40
            visible: root.width > 502
            CustomText { text: "Year" }
        }
        Item {
            id: trackGenre
            width: parent.width * 0.2
            height: 40
            visible: root.width > 502
            CustomText { text: "Genre" }
        }
    }

    hoverEnabled: true
    onEntered: { trackButtons.visible = true }
    onExited: { trackButtons.visible = false }
}
