import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0

MouseArea {
    id: root

    property string bgColor: _backGroundColor
    property int _index: 0
    property bool likedIcon: true
    property string someText: ""

    Rectangle {
        id: backGround
        anchors.fill: parent
        color: bgColor

        StarsWrapper {
            id: starsWrapper
            anchors.right: likeWrapper.left
            visible: root.width > 300
            width: root.width > 300 ? 100 : 0
        }

        Item {
            id: likeWrapper
            width: 40
            height: 40
            anchors.right: trackDuration.left

            MouseArea {
                anchors.fill: parent

                Image {
                    id: likeIcon
                    width: 20
                    height: 20
                    anchors.centerIn: parent
                    source: likedIcon ? "/images/like" : "/images/liked"
                    visible: false
                }

                ColorOverlay {
                    id: likeColoredIcon
                    anchors.fill: likeIcon
                    source: likeIcon
                    color: _textColor
                    opacity: 0.8
                }
                onClicked: likedIcon = !likedIcon
            }
        }

        Item {
            id: trackDuration
            width: 40
            height: 40
            anchors.right: parent.right
            CustomText { text: "time" }
        }
    }

    Row {
        width: parent.width - likeWrapper.width - trackDuration.width - starsWrapper.width
        height: parent.height

        Item {
            id: trackName
            width: parent.width > 250 ? parent.width < 400 ? parent.width * 0.6 : parent.width * 0.3 : parent.width
            height: 40
            CustomText { id: nameText; x:5; text: "Track Name" }
            Item {
                id: trackButtons
                height: 40
                width: 60
                visible: false
                anchors.right: parent.right
                MouseArea {
                    id: playButton
                    width: 30
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
                    width: 30
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

                    onClicked: addPopup.open()

                    Popup {
                        id: addPopup
                        width: 120
                        height: 80
                        padding: 0
                        x: parent.x
                        y: parent.y
                        modal: true
                        focus: true

                        Column {
                            id: column
                            Repeater {
                                model: ["Add to queue", "Tag it"]
                                MouseArea {
                                    id: btnWrapper
                                    width: 120
                                    height: 40

                                    Rectangle {
                                        anchors.fill: parent
                                        color: _backGroundColor
                                    }

                                    Image {
                                        id: btnIcon
                                        width: 20
                                        height: 20
                                        source: !index ? "/images/music-queue" : "/images/music-note"
                                        visible: false
                                        anchors.verticalCenter: parent.verticalCenter
                                    }

                                    ColorOverlay {
                                        id: btnColoredIcon
                                        anchors.fill: btnIcon
                                        source: btnIcon
                                        color: _textColor
                                        opacity: 0.8
                                    }

                                    CustomText { text: modelData; x: 30 }

                                    onClicked: {
                                        addPopup.close()
                                        if (index === 1)
                                            _tagEditor.show()
//                                        console.log(modelData)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        Item {
            id: trackArtist
            width: parent.width < 400 ? parent.width * 0.4 : parent.width * 0.2
            height: 40
            visible: parent.width > 250
            CustomText { text: "Artist" }
        }
        Item {
            id: trackAlbum
            width: parent.width * 0.2
            height: 40
            visible: parent.width > 500
            CustomText { text: "Album" }
        }
        Item {
            id: trackYear
            width: parent.width - trackName.width - trackAlbum.width - trackArtist.width - trackGenre.width
            height: 40
            visible: parent.width > 400
            CustomText { text: "Year" }
        }
        Item {
            id: trackGenre
            width: parent.width * 0.2
            height: 40
            visible: parent.width > 400
            CustomText { text: "Genre" }
        }
    }

    hoverEnabled: true
    onEntered: { trackButtons.visible = true }
    onExited: { trackButtons.visible = false }
}
