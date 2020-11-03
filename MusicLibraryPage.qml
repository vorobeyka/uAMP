import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0

Item {
    id: root

    Item {
        id: header
        width: parent.width
        height: 50

        Row {
            x: 10
            height: parent.height - 1
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
            anchors.rightMargin: 10
            anchors.right: parent.right
            height: parent.height - 1
            spacing: 5

            CustomButton {
                id: addBtn
                buttonText: "Add"
                width: 100
                height: 30
                anchors.verticalCenter: parent.verticalCenter
                onClicked: {
                    musicList.model.append({})
                    console.log("add to library")
                }
            }
//            CustomButton {
//                id: removeBtn
//                buttonText: "Remove"
//                width: 100
//                height: 30
//                anchors.verticalCenter: parent.verticalCenter
//                onClicked: console.log("remove from library")
//            }
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

    ScrollView {
        id: scroll
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width - 20
        height: parent.height - 50
        y: 50
        clip: true
        ScrollBar.vertical.interactive: false
        ScrollBar.horizontal.visible: false

        ListView {
            id: musicList
            model: ListModel {}
            delegate: MusicDelegate {
                _index: model.index
                width: scroll.width
//                someText: appendText ? appendText : ""
                height: 40
                bgColor: !(index % 2) ? _toolBarBackGroundColor : _backGroundColor
            }
        }
    }
}
