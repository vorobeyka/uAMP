import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0

MouseArea {
    id: root

    property string bgColor: _backGroundColor
    property int _index: 0
    property bool likedIcon: true
    property bool isInQueue: false
    property string someText: ""
    Rectangle {
        id: backGround
        anchors.fill: parent
        color: bgColor
    }

    Row {
        width: parent.width
        height: parent.height

        Item {
            id: trackName
            width: parent.width > 250 ? parent.width < 400 ? parent.width * 0.6 : parent.width * 0.3 : parent.width
            height: 40
//            MouseArea {
//                id: playButton
//                width: 30
//                height: 40
//                anchors.left: parent.left

//                Image {
//                    id: playIcon
//                    width: 20
//                    height: 20
//                    anchors.centerIn: parent
//                    source: "/images/play"
//                    visible: false
//                }

//                ColorOverlay {
//                    id: playColoredIcon
//                    anchors.fill: playIcon
//                    source: playIcon
//                    color: _textColor
//                    opacity: 0.8
//                }

//            }
            CustomText { id: nameText; x: 10; text: "Track Name" }
        }
    }
    hoverEnabled: true
    onEntered: {
        backGround.color = _themeColor
    }
    onExited: {
        backGround.color = bgColor
    }
    onPressed: { backGround.color = _hoverColor }
    onReleased: {
        if (root.containsMouse) backGround.color = _themeColor
        else backGround.color = bgColor
    }
}
