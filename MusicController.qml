import QtQuick 2.14
import QtQuick.Controls 2.14
import QtGraphicalEffects 1.0

Item {
    id: root
    anchors.bottom: parent.bottom
    width: parent.width
    height: 80
    Drawer {
        id: animationDrawer
        width: root.width
        height: root.height

        Row {
            anchors.fill: parent
            spacing: 4

            AnimatedImage {
                id: animation
                source: "images/animation"
                width: settings.windowWidth
                height: settings.windowHeight

                Rectangle {
                    width: 50
                    height: 30
                    color: settings.themeColor
                    anchors.right: parent.right
                    anchors.top: parent.top

                    MouseArea {
                        anchors.fill: parent
                        onClicked: animationDrawer.close()
                    }

                    Text {
                        anchors.centerIn: parent
                        font.pointSize: 20
                        text: "\u25C0"
                    }
                }
            }
        }
    }
    Rectangle {
        anchors.fill: parent
        opacity: settings.opacityMusicCotnroll
        color: settings.themeColor

    }

    property bool gradientVisible: false
    property int xMouse: 0

    Row {
        anchors.fill: parent

        MouseArea {
            id: musicInfo
            height: parent.height
            width: parent.width * 0.25

            Rectangle {
                id: musicInfoBgColor
                anchors.fill: parent
                opacity: 0.5
                color: musicInfo.pressed ? settings.backGroundColor : settings.hoverColor
                visible: false
            }

            Row {
                anchors.fill: parent
                spacing: 10
                Rectangle {
                    id: musicImg
                    opacity: 0.5
                    color: settings.backGroundColor
                    height: parent.height
                    width: height
                    visible: 10 + width * 2 > parent.width ? false : true
                }

                Column {
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 8

                    Text {
                        id: musicName
                        text: qsTr("syka")
                        font.pixelSize: Qt.application.font.pixelSize * 1.2
                        color: settings.textColor
                    }

                    Text {
                        id: musicArtist
                        font.bold: true
                        text: qsTr("blyat")
                        font.pixelSize: Qt.application.font.pixelSize * 1.2
                        color: settings.textColor
                    }
                }
            }

            hoverEnabled: true
            onEntered: { musicInfoBgColor.visible = true }
            onPositionChanged: { xMouse = mouse.x }
            onExited: { musicInfoBgColor.visible = false }
        }

        Column {
            id: musicControls
            width: parent.width * 0.5
            height: parent.height
            spacing: 0

            Row {
                height: parent.height * 0.75
                anchors.horizontalCenter: parent.horizontalCenter
                MusicControllerButtonCheck {
                    onClicked: { isChecked = !isChecked }
                    imgSource: "images/random"
                }
                MusicControllerButton {
                    visible: root.width > 600 ? true : false
                    imgVisible: false
                    buttonText: qsTr("-10")
                }
                MusicControllerButton { imgSource: "images/back" }
                MusicControllerButton { imgSource: "images/stop" }
                MusicControllerButton { imgSource: "images/play"; size: 40}
                MusicControllerButton { imgSource: "images/pause" }
                MusicControllerButton { imgSource: "images/forward" }
                MusicControllerButton {
                    visible: root.width > 600 ? true : false
                    imgVisible: false
                    buttonText: qsTr("+10")
                }
                MusicControllerButtonCheck {
                    onClicked: { isChecked = !isChecked }
                    imgSource: "images/repeat"
                }
            }
            Row {
                height: parent.height * 0.25
                width: parent.width - 20
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    id: currentAudioDuration
                    text: qsTr("syka")
                    color: settings.textColor
                    font.pixelSize: Qt.application.font.pixelSize * 1.2
                    anchors.verticalCenter: parent.verticalCenter
                }

                CustomSlider {
                    height: parent.height
                    width: parent.width - currentAudioDuration.width - audioDuration.width
                }

                Text {
                    id: audioDuration
                    text: qsTr("blyat")
                    color: settings.textColor
                    font.pixelSize: Qt.application.font.pixelSize * 1.2
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }
        Item {
            id: volumeControls
            height: parent.height
            width: parent.width * 0.25
            Row {
                anchors.centerIn: parent
                spacing: 5
                Item {
                    id: musicVolume
                    anchors.verticalCenter: parent.verticalCenter
                    width: icon.width
                    height: icon.height
                    Image {
                        id: icon
                        width: 20
                        height: 20
                        anchors.centerIn: parent
                        source: "images/volume"
                        visible: false
                    }
                    ColorOverlay {
                        id: coloredIcon
                        anchors.fill: icon
                        source: icon
                        color: settings.textColor
                    }
                }
                CustomSlider {
                    anchors.verticalCenter: parent.verticalCenter
                    height: 20
                    width: 100
                }
                MusicControllerButton {
                    visible: root.width >= 700 ? true : false
                    imgSource: "images/full-screen"
                    onClicked: { animationDrawer.open() }
                }
            }
        }
    }
}
